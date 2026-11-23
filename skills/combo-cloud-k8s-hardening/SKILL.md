---
name: combo-cloud-k8s-hardening
description: >
  Combo 4 Orchestrator: Cloud, Container, Kubernetes & Purple-Team Hardening. Use when hardening AWS/Azure/GCP IAM,
  Docker/Compose stacks, Kubernetes manifests, CI/CD pipelines, WAF rules, or SIEM/Sigma detections. Orchestrates
  project-codeguard and vaulted Blue-Team framework skills alongside Trivy, Wazuh, SigmaHQ, Atomic Red Team,
  Cynative, BunkerWeb, and owLSM.
license: MIT
metadata:
  author: RLealz
  version: "1.0.0"
---

# ☁️ Combo 4: Cloud, Container, K8s & Purple-Team Hardening

Execute this **5-Phase Cloud & Detection Hardening Pipeline** when reviewing infrastructure-as-code, containers, runtime clusters, or blue-team telemetry:

---

## Phase 1: Baseline Compliance & Posture Mapping (`project-codeguard` + `anthropic-cybersecurity-skills` Blue-Team)
1. Align baseline controls to the target stack (NIST CSF 2.0, CIS Docker/Kubernetes Benchmarks, MITRE ATT&CK).
2. Identify blast radius: admin IAM policies, wildcard cloud roles, public object buckets, exposed management ports, and shared container sockets.

## Phase 2: Container, IaC & Dependency Vulnerability Scan (`aquasecurity/trivy` + `cynative/cynative`)
1. Audit Dockerfiles, Kubernetes YAML/Helm charts, Terraform plans, and SBOMs with `trivy`.
2. Enforce non-root containers, read-only root filesystems where possible, dropped Linux capabilities, pinned image SHA-256 digests, and network policies (`NetworkPolicy` default-deny egress/ingress).

## Phase 3: Secrets, CI/CD & Perimeter Hardening (`trufflesecurity/trufflehog` + `bunkerity/bunkerweb`)
1. Scan Git history and CI workflows for hardcoded keys, overly permissive GitHub Actions `GITHUB_TOKEN` scopes, and unpinned third-party actions (`pull_request_target` hazards).
2. Harden internet-facing ingress with strict TLS, rate limiting, and WAF rules (`bunkerweb`).

## Phase 4: Detection Engineering & Purple-Team Validation (`wazuh` + `SigmaHQ/sigma` + `redcanaryco/atomic-red-team` + `Cybereason-Public/owLSM` + `ipurple.team`)
1. Map critical cloud/host attack paths to `SigmaHQ/sigma` detection rules, `wazuh` alerts, or kernel-level `owLSM` eBPF rules.
2. Validate telemetry only in an isolated test environment with benign `atomic-red-team` checks to confirm alert fidelity before production rollout.

## Phase 5: Hardening Verification Checklist
- [ ] Zero privileged containers, exposed host sockets, or wildcard IAM/RBAC admin bindings remain unjustified.
- [ ] Container base images and critical GitHub Actions are SHA-pinned and scanned clean in CI.
- [ ] Detection rules cover identity escalation, container breakout, and anomalous outbound egress.
