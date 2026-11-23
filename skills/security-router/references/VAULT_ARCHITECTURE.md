# Vault-First Security Architecture (`defensive` vs `vault`)

`ai-security-playbook` separates security capabilities into **two tiers** so you can maintain 100% of your defensive and red-team capability without overloading your coding agent's active skill index or triggering unintended policy friction during everyday engineering work.

---

## 1. Why Vault-First?

1. **Context-Window & Prompt-Budget Protection**:
   Large multi-dozen offensive/compliance packs (for example, `W4L33Dx/Cyber-Monster` [786 `SKILL.md` files], `mukul975/Anthropic-Cybersecurity-Skills` [817+ skills], `H-mmer/pentest-agents` [306 skills], `Zyrexnn/Cybermes` [409 skills], `SnailSploit/Claude-Red` [79 skills], `elementalsouls/Claude-BugHunter` [83 skills]) consume thousands of frontmatter tokens if dumped flat into an active agent skills directory.
2. **Clean Separation of Daily Coding vs Authorized Security Engagements**:
   Always-on defensive guardrails (`cloudflare-security-audit`, `vibe-shield`, `agentshield`, `tirith`, `project-codeguard`) help during everyday feature engineering, PR review, and dependency installation. Offensive/pentest workflows only apply when conducting an explicitly scoped security engagement.
3. **Quarantine Audit Before Activation**:
   Both `defensive` and `vault` packages are cloned with `core.hooksPath` disabled (`NUL` / `/dev/null`), stripped of `.git`, and scanned via `scripts/scan_quarantine.py` before being copied into either destination.

---

## 2. How the Two Tiers Route

| Tier | Default Destination (Example: `-Target antigravity`) | Examples | Behavior |
| :--- | :--- | :--- | :--- |
| **`defensive`** | Active skills dir (`~/.gemini/config/skills/`, `.claude/skills/`, etc.) | `security-router`, 7 `combo-*` meta-skills, `cloudflare-security-audit`, `vibe-shield`, `agentshield`, `tirith`, `project-codeguard`, `trailofbits-skills` | Installed directly and active for everyday code audits, threat modeling, and skill hygiene. Must pass `scan_quarantine.py` with zero `FAIL` findings. |
| **`vault`** | Sibling Vault dir (`<TargetDir>-vault-security/` or custom `-VaultDir`) | `cyber-monster`, `harness-kit`, `claude-bughunter`, `claude-red`, `claude-osint`, `reverse-skill`, `raptor`, `pentest-agents`, `cybermes`, `anthropic-cybersecurity-skills` | Stored out-of-band in an isolated Vault folder. Read selectively via file read/router lookup during an engagement, or temporarily mounted when dedicated native subagent discovery is needed — then unmounted afterward. |

---

## 3. Installer Routing Flags

### Windows (`install.ps1`)
```powershell
# 1. Install only the 8 MIT Meta-Skills (security-router + 7 combos)
.\install.ps1 -Router -Target antigravity

# 2. Install a single defensive skill (goes to active skills/)
.\install.ps1 -Skill vibe-shield -Target antigravity

# 3. Install a vault-tier skill pack (automatically routes to sibling *-vault-security/ or -VaultDir)
.\install.ps1 -Skill cyber-monster -Target antigravity -VaultDir "$HOME\.gemini\config\skills-vault-security"

# 4. Install only defensive skills across an entire Combo
.\install.ps1 -Combo appsec-code-audit -Tier defensive -Target antigravity

# 5. Explicitly mount a vault skill into active skills/ (not recommended permanently)
.\install.ps1 -Skill harness-kit -Target antigravity -ForceActive
```

### macOS / Linux / WSL (`install.sh`)
```bash
./install.sh --router --target antigravity
./install.sh --skill vibe-shield --target antigravity
./install.sh --skill cyber-monster --target antigravity --vault-dir "$HOME/.gemini/config/skills-vault-security"
./install.sh --combo appsec-code-audit --tier defensive --target antigravity
```

---

## 4. Quarantine Handling for Vault Reference Packs

Offensive security documentation and red-team skill packs frequently contain legitimate command examples (`bash` one-liners, base64 encoding samples, or prompt-injection test strings) inside Markdown docs. The installer enforces a two-tier policy:

- **Hard Block (Both Tiers)**: Hidden Unicode bidirectional Trojan characters (`RULE_BIDI_TROJAN`) and suspicious `package.json` `preinstall`/`postinstall` lifecycle hooks (`RULE_PKG_HOOK`). Always check `package.json` and bidi chars manually before trusting any repository.
- **Quarantine Inspection for `vault` Packs**: If `scan_quarantine.py` flags documentation-level patterns (`RULE_PI_OVERRIDE`, `RULE_REMOTE_PIPE`, `RULE_DYNAMIC_EXEC`) inside a `vault`-tier pack, the installer pauses and prints only sanitized `[severity] RULE @ file:line` metadata so you can inspect the exact file before passing `-AllowVaultWarnings` / `--allow-vault-warnings`.
