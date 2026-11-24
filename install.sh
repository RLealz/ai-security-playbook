#!/usr/bin/env bash
# ==============================================================================
# AI Security Playbook — Vault-First Quarantine-Auditing Skill Installer (Bash)
# ==============================================================================
# Installs built-in MIT Meta-Skills (security-router + 7 Combos) and selectively
# fetches upstream security skills from GitHub using git sparse-checkout and
# scripts/scan_quarantine.py.
#
# Routes 'defensive' skills -> active skills directory
# Routes 'vault' skills     -> isolated security vault (<TargetDir>-vault-security)
#
# Usage:
#   ./install.sh --list
#   ./install.sh --router [--target claude|global-claude|cursor|antigravity|codex|/custom/path]
#   ./install.sh --combo appsec-code-audit [--tier defensive|vault|all] [--target ...]
#   ./install.sh --skill vibe-shield [--target ...]
#   ./install.sh --skill cyber-monster [--vault-dir /path/to/vault] [--allow-vault-warnings]
# ==============================================================================

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REGISTRY_PATH="$REPO_ROOT/registry.json"
SCANNER_PY="$REPO_ROOT/scripts/scan_quarantine.py"

ACTION=""
ARG_VAL=""
TARGET="claude"
VAULT_DIR=""
TIER="all"
FORCE_ACTIVE=0
ALLOW_DOC_WARNINGS=0
ALLOW_VAULT_WARNINGS=0
SKIP_AUDIT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --list|-l)
      ACTION="list"
      shift
      ;;
    --router|-r)
      ACTION="router"
      shift
      ;;
    --combo|-c)
      ACTION="combo"
      ARG_VAL="${2:-}"
      shift 2
      ;;
    --skill|-s)
      ACTION="skill"
      ARG_VAL="${2:-}"
      shift 2
      ;;
    --all|-a)
      ACTION="all"
      shift
      ;;
    --target|-t)
      TARGET="${2:-claude}"
      shift 2
      ;;
    --vault-dir)
      VAULT_DIR="${2:-}"
      shift 2
      ;;
    --tier)
      TIER="${2:-all}"
      shift 2
      ;;
    --force-active)
      FORCE_ACTIVE=1
      shift
      ;;
    --allow-doc-warnings)
      ALLOW_DOC_WARNINGS=1
      shift
      ;;
    --allow-vault-warnings)
      ALLOW_VAULT_WARNINGS=1
      shift
      ;;
    --skip-audit)
      SKIP_AUDIT=1
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

resolve_python() {
  if command -v python3 >/dev/null 2>&1; then
    echo "python3"
  elif command -v python >/dev/null 2>&1; then
    echo "python"
  else
    echo ""
  fi
}

PY_BIN="$(resolve_python)"

resolve_target_dir() {
  local raw
  case "$1" in
    claude)        raw="$(pwd)/.claude/skills" ;;
    global-claude) raw="$HOME/.claude/skills" ;;
    cursor)        raw="$(pwd)/.cursor/skills" ;;
    antigravity)   raw="$HOME/.gemini/config/skills" ;;
    codex)         raw="$(pwd)/.agents/skills" ;;
    *)             raw="$1" ;;
  esac
  echo "${raw%/}"
}

audit_skill_dir() {
  local scan_dir="$1"
  local skill_id="$2"
  local skill_tier="$3"

  if [[ "$SKIP_AUDIT" -eq 1 ]]; then
    echo "  [WARN] Skipping security audit for '$skill_id' (--skip-audit)."
    return 0
  fi

  if [[ -z "$PY_BIN" ]]; then
    echo "  [ERROR] python3/python is required to run scripts/scan_quarantine.py (pass --skip-audit only if manually verified)."
    return 1
  fi

  echo "  [AUDIT] Running static quarantine scan on '$skill_id' (tier: $skill_tier)..."
  local scan_json
  scan_json="$("$PY_BIN" "$SCANNER_PY" --path "$scan_dir" --json)"

  local decision
  decision="$(SCAN_JSON="$scan_json" "$PY_BIN" - "$skill_id" "$skill_tier" "$ALLOW_VAULT_WARNINGS" "$ALLOW_DOC_WARNINGS" <<'PYEOF'
import json, os, sys
skill_id, skill_tier, allow_warn, allow_doc = sys.argv[1], sys.argv[2], sys.argv[3] == "1", sys.argv[4] == "1"
results = json.loads(os.environ.get("SCAN_JSON", "[]"))
has_fail = any(r.get("status") == "FAIL" for r in results)
has_warn = any(r.get("status") == "WARN" for r in results)
findings = [f for r in results for f in r.get("findings", [])]
hard_block = any(f.get("rule") in ("RULE_BIDI_TROJAN", "RULE_PKG_HOOK") for f in findings)
for f in findings[:20]:
    print(f"  -> [{f.get('severity')}] {f.get('rule')} @ {f.get('file')}:{f.get('line')} ({f.get('detail')})", file=sys.stderr)
if hard_block:
    print("HARD_BLOCK")
elif skill_tier == "defensive":
    if has_fail or has_warn:
        if allow_doc:
            print("ALLOW_DOC_WARN")
        elif has_fail:
            print("BLOCK")
        else:
            print("PASS")
    else:
        print("PASS")
else:
    if has_fail or has_warn:
        print("ALLOW_VAULT_WARN" if allow_warn else "PAUSE_VAULT")
    else:
        print("PASS")
PYEOF
)"

  case "$decision" in
    PASS)
      echo "  [PASS] '$skill_id' passed static security audit."
      return 0
      ;;
    ALLOW_DOC_WARN)
      echo "  [WARN] Defensive skill '$skill_id' has non-Trojan doc findings (0 hard-blocks); proceeding via --allow-doc-warnings."
      return 0
      ;;
    ALLOW_VAULT_WARN)
      echo "  [WARN] Vault pack '$skill_id' has non-Trojan findings; isolating in Vault via --allow-vault-warnings."
      return 0
      ;;
    HARD_BLOCK)
      echo "  [BLOCKED] Hard-block finding (RULE_BIDI_TROJAN or RULE_PKG_HOOK) detected in '$skill_id'. Aborting."
      return 1
      ;;
    PAUSE_VAULT)
      echo "  [PAUSED] Vault pack '$skill_id' triggered findings above. Inspect those files and re-run with --allow-vault-warnings."
      return 1
      ;;
    *)
      echo "  [BLOCKED] Defensive skill '$skill_id' failed static security audit."
      return 1
      ;;
  esac
}

install_local_skill() {
  local skill_id="$1"
  local dest_root="$2"
  local src_dir="$REPO_ROOT/skills/$skill_id"

  if [[ ! -d "$src_dir" ]]; then
    echo "  [ERROR] Local skill '$skill_id' not found at $src_dir"
    return 1
  fi

  mkdir -p "$dest_root/$skill_id"
  cp -R "$src_dir/." "$dest_root/$skill_id/"
  echo "  [INSTALLED] Local meta-skill '$skill_id' -> $dest_root/$skill_id"
}

install_upstream_skill() {
  local skill_id="$1"
  local dest_root="$2"
  local vault_root="$3"

  if [[ -z "$PY_BIN" ]]; then
    echo "  [ERROR] python3/python is required to parse registry.json"
    exit 1
  fi

  local meta
  meta="$("$PY_BIN" -c "import json; r=json.load(open('$REGISTRY_PATH', encoding='utf-8')); s=next((x for x in r['upstreamSkills'] if x['id']=='$skill_id'),None); print(f\"{s['repo']}|{s.get('subPath','')}|{s.get('tier','defensive')}|{s.get('license','Unknown')}\" if s else '')")"

  if [[ -z "$meta" ]]; then
    echo "  [WARN] Upstream skill '$skill_id' not found in registry.json"
    return 0
  fi

  IFS='|' read -r repo subpath skill_tier license <<< "$meta"

  if [[ "$TIER" != "all" && "$skill_tier" != "$TIER" ]]; then
    echo "  [SKIP] '$skill_id' (tier=$skill_tier) excluded by --tier $TIER filter."
    return 0
  fi

  local target_base="$dest_root"
  if [[ "$skill_tier" == "vault" && "$FORCE_ACTIVE" -eq 0 ]]; then
    target_base="$vault_root"
  fi

  local temp_dir
  temp_dir="$(mktemp -d 2>/dev/null || mktemp -d -t 'aisec')"

  echo ""
  echo "[FETCH] Cloning '$skill_id' from https://github.com/$repo (Tier: $skill_tier, License: $license)..."

  if [[ -n "$subpath" ]]; then
    local sub_clean="${subpath#/}"
    if [[ "$sub_clean" =~ \.[A-Za-z0-9]+$ ]]; then
      git clone --depth 1 --filter=blob:none --no-checkout -c core.hooksPath=/dev/null "https://github.com/$repo.git" "$temp_dir" >/dev/null 2>&1 || { rm -rf "$temp_dir"; return 1; }
      (cd "$temp_dir" && git sparse-checkout init --no-cone >/dev/null 2>&1 && git sparse-checkout set "/$sub_clean" >/dev/null 2>&1 && git checkout >/dev/null 2>&1)
    else
      git clone --depth 1 --filter=blob:none --sparse -c core.hooksPath=/dev/null "https://github.com/$repo.git" "$temp_dir" >/dev/null 2>&1 || { rm -rf "$temp_dir"; return 1; }
      (cd "$temp_dir" && git sparse-checkout set "$subpath" >/dev/null 2>&1)
    fi
    local payload_dir="$temp_dir/$sub_clean"
  else
    git clone --depth 1 --filter=blob:none -c core.hooksPath=/dev/null "https://github.com/$repo.git" "$temp_dir" >/dev/null 2>&1 || { rm -rf "$temp_dir"; return 1; }
    local payload_dir="$temp_dir"
  fi

  rm -rf "$temp_dir/.git"

  if [[ ! -e "$payload_dir" ]]; then
    payload_dir="$temp_dir"
  fi

  if [[ -f "$payload_dir" ]]; then
    mkdir -p "$temp_dir/_leaf_stage"
    cp "$payload_dir" "$temp_dir/_leaf_stage/"
    payload_dir="$temp_dir/_leaf_stage"
  fi

  if audit_skill_dir "$payload_dir" "$skill_id" "$skill_tier"; then
    mkdir -p "$target_base/$skill_id"
    cp -R "$payload_dir/." "$target_base/$skill_id/"
    if [[ "$skill_tier" == "vault" && "$FORCE_ACTIVE" -eq 0 ]]; then
      echo "  [VAULTED] Isolated security skill '$skill_id' -> $target_base/$skill_id"
    else
      echo "  [INSTALLED] Upstream skill '$skill_id' -> $target_base/$skill_id"
    fi
  else
    echo "  [ABORTED] Skipping '$skill_id' due to security audit policy."
  fi

  rm -rf "$temp_dir"
}

DEST_ROOT="$(resolve_target_dir "$TARGET")"
VAULT_ROOT="${VAULT_DIR:-${DEST_ROOT}-vault-security}"
VAULT_ROOT="${VAULT_ROOT%/}"

case "$ACTION" in
  list)
    if [[ -n "$PY_BIN" ]]; then
      "$PY_BIN" -c "
import json
r = json.load(open('$REGISTRY_PATH', encoding='utf-8'))
print('=== Built-in MIT Meta-Skills ===')
for s in r['localSkills']:
    print(f\"  - {s['id']}: {s['description']}\")
print('\n=== 7 Curated Combos (--combo <name>) ===')
for k, c in r['combos'].items():
    print(f\"  - {k}: {c['name']} [{', '.join(c['upstreamSkills'])}]\")
print('\n=== 25 Upstream Skills (--skill <id>) ===')
for u in r['upstreamSkills']:
    print(f\"  - {u['id']} [{u['tier']}] [{u['category']}] ({u['license']}) -> {u['repo']}\")
"
    else
      cat "$REGISTRY_PATH"
    fi
    ;;
  router)
    if [[ "$TIER" == "vault" ]]; then
      echo "Local Meta-Skills belong to tier 'defensive'; skipping due to --tier vault."
      exit 0
    fi
    mkdir -p "$DEST_ROOT"
    for dir in "$REPO_ROOT"/skills/*/; do
      sid="$(basename "$dir")"
      install_local_skill "$sid" "$DEST_ROOT"
    done
    ;;
  combo)
    mkdir -p "$DEST_ROOT"
    if [[ "$TIER" != "vault" ]]; then
      install_local_skill "security-router" "$DEST_ROOT"
      install_local_skill "combo-$ARG_VAL" "$DEST_ROOT"
    fi
    ups="$("$PY_BIN" -c "import json; r=json.load(open('$REGISTRY_PATH', encoding='utf-8')); print('\n'.join(r['combos']['$ARG_VAL']['upstreamSkills']))")"
    for u in $ups; do
      install_upstream_skill "$u" "$DEST_ROOT" "$VAULT_ROOT"
    done
    ;;
  skill)
    mkdir -p "$DEST_ROOT"
    if [[ -d "$REPO_ROOT/skills/$ARG_VAL" ]]; then
      install_local_skill "$ARG_VAL" "$DEST_ROOT"
    else
      install_upstream_skill "$ARG_VAL" "$DEST_ROOT" "$VAULT_ROOT"
    fi
    ;;
  all)
    mkdir -p "$DEST_ROOT"
    if [[ "$TIER" != "vault" ]]; then
      for dir in "$REPO_ROOT"/skills/*/; do
        sid="$(basename "$dir")"
        install_local_skill "$sid" "$DEST_ROOT"
      done
    fi
    all_ups="$("$PY_BIN" -c "import json; r=json.load(open('$REGISTRY_PATH', encoding='utf-8')); print('\n'.join(x['id'] for x in r['upstreamSkills']))")"
    for u in $all_ups; do
      install_upstream_skill "$u" "$DEST_ROOT" "$VAULT_ROOT"
    done
    ;;
  *)
    echo "Usage:"
    echo "  ./install.sh --list"
    echo "  ./install.sh --router [--target claude|global-claude|cursor|antigravity|codex|/custom/path]"
    echo "  ./install.sh --combo <combo-name> [--tier all|defensive|vault] [--target ...]"
    echo "  ./install.sh --skill <skill-id> [--vault-dir /path/to/vault] [--allow-doc-warnings] [--allow-vault-warnings]"
    echo "  ./install.sh --all [--tier defensive|all] [--target ...]"
    ;;
esac
