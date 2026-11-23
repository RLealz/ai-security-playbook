---
name: combo-appsec-code-audit
description: >
  Combo 1 Orchestrator: Full-Stack AppSec & Codebase Security Audit. Use when auditing a repository, web app,
  REST/GraphQL API, authentication flow, database query layer, or Supabase RLS configuration for vulnerabilities.
  Orchestrates cloudflare-security-audit, anthropic-defending-code, vercel-deepsec, google-mantis,
  ghostsecurity-skills, vibe-shield, and project-codeguard alongside Semgrep MCP, TruffleHog, and Trivy.
license: MIT
metadata:
  author: RLealz
  version: "1.0.0"
---

# 🔐 Combo 1: Full-Stack AppSec & Codebase Security Audit

Execute this **5-Phase AppSec Audit Sequence** when reviewing source repositories, APIs, auth flows, or PR diffs so every layer is checked with zero duplicated guesswork:

---

## Phase 1: Architecture & Threat-Surface Context (`anthropic-defending-code` + `ghostsecurity-skills`)
1. **Map Entry Points & Trust Boundaries**: Enumerate HTTP routes, RPC/GraphQL resolvers, webhooks, background workers, file uploads, and database RLS / tenant-isolation boundaries.
2. **Identify High-Value Assets**: Map session/JWT issuance, billing/payment handlers, admin endpoints, secret stores, and outbound SSRF sinks (`fetch`, `axios`, `requests`, subprocess wrappers).

## Phase 2: Deterministic SAST, Secret & Dependency Sweep (`vibe-shield` + `semgrep/mcp` + `trufflehog` + `trivy`)
1. Run deterministic static checks before manual reasoning:
   * `vibe-shield` (92-rule static SAST, leaked secret patterns, Supabase RLS checks).
   * `semgrep/mcp` for AST-level injection, auth-bypass, deserialization, and XSS sinks.
   * `trufflehog` & `trivy` for leaked credentials, vulnerable dependencies, Dockerfiles, and IaC drift.
2. Triage noise up front: separate reachable user-controlled sources from dead code or test fixtures.

## Phase 3: Deep Vulnerability Triage & Verification (`cloudflare-security-audit` + `vercel-deepsec` + `google-mantis`)
1. **Verify Reachability**: For every candidate finding, trace source -> sanitizer/validator -> sink -> authorization check.
2. **Audit Access Control**: Check IDOR/BOLA on every object lookup, missing role checks on mutations, CORS misconfigurations, CSRF tokens, and JWT algorithm/expiry validation.
3. **Require Concrete Proof**: Only report findings backed by exact `file:line` traces, reproduction steps, or harness oracle verification (`deepsec` / `mantis`). Never ship speculative bugs.

## Phase 4: Minimal Hardening Patches (`project-codeguard` + `Arcanum-Sec/sec-context`)
1. Author minimal, idiomatic fixes (parameterized queries, fail-closed auth middleware, strict schema validation, safe HTML/URL sanitization, least-privilege IAM/RLS).
2. Re-run existing unit/integration suites plus security regression tests verifying both that the exploit path is closed and valid workflows stay intact.

## Phase 5: Executive Audit Report
For each confirmed finding, document:
- [ ] **Severity & CWE / OWASP Category** (verified impact, not theoretical worst-case).
- [ ] **Exact Location & Dataflow Proof** (`file:line` + request/code trace).
- [ ] **Patch Diff & Regression Verification Output** confirming the fix passes tests.
