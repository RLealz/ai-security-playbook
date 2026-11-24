# 🛡️ AI Security Playbook & Vault-First Meta-Skill Ecosystem

**Audit, defend, and red-team without polluting your agent's context window.**  
`ai-security-playbook` is the cybersecurity sibling hub to [`RLealz/ai-design-playbook`](https://github.com/RLealz/ai-design-playbook) — combining a **Vault-First Security Meta-Router, 7 Multi-Skill Workflow Combos, a Curated Security Registry, and a Quarantine-Auditing Upstream Installer** for AI coding agents (**Claude Code**, **Antigravity / Gemini CLI**, **Cursor**, **Codex**, and **Windsurf**).

> **Authorized Use & Vault-First Security Architecture**  
> All offensive/red-team/bug-bounty workflows in this ecosystem are scoped strictly for authorized security engagements, owned infrastructure, and local training labs (`AIGoat`, `DVWA`, `WebGoat`, `DeFiHackLabs`).  
> To preserve your agent's context window and prevent unintended policy friction during everyday coding:
> - **`defensive` tier** (`security-router`, 7 `combo-*` meta-skills, AppSec/AI guardrails, Trail of Bits skills) installs into your **active** agent skills directory.
> - **`vault` tier** (high-volume offensive, red-team, OSINT, and binary RE skill packs like `Cyber-Monster`, `Claude-BugHunter`, `harness-kit`, `pentest-agents`) automatically routes to an **isolated sibling Vault directory** (`<TargetDir>-vault-security` or custom `-VaultDir`) and is read/mounted only on demand.

---

## 📦 What's Inside

1. **8 Built-in MIT Meta-Skills (`skills/*/SKILL.md`)**: Ready to drop into your agent today — `security-router` (authorized-scope gate + intent routing + curated resource tables) and **7 end-to-end Combo Orchestrators**.
2. **25 Curated Upstream Skill Repositories (`registry.json`)**:
   - **14 `defensive` skills**: AppSec code audits, AI/agent guardrails, Supabase RLS auditing, terminal protection, and smart contract security.
   - **11 `vault` skill packs**: Bug bounty, purple/red-team frameworks, OSINT, MITRE ATT&CK / NIST CSF libraries, and binary reverse engineering packs isolated out-of-band.
3. **18 Autonomous AI Security Frameworks & 10 Security MCP Servers (`registry.json`)**: Indexed without vendoring heavy third-party code or unverified container binaries.
4. **38+ Curated Security Web Resources & Supply-Chain Advisories**: AppSec hubs, Web3 audit datasets, OSINT/DFIR toolchains, and verified forensic advisories (including legacy `ARTEX` Docker backdoor warnings).
5. **Built-in Static Quarantine Scanner (`scripts/scan_quarantine.py`)**: Clones with Git hooks disabled (`core.hooksPath` = null device), strips `.git`, checks for instruction-override strings, hidden bidirectional Unicode Trojan characters, `package.json` lifecycle hooks, and piped/dynamic execution primitives before installing.

---

## ⚡ Quick Installation

<details open>
<summary><strong>1. Install Built-in MIT Meta-Router & 7 Combo Orchestrators (Zero External Clones)</strong></summary>

Clone the repository and install the 8 built-in MIT meta-skills (`security-router` + 7 `combo-*` orchestrators):

**PowerShell (Windows):**
```powershell
git clone https://github.com/RLealz/ai-security-playbook.git
cd ai-security-playbook

# Install to current project (.claude\skills)
.\install.ps1 -Router

# Or install globally to Antigravity / Gemini CLI (~/.gemini/config/skills)
.\install.ps1 -Router -Target antigravity

# Or install globally to Claude Code (~/.claude/skills)
.\install.ps1 -Router -Target global-claude
```

**Bash (macOS / Linux / WSL):**
```bash
git clone https://github.com/RLealz/ai-security-playbook.git
cd ai-security-playbook
chmod +x install.sh

# Install to current project (.claude/skills)
./install.sh --router

# Or install globally to Antigravity (~/.gemini/config/skills) or Claude (~/.claude/skills)
./install.sh --router --target antigravity
./install.sh --router --target global-claude
```

</details>

<details>
<summary><strong>2. Install a Security Workflow Combo (Vault-First Routing + Quarantine Audit)</strong></summary>

```powershell
# List all 7 Combos, 25 Upstream Skills (defensive vs vault), Frameworks & MCPs
.\install.ps1 -List

# Combo 1 (Defensive only): AppSec & Code Audit (cloudflare-security-audit, anthropic-defending-code, deepsec, mantis, ghostsecurity, vibe-shield, codeguard)
.\install.ps1 -Combo appsec-code-audit -Tier defensive -Target antigravity

# Combo 2 (Defensive only): AI, LLM & Agent Defense (vibe-shield, agentshield, tirith, clawsec, secureclaw, openclaw-skills-security, ai-infra-guard)
.\install.ps1 -Combo ai-agent-llm-defense -Tier defensive -Target antigravity

# Combo 3 (Vault-First): Authorized Pentest & Bug Bounty -> offensive packs route to <Target>-vault-security\
.\install.ps1 -Combo authorized-pentest-bounty -Target antigravity -VaultDir "$HOME\.gemini\config\skills-vault-security"

# Combo 4: Cloud, Container, K8s & Purple-Team Hardening
.\install.ps1 -Combo cloud-k8s-hardening -Target antigravity

# Combo 5: Web3 & Smart Contract Security Audit
.\install.ps1 -Combo web3-smart-contract-audit -Target antigravity

# Combo 6: Authorized OSINT & Attack-Surface Mapping
.\install.ps1 -Combo osint-attack-surface -Target antigravity

# Combo 7: Binary Reverse Engineering, Malware Forensics & Threat-Model Bluebook
.\install.ps1 -Combo binary-re-forensics -Target antigravity
```

</details>

<details>
<summary><strong>3. Install or Vault Individual Upstream Skills by ID</strong></summary>

```powershell
# Defensive skill -> active skills folder (passes quarantine with 0 FAIL)
.\install.ps1 -Skill vibe-shield -Target antigravity
.\install.ps1 -Skill cloudflare-security-audit -Target antigravity

# Security-scanner skill whose own CLI usage examples illustrate blocked syntax (inspect findings first, then pass -AllowDocWarnings)
.\install.ps1 -Skill tirith -Target antigravity -AllowDocWarnings

# Vault pack -> isolated security vault folder (inspect doc findings, then approve with -AllowVaultWarnings)
.\install.ps1 -Skill harness-kit -Target antigravity -VaultDir "$HOME\.gemini\config\skills-vault-security"
.\install.ps1 -Skill cyber-monster -Target antigravity -VaultDir "$HOME\.gemini\config\skills-vault-security" -AllowVaultWarnings
```

```bash
# Bash equivalent
./install.sh --skill vibe-shield --target antigravity
./install.sh --skill tirith --target antigravity --allow-doc-warnings
./install.sh --skill harness-kit --target antigravity --vault-dir "$HOME/.gemini/config/skills-vault-security"
```

</details>

<details>
<summary><strong>4. Manual Copy for Claude Code / Cursor / Codex / Windsurf</strong></summary>

Copy any folder inside `skills/` directly into your agent's skill directory:
- **Claude Code (Project)**: `.claude/skills/`
- **Claude Code (Global)**: `~/.claude/skills/`
- **Antigravity / Gemini CLI**: `~/.gemini/config/skills/`
- **Cursor**: `.cursor/skills/`
- **Codex / OpenCode**: `.agents/skills/`

</details>

---

## 🧭 Built-in Meta-Skills Included in This Repo (`skills/`)

| Skill Directory | Role |
| :--- | :--- |
| [`skills/security-router/SKILL.md`](skills/security-router/SKILL.md) | **Master Security Router & Authorized-Scope Gate**: Diagnoses task intent across 7 security domains, enforces 6 non-negotiable safety/evidence laws, and routes to active vs vaulted capabilities. |
| [`skills/combo-appsec-code-audit/SKILL.md`](skills/combo-appsec-code-audit/SKILL.md) | **Combo 1 Orchestrator**: Full-stack AppSec, REST/GraphQL API, Auth, Supabase RLS, SAST (`Semgrep`/`vibe-shield`), and verification audit workflow. |
| [`skills/combo-ai-agent-llm-defense/SKILL.md`](skills/combo-ai-agent-llm-defense/SKILL.md) | **Combo 2 Orchestrator**: AI/LLM prompt guardrails, `SKILL.md` & MCP quarantine audits, terminal defense (`tirith`), and adversarial testing (`promptfoo`/`garak`/`deepteam`). |
| [`skills/combo-authorized-pentest-bounty/SKILL.md`](skills/combo-authorized-pentest-bounty/SKILL.md) | **Combo 3 Orchestrator**: Scope-locked, Vault-First bug bounty and authorized pentesting orchestration with oracle-verified PoCs. |
| [`skills/combo-cloud-k8s-hardening/SKILL.md`](skills/combo-cloud-k8s-hardening/SKILL.md) | **Combo 4 Orchestrator**: Container/Kubernetes/IAM hardening (`trivy`, `cynative`), CI/CD secret scanning (`trufflehog`), and `Sigma`/`Wazuh`/`owLSM` detection rules. |
| [`skills/combo-web3-smart-contract-audit/SKILL.md`](skills/combo-web3-smart-contract-audit/SKILL.md) | **Combo 5 Orchestrator**: Solidity/EVM & Solana auditing combining `trailofbits-skills`, `slither`, `echidna`, Foundry invariant fuzzing, `DeFiHackLabs`, `Solodit`, and `Certora`. |
| [`skills/combo-osint-attack-surface/SKILL.md`](skills/combo-osint-attack-surface/SKILL.md) | **Combo 6 Orchestrator**: Passive attack-surface discovery (`OpenOSINT`, `bbot`, `subfinder`, `web-check`), identity corroboration, and evidence-graded CTI. |
| [`skills/combo-binary-re-forensics/SKILL.md`](skills/combo-binary-re-forensics/SKILL.md) | **Combo 7 Orchestrator**: Isolated binary reverse engineering (`REA` MCP, `reverse-skill`), DFIR triage (`Velociraptor`, `TheHive`), and STRIDE/Attack-Tree Security Bluebooks. |

---

# 📖 The Security Master Playbook

This playbook unifies curated security skills, autonomous multi-agent security platforms, security MCP servers, AppSec/Web3/OSINT toolchains, and verified threat-intel advisories under one roof.

---

## 1. Core Defensive & AppSec Agent Skills (`14 Defensive Upstream Skills`)

Installed into your active agent skills directory (`tier: "defensive"`) to guard codebases, AI agents, terminal sessions, and smart contracts during everyday development:

* **`cloudflare-security-audit`** ([`cloudflare/security-audit-skill`](https://github.com/cloudflare/security-audit-skill), `MIT`): Multi-phase coding-agent security audit workflow emitting independently verified, machine-readable findings.
* **`anthropic-defending-code`** ([`anthropics/defending-code-reference-harness`](https://github.com/anthropics/defending-code-reference-harness)): Threat modeling, scan triage, DnR hunting, and automated defensive patching skills.
* **`trailofbits-skills`** ([`trailofbits/skills`](https://github.com/trailofbits/skills), `CC-BY-SA-4.0`): Trail of Bits skills for audit-context building, vulnerability detection, agentic-actions auditing, and blockchain security.
* **`vercel-deepsec`** ([`vercel-labs/deepsec`](https://github.com/vercel-labs/deepsec), `Apache-2.0`): Coding-agent security harness targeting deep codebase vulnerability discovery.
* **`google-mantis`** ([`google/mantis`](https://github.com/google/mantis), `Apache-2.0`): Modular toolkit allowing coding agents to systematically locate, reproduce, and patch security issues.
* **`ghostsecurity-skills`** ([`ghostsecurity/skills`](https://github.com/ghostsecurity/skills), `Apache-2.0`): AppSec agent plugins for repository context, HTTP proxy inspection, and finding reports.
* **`agentshield`** ([`affaan-m/agentshield`](https://github.com/affaan-m/agentshield), `MIT`): Audits Claude Code / `.agents` configurations, hooks, MCP servers, permissions, and secret exposure.
* **`vibe-shield`** ([`avivgerz-hue/vibe-shield`](https://github.com/avivgerz-hue/vibe-shield), `MIT`): 92-rule static security scanner (SAST), secret detector, Supabase RLS auditor & `SKILL.md` prompt-injection guard.
* **`project-codeguard`** ([`cosai-oasis/project-codeguard`](https://github.com/cosai-oasis/project-codeguard)): CoSAI / OASIS model-agnostic framework embedding secure-by-default engineering controls.
* **`tirith`** ([`sheeki03/tirith`](https://github.com/sheeki03/tirith), `AGPL-3.0`): Terminal defense intercepting homograph URLs, pipe-to-shell commands, ANSI escape injection, and obfuscated scripts.
* **`clawsec`**, **`secureclaw`**, & **`openclaw-skills-security`** ([`prompt-security/clawsec`](https://github.com/prompt-security/clawsec), [`adversa-ai/secureclaw`](https://github.com/adversa-ai/secureclaw), [`UseAI-pro/openclaw-skills-security`](https://github.com/UseAI-pro/openclaw-skills-security)): OWASP-aligned AI agent hardening suites, integrity monitors, credential scanners, and injection guards.
* **`ai-infra-guard`** ([`Tencent/AI-Infra-Guard`](https://github.com/Tencent/AI-Infra-Guard), `Apache-2.0`): Prompt and skill packs for agentic supply-chain, authorization-bypass, and MCP security scanning.

---

## 2. Vaulted Pentest, Red-Team, OSINT & RE Skill Packs (`11 Vault Upstream Skills`)

Automatically routed by `install.ps1` / `install.sh` to `<TargetDir>-vault-security` (never cluttering active daily prompts):

* **`cyber-monster`** ([`W4L33Dx/Cyber-Monster`](https://github.com/W4L33Dx/Cyber-Monster)): 786 red-team, blue-team, forensics, detection, and application security skills behind one unified router.
* **`anthropic-cybersecurity-skills`** ([`mukul975/Anthropic-Cybersecurity-Skills`](https://github.com/mukul975/Anthropic-Cybersecurity-Skills), `Apache-2.0`): 817+ structured cybersecurity skills mapped across MITRE ATT&CK, NIST CSF 2.0, and MITRE ATLAS.
* **`harness-kit`** ([`ZephrFish/harness-kit`](https://github.com/ZephrFish/harness-kit)): 5-phase bug-hunting skill harness (`01-recon`, `02-hunt`, `03-validate`, `04-trace`, `05-report`).
* **`claude-bughunter`** ([`elementalsouls/Claude-BugHunter`](https://github.com/elementalsouls/Claude-BugHunter), `MIT`): 82 bug-hunting skills, 15 slash commands, and 681+ disclosed-report methodology patterns.
* **`claude-red`** ([`SnailSploit/Claude-Red`](https://github.com/SnailSploit/Claude-Red), `MIT`): 79 authorized offensive/red-team skills across Active Directory, APIs, cloud, and web apps.
* **`claude-osint`** ([`elementalsouls/Claude-OSINT`](https://github.com/elementalsouls/Claude-OSINT), `MIT`): 10 OSINT skills covering passive recon, email/domain posture, secret regexes, and continuous exposure checks.
* **`reverse-skill`** ([`zhaoxuya520/reverse-skill`](https://github.com/zhaoxuya520/reverse-skill), `MIT`): Binary reverse engineering, CTF sandbox orchestration, and authorized security research skill router pack.
* **`raptor`** ([`gadievron/raptor`](https://github.com/gadievron/raptor)): Security research rules and skills for codebase understanding, crash analysis, function tracing, and security auditing.
* **`pentest-agents`** ([`H-mmer/pentest-agents`](https://github.com/H-mmer/pentest-agents)) & **`cybermes`** ([`Zyrexnn/Cybermes`](https://github.com/Zyrexnn/Cybermes), `Apache-2.0`): Large autonomous bug-bounty & red-team skill packs quarantined for explicit vault loading only.
* **`ex-ussr-kinship-research`** ([`DenisSergeevitch/ex-ussr-kinship-research`](https://github.com/DenisSergeevitch/ex-ussr-kinship-research), `MIT`): Evidence-first archival OSINT methodology skill.

---

## 3. Autonomous AI Security & Pentest Agent Frameworks (`18 Cataloged Platforms`)

Standalone multi-agent frameworks run in isolated containers/worktrees rather than installed as global IDE skills:

* **Full-Stack Autonomous Pentesters**: [`usestrix/strix`](https://github.com/usestrix/strix) (`Apache-2.0`), [`KeygraphHQ/shannon`](https://github.com/KeygraphHQ/shannon) (`AGPL-3.0`), [`vxcontrol/pentagi`](https://github.com/vxcontrol/pentagi) (`MIT`), [`GreyDGL/PentestGPT`](https://github.com/GreyDGL/PentestGPT) (`MIT`), [`aliasrobotics/cai`](https://github.com/aliasrobotics/cai), [`samugit83/redamon`](https://github.com/samugit83/redamon) (`MIT`), [`BitterSecurity/Decepticon`](https://github.com/BitterSecurity/Decepticon) (`Apache-2.0`), [`Armur-Ai/Pentest-Swarm-AI`](https://github.com/Armur-Ai/Pentest-Swarm-AI) (`AGPL-3.0`), [`CyberStrikeus/CyberStrike`](https://github.com/CyberStrikeus/CyberStrike) (`AGPL-3.0`).
* **ARTEX Distributions**: [`failsafe-security/artex`](https://github.com/failsafe-security/artex) (hardened source-built `v0.3.15`) and [`BaaRai/ARTEX`](https://github.com/BaaRai/ARTEX) (active English continuation; builds locally from source — see Section 6 advisory).
* **Oracle-Verified & Whitebox Code Agents**: [`0xSteph/pentest-ai`](https://github.com/0xSteph/pentest-ai) (`MIT`), [`0xSteph/pentest-ai-agents`](https://github.com/0xSteph/pentest-ai-agents) (`MIT`), [`Kritt-ai/open-kritt`](https://github.com/Kritt-ai/open-kritt) (`AGPL-3.0`), [`hadriansecurity/OpenHack`](https://github.com/hadriansecurity/OpenHack) (`MIT`), [`LumosLab-Innovation/OpenHunterAI`](https://github.com/LumosLab-Innovation/OpenHunterAI), [`evilsocket/audit`](https://github.com/evilsocket/audit) (`MIT`), [`cynative/cynative`](https://github.com/cynative/cynative) (`Apache-2.0`).

---

## 4. Security, Vulnerability & OSINT MCP Servers (`10 Servers`)

Full specifications live in [`skills/security-router/references/SECURITY_RESOURCES.md`](skills/security-router/references/SECURITY_RESOURCES.md):

* **SAST & RE**: [`semgrep/mcp`](https://github.com/semgrep/mcp) (`MIT`), [`morluto/rea`](https://github.com/morluto/rea) (`Reverse Engineer Anything` — native/managed/Electron/mobile MCP).
* **OSINT & Threat Intel**: [`OpenOSINT/OpenOSINT`](https://github.com/OpenOSINT/OpenOSINT) (`MIT`), [`badchars/darknet-mcp-server`](https://github.com/badchars/darknet-mcp-server) (`MIT`, 66 threat-intel tools), [`marc-shade/world-intel-mcp`](https://github.com/marc-shade/world-intel-mcp) (`MIT`).
* **Authorized Pentest Orchestration & Labs**: [`0x4m4/hexstrike-ai`](https://github.com/0x4m4/hexstrike-ai) (`MIT`), [`0xSojalSec/PentestAgent`](https://github.com/0xSojalSec/PentestAgent) (`MIT`), [`irraz/vulnerator-ai`](https://github.com/irraz/vulnerator-ai) (`MIT`), [`yuhano/PentestGPT-MCP`](https://github.com/yuhano/PentestGPT-MCP), and [`harishsg993010/damn-vulnerable-MCP-server`](https://github.com/harishsg993010/damn-vulnerable-MCP-server) (training lab).

---

## 5. AppSec, Cloud, Web3, OSINT & Forensics Toolchains (`38+ Curated Resources`)

Organized across 4 pillars inside [`SECURITY_RESOURCES.md`](skills/security-router/references/SECURITY_RESOURCES.md):
1. **AI & LLM Red-Teaming / Guardrails**: `promptfoo`, `NVIDIA/garak`, `deepteam`, `cisco-ai-defense/skill-scanner`, `openguardrails`, `Trusted-AI/adversarial-robustness-toolbox`, `splx-ai/agentic-radar`, `protectai/modelscan`, `AIGoat`, `AgentDojo`, `CyberGym`, `Arcanum-Sec/sec-context`, Gray Swan Arena, Adversa AI.
2. **AppSec, Cloud & Detection**: `trivy`, `trufflehog`, `wazuh`, `SigmaHQ/sigma`, `redcanaryco/atomic-red-team`, `bunkerweb`, `Cybereason-Public/owLSM`, `OWASP/wstg`, `OWASP/CheatSheetSeries`, `PayloadsAllTheThings`, `SecLists`, `WebHackersWeapons`, `hexbrainai.com`, `defectdojo.com`, `ipurple.team`, PortSwigger Top 10, TryHackMe, Cyber Library.
3. **Web3 & Smart Contract Security**: `crytic/slither`, `crytic/echidna`, `ConsenSysDiligence/mythril`, `ConsenSysDiligence/surya`, `SunWeb3Sec/DeFiHackLabs`, `Cyfrin/audit-checklist`, `devdacian/ai-auditor-primers`, `0xMacro/awesome-solana-security`, `OffcierCia/On-Chain-Investigations-Tools-List`, `OffcierCia/Crypto-OpSec-SelfGuard-RoadMap`, `solodit.cyfrin.io`, `certora.com`, `updraft.cyfrin.io`.
4. **OSINT, DFIR & Privacy**: `bbot`, `subfinder`, `web-check`, `maigret`, `sherlock`, `theHarvester`, `Velocidex/velociraptor`, `TheHive`, `malwoverview`, `ForensicsTools`, `forensicosint.com`, `deaddrop.theosintconsultants.com`, `xcircle.me`, `opensourcemalware.com`, `cybermonit.com/leaks`, `privacyguides.org`, `thenewoil.org`.

---

## 6. Supply-Chain Advisories & Read-Only Threat Intel

* **⚠️ ARTEX Supply-Chain Advisory (`darkfibr/artex-forensics`)**: Blackfish Security's static binary disassembly proved the legacy `tomicdd/artex` Docker Hub image carried an unauthenticated root RCE backdoor in `server.verifyCaptcha`, and that deleted upstream `Autumn-27/ARTEX` removed engagement-scope checks (`guard/guard.go`). **Never run third-party prebuilt ARTEX containers**; evaluate only audited source builds like [`failsafe-security/artex`](https://github.com/failsafe-security/artex) inside an isolated authorized lab.
* **Read-Only Threat-Intel Indexes**: Prompt-injection mitigation/research (`Valhall-ai/prompt-injection-mitigations`, `trailofbits/anamorpher`, `utkusen/promptmap`, `ZeroLeaks/zeroleaks`, `elder-plinius/CL4R1T4S`, `unjail.ai`) and defensive darkweb breach-monitoring references (`DedSecInside/TorBot`, `s-rah/onionscan`, `ahmia/ahmia-site`, `megadose/OnionSearch`, `iudicium/pryingdeep`, `jobiryasir/darkweb-data-breach-osint`) are indexed purely as read-only defensive/CTI references.

---

## 🤝 Sibling Ecosystem

* 🎨 **[`RLealz/ai-design-playbook`](https://github.com/RLealz/ai-design-playbook)**: Sister repository covering UI/UX engineering, GSAP/Three.js/WebGL motion, Remotion/Blender video pipelines, `DESIGN.md` vaults, and anti-slop craft gates.
* 🛡️ **`RLealz/ai-security-playbook`** *(this repo)*: Sister repository covering defensive AppSec, AI/LLM guardrails, Vault-First authorized pentesting, Cloud/K8s hardening, Web3 audits, OSINT, and forensics.

## 📄 License

The built-in meta-skills, combo orchestrators, installer scripts, and quarantine scanner in this repository are released under the [MIT License](LICENSE). All upstream skill repositories and tools fetched by the installer retain their respective upstream licenses (`MIT`, `Apache-2.0`, `CC-BY-SA-4.0`, `AGPL-3.0`, etc.).
