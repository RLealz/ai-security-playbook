---
name: combo-binary-re-forensics
description: >
  Combo 7 Orchestrator: Binary Reverse Engineering, Malware Forensics & Threat-Model Bluebook. Use when decompiling
  or inspecting native binaries, Electron/JS bundles, mobile apps, container backdoors, incident artifacts, or when
  authoring STRIDE/Attack-Tree Security Bluebooks. Orchestrates vaulted reverse-skill and raptor alongside REA MCP,
  Velociraptor, TheHive, Malwoverview, ForensicsTools, and ARTEX-Forensics case patterns.
license: MIT
metadata:
  author: RLealz
  version: "1.0.0"
---

# 🔬 Combo 7: Binary RE, Malware Forensics & Threat-Model Bluebook

Execute this **5-Phase Investigation & Threat-Modeling Workflow** inside a strictly **isolated offline/sandboxed analysis environment** (never execute untrusted samples on your host OS):

---

## Phase 1: Evidence Preservation & Safe Static Triage (`malwoverview` + `ForensicsTools` + `darkfibr/artex-forensics` pattern)
1. **Hash Everything First**: Compute SHA-256 digests of every binary, container layer, disk/memory image, or bundle before inspection.
2. **Static Diffing Before Execution**: Extract strings, imports/exports, ELF/PE/Mach-O headers, embedded manifests, and package scripts (`reverse-skill` *(Vault)*). Compare binary symbol tables against claimed upstream source (following the `artex-forensics` pattern that exposed backdoored container layers).

## Phase 2: Deep Decompilation & Protocol Reconstruction (`morluto/rea` MCP + `raptor` *(Vault)*)
1. Use **`REA` MCP (`morluto/rea`)** tools to systematically inspect procedures, cross-references, ObjC/Swift/managed boundaries, or unpacked Electron/JS bundles without guessing uninspected disassembly.
2. Build an **Unknowns & Verification Ledger**: track verified offsets/functions separately from hypothesized behavior until static/runtime correlation confirms them.

## Phase 3: Host, Memory & Incident DFIR Correlation (`Velocidex/velociraptor` + `TheHive`)
1. Triage persistence mechanisms, suspicious processes, network sockets, loaded DLLs/dylibs, and container/VM escape indicators.
2. Correlate indicators of compromise (`IOCs`) cleanly inside structured incident timelines (`TheHive`).

## Phase 4: Threat Modeling & Security Bluebook Architecture (`threat-modeling-expert` + `stride-analysis-patterns` + `attack-tree-construction` + `security-bluebook-builder`)
1. Translate forensic/RE findings into preventive design: run **STRIDE** analysis, map attacker **Attack Trees**, and identify missing trust-boundary enforcement (e.g., deleted authorization guards).
2. Document hardened architecture controls, SBOM/attestation requirements, and verification gates in a reusable **Security Bluebook**.

## Phase 5: Forensic & Threat-Model Sign-Off
- [ ] All artifacts SHA-256 hashed, statically analyzed first, and strictly isolated from production credentials.
- [ ] Every claim backed by exact offsets, disassembled/decompiled evidence, or verified packet/log traces.
- [ ] Actionable remediation + detection signatures delivered alongside root-cause analysis.
