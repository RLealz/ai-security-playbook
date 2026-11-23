---
name: combo-web3-smart-contract-audit
description: >
  Combo 5 Orchestrator: Web3 & Smart Contract Security Audit. Use when auditing Solidity, Vyper, EVM, or Solana
  smart contracts, DeFi protocols, tokenomics invariants, or on-chain transactions. Orchestrates trailofbits-skills,
  solidity-security, devdacian/ai-auditor-primers, Slither, Echidna, Mythril, Surya, DeFiHackLabs, Solodit,
  Certora Prover, and Cyfrin Audit Checklists.
license: MIT
metadata:
  author: RLealz
  version: "1.0.0"
---

# ⛓️ Combo 5: Web3 & Smart Contract Security Audit

Execute this **5-Phase Smart Contract Audit Pipeline** across Solidity/EVM or Solana/Rust protocols before mainnet deployment or bounty submission:

---

## Phase 1: Protocol Mental Model & Checklist Baseline (`Cyfrin/audit-checklist` + `devdacian/ai-auditor-primers` + `ConsenSysDiligence/surya`)
1. Map inheritance graphs, upgradeability proxies, admin/multisig timelocks, token precision/decimals, and external DeFi integrations (oracles, AMMs, bridges, flash-loan callbacks).
2. Define **Protocol Invariants** explicitly (e.g., total shares vs underlying vault assets, solvency guarantees, access-control monotonicity).

## Phase 2: Static Analysis & Known Vulnerability Sweeps (`trailofbits-skills` + `crytic/slither` + `ConsenSysDiligence/mythril`)
1. Run `slither` and symbolic execution (`mythril`) across the build tree; separate real state-corruption paths from benign gas/informational hints.
2. Cross-reference integration patterns against **`Cyfrin Solodit`** (`solodit.cyfrin.io`) and **`SunWeb3Sec/DeFiHackLabs`** historical root-cause postmortems (read-only reentrancy, fee-on-transfer/rebasing tokens, oracle staleness, rounding direction, first-depositor inflation, EIP-712 signature replay).

## Phase 3: Stateful Fuzzing & Formal Verification (`crytic/echidna` + Foundry Fuzz + `certora.com`)
1. Write Foundry invariant tests and `echidna` property tests asserting accounting and authorization invariants across randomized call sequences.
2. For critical core invariants (vault solvency, liquidation math), specify CVL formal rules via `Certora Prover` where applicable.

## Phase 4: Adversarial Exploit Reproduction in Local Fork (`SunWeb3Sec/DeFiHackLabs`)
1. Test every high/medium finding inside a local deterministic Foundry anvil/fork harness (`forge test -vvvv`) to verify exact profit/loss deltas, gas limits, and preconditions.
2. Never ship unverified "possible reentrancy" findings without proving external call control flow and state mutation order.

## Phase 5: Audit Deliverable & Mitigation Verification
- [ ] Complete Finding Report with Severity, Invariant Violated, Executable Foundry PoC, and Exact Patch Diff.
- [ ] Re-run `slither` and full Foundry test/invariant suite after fixes cleanly.
- [ ] Check deployer/signer Operational Security (`OffcierCia/Crypto-OpSec-SelfGuard-RoadMap`, `unphishable.io`).
