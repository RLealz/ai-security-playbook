---
name: combo-osint-attack-surface
description: >
  Combo 6 Orchestrator: Authorized OSINT, Attack-Surface Mapping & Threat Intel. Use for passive attack-surface
  enumeration, domain/subdomain discovery, leaked-credential risk assessment, brand exposure checks, and evidence-first
  investigation. Orchestrates vaulted claude-osint and ex-ussr-kinship-research alongside OpenOSINT, BBOT, Subfinder,
  Web-Check, Maigret, Sherlock, Darknet MCP Server (threat intel), Forensic OSINT, and OpenSourceMalware.
license: MIT
metadata:
  author: RLealz
  version: "1.0.0"
---

# 🌐 Combo 6: Authorized OSINT, Attack-Surface & Threat Intel

> **ETHICAL & LEGAL BOUNDARY**: Restrict active enumeration to authorized asset scopes, and keep personal/entity OSINT strictly within lawful passive verification, CTI, fraud investigation, or research boundaries.

Execute this **5-Phase Evidence-First OSINT & Exposure Workflow**:

---

## Phase 1: Scope & Collection Hypothesis (`claude-osint` *(Vault)*)
1. Define exact target anchors (root domains, ASNs, cloud org tenants, handles, or breach IOCs) and record authorization basis.
2. Prioritize **passive collection first** (certificate transparency, passive DNS, WHOIS/RDAP, ASN/BGP routing, public code/SaaS exposures) before touching target infrastructure directly.

## Phase 2: Passive Asset & Web Surface Enumeration (`OpenOSINT` + `subfinder` + `web-check` + `bbot`)
1. Gather subdomains, dangling DNS/CNAME takeover candidates, exposed staging portals, public buckets, API documentation leaks, and TLS/security header posture (`lissy93/web-check`).
2. Cross-reference organizational footprints using `theHarvester` and passive threat feeds without noisy brute-forcing unless explicitly in-scope.

## Phase 3: Identity, Graph Correlation & Breach Triage (`maigret` + `sherlock` + `holehe` + `xcircle.me` + `badchars/darknet-mcp-server`)
1. Correlate confirmed handles, email domains (SPF/DKIM/DMARC/exposure), and breach intelligence (`opensourcemalware.com`, `cybermonit.com/leaks`, `TorBot`/`OnionSearch` strictly for defensive breach-monitoring and CTI).
2. Enforce **evidence grading**: distinguish verified hard links (cryptographic keys, confirmed org domains, matching PGP/commits) from circumstantial username collisions.

## Phase 4: Historical & Archival Evidence Preservation (`forensicosint.com` + `ex-ussr-kinship-research` patterns)
1. Preserve primary evidence cleanly: UTC timestamps, exact capture URLs, content hashes (SHA-256), and chain-of-custody notes (`archive`, Wayback, certificate fingerprints).
2. Maintain strict analyst privacy & OPSEC (`privacyguides.org`, `thenewoil.org/en`).

## Phase 5: Exposure & Threat-Intel Brief
- [ ] Every asset/IOC tagged with Source, Confidence (`Confirmed` / `Corroborated` / `Unverified`), Discovery Date, and Recommended Mitigation (e.g., DNS cleanup, credential rotation, SaaS deprovisioning).
