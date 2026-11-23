# 🛡️ Complete AI Security, Pentest, AppSec, Web3, OSINT & Forensics Resource Catalog

This reference file is packaged directly inside `security-router` so AI coding agents have immediate structured access to curated AI/LLM security scanners, autonomous agent frameworks, security MCP servers, AppSec/Web3/OSINT toolchains, and verified supply-chain advisories.

---

## 1. AI & LLM Security Scanners, Guardrails & Agent Red-Teaming

| Resource / Repo | Location / URL | Primary Capability |
| :--- | :--- | :--- |
| **Promptfoo (`promptfoo/promptfoo`)** | [promptfoo.dev](https://promptfoo.dev) ([GitHub](https://github.com/promptfoo/promptfoo)) | Industry-standard prompt, agent, and RAG testing + automated LLM red-teaming & vulnerability scanning. |
| **NVIDIA Garak (`NVIDIA/garak`)** | [`NVIDIA/garak`](https://github.com/NVIDIA/garak) | Comprehensive open-source LLM vulnerability scanner probing jailbreaks, leakage, and hallucinations. |
| **DeepTeam (`confident-ai/deepteam`)** | [`confident-ai/deepteam`](https://github.com/confident-ai/deepteam) | Multi-strategy red-teaming framework for LLMs and multi-turn AI agent architectures. |
| **Cisco AI Defense Skill Scanner** | [`cisco-ai-defense/skill-scanner`](https://github.com/cisco-ai-defense/skill-scanner) | Static & behavioral scanner purpose-built to audit Agent Skills (`SKILL.md`) before installation. |
| **OpenGuardrails** | [`openguardrails/openguardrails`](https://github.com/openguardrails/openguardrails) | Open-source local rules, sandbox, and firewall guardrails for AI coding and autonomous agents. |
| **Adversarial Robustness Toolbox (ART)** | [`Trusted-AI/adversarial-robustness-toolbox`](https://github.com/Trusted-AI/adversarial-robustness-toolbox) | Linux Foundation / IBM Python toolkit for ML evasion, poisoning, extraction, and inference defenses. |
| **Agentic Radar (`splx-ai/agentic-radar`)** | [`splx-ai/agentic-radar`](https://github.com/splx-ai/agentic-radar) | Security topology & vulnerability scanner for multi-agent LLM workflows. |
| **AI Infrastructure Guard (`Tencent/AI-Infra-Guard`)** | [`Tencent/AI-Infra-Guard`](https://github.com/Tencent/AI-Infra-Guard) | Full-stack AI Red Teaming suite (Agent Scan, Skills Scan, MCP Scan, and AI Infra Scan). |
| **Vibe Shield (`avivgerz-hue/vibe-shield`)** | [`avivgerz-hue/vibe-shield`](https://github.com/avivgerz-hue/vibe-shield) | 92-rule static SAST scanner, secret detector, Supabase RLS auditor & `SKILL.md` injection guard. |
| **AgentShield (`affaan-m/agentshield`)** | [`affaan-m/agentshield`](https://github.com/affaan-m/agentshield) | Configuration, hook, permission, and secret auditor for Claude Code and `.agents` harnesses. |
| **Tirith (`sheeki03/tirith`)** | [`sheeki03/tirith`](https://github.com/sheeki03/tirith) | Terminal security guardrail for devs & agents intercepting homograph URLs, pipe-to-shell, and ANSI injection. |
| **ClawSec / SecureClaw / OpenClaw Security** | [`prompt-security/clawsec`](https://github.com/prompt-security/clawsec) · [`adversa-ai/secureclaw`](https://github.com/adversa-ai/secureclaw) · [`UseAI-pro/openclaw-skills-security`](https://github.com/UseAI-pro/openclaw-skills-security) | OWASP-aligned security suites, drift detection, credential scanning, and injection hardening for agentic ecosystems. |
| **Project CodeGuard (`cosai-oasis/project-codeguard`)** | [`cosai-oasis/project-codeguard`](https://github.com/cosai-oasis/project-codeguard) | CoSAI / OASIS model-agnostic secure-by-default rules and skill workflows for coding agents. |
| **AIGoat & AgentDojo** | [`AISecurityConsortium/AIGoat`](https://github.com/AISecurityConsortium/AIGoat) · [`ethz-spylab/agentdojo`](https://github.com/ethz-spylab/agentdojo) | Local AI security playgrounds & dynamic evaluation environments for agent attacks and defenses. |
| **ModelScan (`protectai/modelscan`)** | [`protectai/modelscan`](https://github.com/protectai/modelscan) | Protects against unsafe ML model serialization (`pickle`, `SavedModel`, PyTorch) attacks. |
| **CyberGym (`sunblaze-ucb/cybergym`)** | [`sunblaze-ucb/cybergym`](https://github.com/sunblaze-ucb/cybergym) | Large-scale academic evaluation framework measuring cybersecurity capabilities of AI agents. |
| **Arcanum Sec-Context** | [`Arcanum-Sec/sec-context`](https://github.com/Arcanum-Sec/sec-context) | AI Code Security Anti-Patterns distilled from 150+ sources to prevent insecure code generation. |
| **Gray Swan Arena & LLM Security Hubs** | [app.grayswan.ai/arena](https://app.grayswan.ai/arena) · [adversa.ai](https://adversa.ai/) · [LLM Security Notion](https://chawins.notion.site/llm-sp?v=03e416a926f54ff8aaa813aacf4c6cc9) | Interactive AI red-teaming benchmarks, Top-10 agentic threat taxonomies, and security research trackers. |

---

## 2. Autonomous AI Security & Penetration Testing Agent Frameworks

> **Authorized Engagement Rule**: These are full standalone multi-agent runtimes, not lightweight `SKILL.md` plugins. Deploy only in isolated project sandboxes/containers against systems you own or have written authorization to test.

| Framework | Repo | License | Core Architecture |
| :--- | :--- | :---: | :--- |
| **Strix** | [`usestrix/strix`](https://github.com/usestrix/strix) | Apache-2.0 | Open-source AI penetration testing tool to discover and patch application vulnerabilities. |
| **Shannon** | [`KeygraphHQ/shannon`](https://github.com/KeygraphHQ/shannon) | AGPL-3.0 | Whitebox-to-live-exploit AI web/API pentester producing proof-of-concept validation. |
| **PentAGI** | [`vxcontrol/pentagi`](https://github.com/vxcontrol/pentagi) | MIT | Fully autonomous containerized multi-agent system executing structured penetration tests. |
| **PentestGPT** | [`GreyDGL/PentestGPT`](https://github.com/GreyDGL/PentestGPT) | MIT | LLM-powered interactive penetration testing orchestration framework. |
| **Cybersecurity AI (CAI)** | [`aliasrobotics/cai`](https://github.com/aliasrobotics/cai) | Custom | Modular open framework for offensive and defensive Cybersecurity AI agents. |
| **FailSafe ARTEX (Audited Build)** | [`failsafe-security/artex`](https://github.com/failsafe-security/artex) | AGPL-3.0 | Hardened, localhost-bound `v0.3.15` source-built ARTEX distribution *(prefer over legacy `tomicdd/artex`)*. |
| **BaaRai ARTEX (Active English Fork)** | [`BaaRai/ARTEX`](https://github.com/BaaRai/ARTEX) | AGPL-3.0 | Active English continuation (patched `docker-compose.yml` to build from source; see Section 7 advisory). |
| **RedAmon** | [`samugit83/redamon`](https://github.com/samugit83/redamon) | MIT | Graph-backed autonomous recon-to-exploitation framework for continuous attack-surface testing. |
| **Decepticon** | [`BitterSecurity/Decepticon`](https://github.com/BitterSecurity/Decepticon) | Apache-2.0 | Autonomous red-team emulation agent architecture. |
| **Pentest-Swarm-AI** | [`Armur-Ai/Pentest-Swarm-AI`](https://github.com/Armur-Ai/Pentest-Swarm-AI) | AGPL-3.0 | Multi-agent swarm splitting recon, classification, validation, and reporting roles. |
| **Open-Kritt** | [`Kritt-ai/open-kritt`](https://github.com/Kritt-ai/open-kritt) | AGPL-3.0 | Self-hosted AI vulnerability research orchestrator finding and validating source issues. |
| **Pentest-AI & Pentest-AI-Agents** | [`0xSteph/pentest-ai`](https://github.com/0xSteph/pentest-ai) · [`0xSteph/pentest-ai-agents`](https://github.com/0xSteph/pentest-ai-agents) | MIT | Oracle-verified proof-backed AI pentester + modular Claude Code security subagents. |
| **OpenHack** | [`hadriansecurity/OpenHack`](https://github.com/hadriansecurity/OpenHack) | MIT | Lightweight, file-based workspace for source-guided whitebox security review. |
| **OpenHunterAI** | [`LumosLab-Innovation/OpenHunterAI`](https://github.com/LumosLab-Innovation/OpenHunterAI) | Custom | Local-first AI red-team engine for web, API, and LLM application testing. |
| **Evilsocket Audit** | [`evilsocket/audit`](https://github.com/evilsocket/audit) | MIT | 8-stage autonomous source-code vulnerability discovery agent. |
| **Cynative** | [`cynative/cynative`](https://github.com/cynative/cynative) | Apache-2.0 | Multi-cloud AI detection and compliance framework across AWS, Azure, GCP & Kubernetes. |
| **CyberStrike** | [`CyberStrikeus/CyberStrike`](https://github.com/CyberStrikeus/CyberStrike) | AGPL-3.0 | AI-assisted penetration testing harness with structured command orchestration. |
| **DeepSec & Mantis** | [`vercel-labs/deepsec`](https://github.com/vercel-labs/deepsec) · [`google/mantis`](https://github.com/google/mantis) | Apache-2.0 | Coding-agent harnesses from Vercel Labs and Google for finding, reproducing, and patching code flaws. |

---

## 3. Security, Vulnerability & OSINT MCP Servers

| MCP Server | Repo / URL | Primary Domain | Capability |
| :--- | :--- | :--- | :--- |
| **HexStrike AI** | [`0x4m4/hexstrike-ai`](https://github.com/0x4m4/hexstrike-ai) | Offensive / Recon | MCP orchestrator exposing recon, scanning, and web testing toolchains to coding agents. |
| **Semgrep MCP** | [`semgrep/mcp`](https://github.com/semgrep/mcp) | AppSec / SAST | Official Semgrep MCP server for deterministic static analysis & custom rule queries inside editors. |
| **OpenOSINT** | [`OpenOSINT/OpenOSINT`](https://github.com/OpenOSINT/OpenOSINT) | Passive OSINT | Open-source passive OSINT engine exposing 21 investigative checks via CLI, Web UI, and MCP. |
| **Darknet MCP Server** | [`badchars/darknet-mcp-server`](https://github.com/badchars/darknet-mcp-server) | Threat Intel | 66-tool read-only/investigative MCP server for breach intelligence, Tor `.onion` monitoring & triage. |
| **Reverse Engineer Anything (`REA`)** | [`morluto/rea`](https://github.com/morluto/rea) | Reverse Engineering | Native binary, Electron/JS bundle, and mobile runtime inspection & reconstruction MCP server. |
| **PentestAgent** | [`0xSojalSec/PentestAgent`](https://github.com/0xSojalSec/PentestAgent) | Pentest / Tools | All-in-one security toolbox exposing Nmap and validation utilities over MCP. |
| **Vulnerator AI** | [`irraz/vulnerator-ai`](https://github.com/irraz/vulnerator-ai) | Autonomous Pentest | OODA-loop security agent wiring Playwright & Kali tooling over MCP mapped to MITRE ATT&CK. |
| **PentestGPT-MCP** | [`yuhano/PentestGPT-MCP`](https://github.com/yuhano/PentestGPT-MCP) | Automated Testing | LLM planning loop acting through structured MCP security tool wrappers. |
| **World Intel MCP** | [`marc-shade/world-intel-mcp`](https://github.com/marc-shade/world-intel-mcp) | OSINT / Geopolitics | 160-tool real-time global intelligence MCP over public threat, maritime, and infrastructure feeds. |
| **Damn Vulnerable MCP Server** | [`harishsg993010/damn-vulnerable-MCP-server`](https://github.com/harishsg993010/damn-vulnerable-MCP-server) | Training Lab | Deliberately vulnerable MCP lab for testing prompt injection, tool poisoning, and rug-pulls. |

---

## 4. AppSec, Cloud, Bug Bounty & Detection Toolchains

* **Core Scanners & SIEM/WAF**: [`aquasecurity/trivy`](https://github.com/aquasecurity/trivy) (container/K8s/IaC/SBOM), [`trufflesecurity/trufflehog`](https://github.com/trufflesecurity/trufflehog) (verified secrets), [`wazuh/wazuh`](https://github.com/wazuh/wazuh) (XDR/SIEM), [`SigmaHQ/sigma`](https://github.com/SigmaHQ/sigma) (SIEM rules), [`redcanaryco/atomic-red-team`](https://github.com/redcanaryco/atomic-red-team) (ATT&CK detection tests), [`bunkerity/bunkerweb`](https://github.com/bunkerity/bunkerweb) (WAF), [`Cybereason-Public/owLSM`](https://github.com/Cybereason-Public/owLSM) (eBPF kernel Sigma prevention).
* **Methodology, Reference & Weaponry Catalogs**: [`OWASP/wstg`](https://github.com/OWASP/wstg), [`OWASP/CheatSheetSeries`](https://github.com/OWASP/CheatSheetSeries), [`swisskyrepo/PayloadsAllTheThings`](https://github.com/swisskyrepo/PayloadsAllTheThings), [`danielmiessler/SecLists`](https://github.com/danielmiessler/SecLists), [`hahwul/WebHackersWeapons`](https://github.com/hahwul/WebHackersWeapons), [`A-poc/BlueTeam-Tools`](https://github.com/A-poc/BlueTeam-Tools), [`A-poc/RedTeam-Tools`](https://github.com/A-poc/RedTeam-Tools), [`Hack-with-Github/Awesome-Hacking`](https://github.com/Hack-with-Github/Awesome-Hacking).
* **Bug Bounty, AppSec & Purple-Team Web Hubs**:
  * **[HexBrain (`hexbrainai.com`)](https://hexbrainai.com/)** — Visual knowledge map of 15,000+ disclosed HackerOne bug bounty reports.
  * **[DefectDojo (`defectdojo.com`)](https://defectdojo.com)** — Open-source vulnerability management & ASPM orchestration platform.
  * **[Purple Team (`ipurple.team`)](https://ipurple.team)** — Detection engineering, threat hunting, and adversarial telemetry resources.
  * **[PortSwigger Top 10 Web Hacking Techniques 2025](https://portswigger.net/research/top-10-web-hacking-techniques-of-2025)** · **[GitHub Security Blog](https://github.blog/security)** · **[ZephrSec (`blog.zsec.uk`)](https://blog.zsec.uk)** · **[Joseph Thacker (`josephthacker.com`)](https://josephthacker.com)**.
  * **Hands-On Training & Labs**: **[Cyber Library (`cyberlibrary.com/en`)](https://cyberlibrary.com/en)** · **[TryHackMe (`tryhackme.com`)](https://tryhackme.com)** · **[Hackers-Arise (`hackers-arise.com`)](https://hackers-arise.com)**.

---

## 5. Web3 & Smart Contract Security Audits

* **Static, Symbolic & Fuzzing Analyzers**: [`crytic/slither`](https://github.com/crytic/slither), [`crytic/echidna`](https://github.com/crytic/echidna), [`ConsenSysDiligence/mythril`](https://github.com/ConsenSysDiligence/mythril), [`ConsenSysDiligence/surya`](https://github.com/ConsenSysDiligence/surya), **[Certora Prover](https://certora.com/signup)**.
* **Exploit Reproduction, Checklists & Primers**: [`SunWeb3Sec/DeFiHackLabs`](https://github.com/SunWeb3Sec/DeFiHackLabs), [`Cyfrin/audit-checklist`](https://github.com/Cyfrin/audit-checklist), [`Cyfrin/security-and-auditing-full-course-s23`](https://github.com/Cyfrin/security-and-auditing-full-course-s23), [`devdacian/ai-auditor-primers`](https://github.com/devdacian/ai-auditor-primers), [`0xMacro/awesome-solana-security`](https://github.com/0xMacro/awesome-solana-security), [`astrasecai/audit-reports`](https://github.com/astrasecai/audit-reports).
* **On-Chain Forensics, OpSec & Web Hubs**: [`OffcierCia/On-Chain-Investigations-Tools-List`](https://github.com/OffcierCia/On-Chain-Investigations-Tools-List), [`OffcierCia/Crypto-OpSec-SelfGuard-RoadMap`](https://github.com/OffcierCia/Crypto-OpSec-SelfGuard-RoadMap), **[Cyfrin Solodit (`solodit.cyfrin.io`)](https://solodit.cyfrin.io)**, **[Cyfrin Updraft (`updraft.cyfrin.io`)](https://updraft.cyfrin.io/dashboard)**, **[SCH AI Skills Explorer](https://smartcontractshacking.com/tools/ai-skills-explorer)**, **[RareSkills Smart Contract Security](https://rareskills.io/post/smart-contract-security)**, **[SecHub by Sub7](https://app.sechub.work/app)**, **[Unphishable (`unphishable.io`)](https://unphishable.io/)**.

---

## 6. OSINT, Attack-Surface, Privacy, Forensics & Reverse Engineering

* **External Recon & OSINT**: [`blacklanternsecurity/bbot`](https://github.com/blacklanternsecurity/bbot), [`projectdiscovery/subfinder`](https://github.com/projectdiscovery/subfinder), [`lissy93/web-check`](https://github.com/lissy93/web-check), [`soxoj/maigret`](https://github.com/soxoj/maigret), [`sherlock-project/sherlock`](https://github.com/sherlock-project/sherlock), [`laramies/theHarvester`](https://github.com/laramies/theHarvester), [`megadose/holehe`](https://github.com/megadose/holehe), [`jivoi/awesome-osint`](https://github.com/jivoi/awesome-osint), [`rawfilejson/awesome-osint-arsenal`](https://github.com/rawfilejson/awesome-osint-arsenal).
* **DFIR, Malware Triage & Incident Response**: [`Velocidex/velociraptor`](https://github.com/Velocidex/velociraptor), [`TheHive-Project/TheHive`](https://github.com/TheHive-Project/TheHive), [`alexandreborges/malwoverview`](https://github.com/alexandreborges/malwoverview), [`mesquidar/ForensicsTools`](https://github.com/mesquidar/ForensicsTools).
* **OSINT, Threat Intel & Privacy Hubs**: **[Forensic OSINT Guide](https://forensicosint.com/osint-guide)** · **[Deaddrop OSINT](https://deaddrop.theosintconsultants.com/dashboard)** · **[XCircle (`xcircle.me`)](https://xcircle.me/)** · **[OpenSourceMalware (`opensourcemalware.com`)](https://opensourcemalware.com)** · **[Cybermonit Breach DB](https://cybermonit.com/leaks)** · **[The New Oil Privacy Guide](https://thenewoil.org/en)** · [`privacyguides/privacyguides.org`](https://github.com/privacyguides/privacyguides.org).

---

## 7. Supply-Chain Advisories & Threat-Intel Research References (Read-Only)

### ⚠️ Active Supply-Chain Advisory: `ARTEX`
* **Finding (`darkfibr/artex-forensics`)**: [`darkfibr/artex-forensics`](https://github.com/darkfibr/artex-forensics) documents via static binary disassembly that the legacy prebuilt `tomicdd/artex` Docker Hub image contained an unauthenticated root RCE backdoor inside `server.verifyCaptcha`, and that upstream `Autumn-27/ARTEX` (now deleted) removed engagement-scope enforcement (`guard/guard.go`).
* **Mitigation**: Never pull third-party prebuilt ARTEX images. If evaluating ARTEX in an isolated authorized lab, use [`failsafe-security/artex`](https://github.com/failsafe-security/artex) (source-built, localhost-bound `v0.3.15`) or inspect the live source build in [`BaaRai/ARTEX`](https://github.com/BaaRai/ARTEX).

### LLM Prompt-Injection & Defensive Testing References *(Read-Only Threat Intel)*
Used to understand adversary techniques, evaluate guardrails (`promptfoo`, `garak`, `deepteam`), and harden system prompts:
* [`elder-plinius/CL4R1T4S`](https://github.com/elder-plinius/CL4R1T4S) · [`Valhall-ai/prompt-injection-mitigations`](https://github.com/Valhall-ai/prompt-injection-mitigations) · [`trailofbits/anamorpher`](https://github.com/trailofbits/anamorpher) · [`utkusen/promptmap`](https://github.com/utkusen/promptmap) · [`ZeroLeaks/zeroleaks`](https://github.com/ZeroLeaks/zeroleaks) · [`PromptLabs/Prompt-Hacking-Resources`](https://github.com/PromptLabs/Prompt-Hacking-Resources) · [`forcesunseen/llm-hackers-handbook`](https://github.com/forcesunseen/llm-hackers-handbook) · [unjail.ai](https://unjail.ai).

### Darkweb & Breach Monitoring Threat Intel *(Read-Only Threat Intel)*
Used strictly for authorized threat intelligence, credential leak detection, and SOC monitoring:
* [`DedSecInside/TorBot`](https://github.com/DedSecInside/TorBot) · [`s-rah/onionscan`](https://github.com/s-rah/onionscan) · [`ahmia/ahmia-site`](https://github.com/ahmia/ahmia-site) · [`megadose/OnionSearch`](https://github.com/megadose/OnionSearch) · [`iudicium/pryingdeep`](https://github.com/iudicium/pryingdeep) · [`badchars/darknet-mcp-server`](https://github.com/badchars/darknet-mcp-server) · [`jobiryasir/darkweb-data-breach-osint`](https://github.com/jobiryasir/darkweb-data-breach-osint).
