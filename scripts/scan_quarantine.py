#!/usr/bin/env python3
"""
Standalone Quarantine Static Security Scanner for Agent Skills & Repositories.
Designed for local execution so LLM agents never emit raw exploit/jailbreak
regex signatures in tool calls or echo untrusted payloads into stdout.

Usage:
  python scan_quarantine.py --path "<directory>"
  python scan_quarantine.py --repos owner/repo1 owner/repo2 [--clean] [--json]
"""

import argparse
import base64
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

TEXT_EXTENSIONS = {
    ".md", ".txt", ".sh", ".bash", ".zsh", ".ps1", ".psm1", ".bat", ".cmd",
    ".py", ".js", ".mjs", ".cjs", ".ts", ".tsx", ".jsx", ".json", ".yaml", ".yml", ".toml"
}

BIDI_CHARS = {
    "\u202a", "\u202b", "\u202c", "\u202d", "\u202e",
    "\u2066", "\u2067", "\u2068", "\u2069"
}

# Encoded detection patterns so neither this source file nor stdout needs raw payload literals
ENCODED_RULES = [
    (
        "RULE_PI_OVERRIDE",
        "HIGH",
        "Instruction-override or system-prompt bypass phrase",
        base64.b64decode(
            b"KGlpKShpZ25vcmVcfGRpc3JlZ2FyZHxmb3JnZXQpXHNcKyhhbGxcK1xzXCspPyhwcmV2aW91c3xzeXN0ZW18cHJpb3J8Y3VycmVudClcc1wrKGluc3RydWN0aW9uc3xwcm9tcHR8cnVsZXMp"
        ).decode("utf-8"),
    ),
    (
        "RULE_REMOTE_PIPE",
        "HIGH",
        "Remote download piped directly to shell interpreter",
        base64.b64decode(
            b"KD9pKVxiKGN1cmx8d2dldHxpd3J8SW52b2tlLVdlYlJlcXVlc3QpXGJbXlxyXG58XXsxLDIwMH1cfFxzKihiYSk/KHNofHpzaHxwd3NofHBvd2Vyc2hlbGx8aWV4KVxi"
        ).decode("utf-8"),
    ),
    (
        "RULE_DYNAMIC_EXEC",
        "MEDIUM",
        "Dynamic shell/encoded payload evaluation primitive",
        base64.b64decode(
            b"KD9pKVxiKEludm9rZS1FeHByZXNzaW9ufEZyb21CYXNlNjRTdHJpbmd8XGJpZXhccypcKCk="
        ).decode("utf-8"),
    ),
]

COMPILED_RULES = [
    (rule_id, severity, desc, re.compile(pattern))
    for rule_id, severity, desc, pattern in ENCODED_RULES
]


def scan_file(file_path: Path, root_dir: Path) -> list[dict]:
    rel_path = str(file_path.relative_to(root_dir)).replace("\\", "/")
    findings = []

    if file_path.name == "package.json":
        try:
            data = json.loads(file_path.read_text(encoding="utf-8", errors="replace"))
            scripts = data.get("scripts", {}) if isinstance(data, dict) else {}
            for hook in ("preinstall", "install", "postinstall"):
                if hook in scripts:
                    cmd_preview = str(scripts[hook])[:80]
                    findings.append({
                        "rule": "RULE_PKG_HOOK",
                        "severity": "WARN",
                        "file": rel_path,
                        "line": 1,
                        "detail": f"package.json defines '{hook}' lifecycle script ({cmd_preview})"
                    })
        except Exception:
            pass

    if file_path.suffix.lower() not in TEXT_EXTENSIONS:
        return findings

    try:
        text = file_path.read_text(encoding="utf-8", errors="replace")
    except Exception:
        return findings

    for idx, line in enumerate(text.splitlines(), start=1):
        if any(ch in line for ch in BIDI_CHARS):
            findings.append({
                "rule": "RULE_BIDI_TROJAN",
                "severity": "HIGH",
                "file": rel_path,
                "line": idx,
                "detail": "Hidden bidirectional Unicode control character detected"
            })
        for rule_id, severity, desc, regex in COMPILED_RULES:
            if regex.search(line):
                findings.append({
                    "rule": rule_id,
                    "severity": severity,
                    "file": rel_path,
                    "line": idx,
                    "detail": desc
                })

    return findings


def scan_target_directory(target_dir: Path) -> dict:
    all_files = [
        p for p in target_dir.rglob("*")
        if p.is_file() and ".git" not in p.parts and "node_modules" not in p.parts
    ]
    skill_files = [
        str(p.relative_to(target_dir)).replace("\\", "/")
        for p in all_files if p.name == "SKILL.md"
    ]
    findings = []
    for f in all_files:
        findings.extend(scan_file(f, target_dir))

    high_count = sum(1 for x in findings if x["severity"] == "HIGH")
    warn_count = sum(1 for x in findings if x["severity"] in ("WARN", "MEDIUM"))

    if high_count > 0:
        status = "FAIL"
    elif warn_count > 0:
        status = "WARN"
    else:
        status = "PASS"

    return {
        "target": target_dir.name,
        "path": str(target_dir),
        "status": status,
        "total_files": len(all_files),
        "skill_md_count": len(skill_files),
        "skills": skill_files[:25],
        "high_findings": high_count,
        "warn_findings": warn_count,
        "findings": findings,
    }


def clone_repos_to_quarantine(repos: list[str], base_dir: Path) -> list[Path]:
    cloned = []
    base_dir.mkdir(parents=True, exist_ok=True)
    for repo in repos:
        safe_name = repo.strip().replace("/", "__")
        dest = base_dir / safe_name
        if dest.exists():
            shutil.rmtree(dest, ignore_errors=True)
        cmd = [
            "git", "clone", "--depth", "1",
            "-c", f"core.hooksPath={os.devnull}",
            f"https://github.com/{repo.strip()}.git",
            str(dest)
        ]
        subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=90)
        if dest.exists():
            cloned.append(dest)
    return cloned


def main():
    parser = argparse.ArgumentParser(description="Standalone Quarantine Static Security Scanner")
    parser.add_argument("--path", type=str, help="Existing directory or parent quarantine directory to scan")
    parser.add_argument("--repos", nargs="*", help="One or more GitHub owner/repo slugs to clone into quarantine and scan")
    parser.add_argument("--clean", action="store_true", help="Remove temporary quarantine clone directory after scanning")
    parser.add_argument("--json", action="store_true", help="Output results in JSON format")
    args = parser.parse_args()

    results = []
    temp_quarantine = None

    try:
        if args.repos:
            temp_quarantine = Path(tempfile.mkdtemp(prefix="infra_quarantine_audit_"))
            targets = clone_repos_to_quarantine(args.repos, temp_quarantine)
            for t in targets:
                results.append(scan_target_directory(t))
        elif args.path:
            p = Path(args.path)
            if not p.exists():
                print(f"[ERROR] Path does not exist: {p}", file=sys.stderr)
                sys.exit(1)
            subdirs = [d for d in sorted(p.iterdir()) if d.is_dir() and d.name != ".git"]
            if (p / "SKILL.md").exists() or not subdirs:
                results.append(scan_target_directory(p))
            else:
                for d in subdirs:
                    results.append(scan_target_directory(d))
        else:
            parser.print_help()
            sys.exit(1)
    finally:
        if temp_quarantine and args.clean and temp_quarantine.exists():
            shutil.rmtree(temp_quarantine, ignore_errors=True)

    if args.json:
        print(json.dumps(results, indent=2))
    else:
        print("===================================================================")
        print("  QUARANTINE STATIC SECURITY AUDIT REPORT")
        print("===================================================================")
        for r in results:
            print(
                f"[{r['status']}] {r['target']} | Files: {r['total_files']} | "
                f"SKILL.md: {r['skill_md_count']} | High: {r['high_findings']} | Warn: {r['warn_findings']}"
            )
            if r["skills"]:
                print(f"       Skills: {', '.join(r['skills'])}")
            for f in r["findings"][:15]:
                print(f"       -> [{f['severity']}] {f['rule']} @ {f['file']}:{f['line']} ({f['detail']})")
        print("===================================================================")


if __name__ == "__main__":
    main()
