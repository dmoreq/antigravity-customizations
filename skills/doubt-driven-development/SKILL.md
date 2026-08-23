---
name: doubt-driven-development
description: "Subject non-trivial decisions to adversarial review before they harden. Stress-tests assumptions, edge cases, and high blast-radius changes."
risk: safe
source: local
date_added: "2026-08-23"
---

# Doubt-Driven Development Skill

Subject non-trivial decisions to adversarial review before they harden into permanent architecture.

## When to Use
- Architectural or design choices made under uncertainty
- Branching logic, cross-module contracts, concurrency, or security-sensitive behavior
- Claims not fully enforced by types, compiler, or tests yet
- High blast-radius changes: public APIs, data migrations, production-critical flows
- Unfamiliar code or systems where confidence may be false

## When Not to Use
- Mechanical edits: renames, formatting, moving files
- Obvious one-line fixes or trivial adjustments
- User explicitly prioritizes speed over verification
- Pure exploratory research with no decision being locked in

## Non-Triviality Test
Trigger this skill if at least one condition holds:
- Introduces or modifies complex branching or state transitions
- Crosses module, service, or trust boundaries
- Asserts invariants not yet protected by automated tests or types
- The change is expensive or risky to reverse

## Process (5-Step Doubt Loop)

### 1. CLAIM
State the decision clearly in 2–3 lines along with why it matters and what is at stake.

### 2. EXTRACT
Isolate the smallest reviewable artifact and its contract. Strip prior self-justifying reasoning to prevent bias.

### 3. DOUBT (Adversarial Stress-Test)
Review adversarially to find disproof and failure modes, not to validate or approve.

```text
Find what is wrong with this artifact.
Assume the author is overconfident.
Look for unstated assumptions, missing edge cases, hidden coupling,
contract violations, and failure modes.
Do not validate. Do not summarize.
List concrete issues, or state that none were found.

ARTIFACT:
CONTRACT:
```

### 4. RECONCILE
Classify each adversarial finding:
- **Contract unclear**: Ambiguity in requirements or boundary conditions
- **Actionable fix**: Concrete bug or architectural risk requiring immediate fix
- **Accepted trade-off**: Known limitation with acceptable risk
- **Noise**: False positive (verify against the code before discarding)

### 5. STOP
Terminate the doubt loop when:
- Remaining findings are trivial/noise
- 3 adversarial cycles are completed (escalate if still unresolved)
- Residual risk is explicitly accepted by the user

## Core Rules
- Pass only the artifact + contract; do not feed prior self-justifications into the reviewer.
- Prefer disproof over approval.
- Do not loop beyond 3 cycles; escalate open dilemmas to the user.
- This is an in-flight design stress-test, not a replacement for final code review.

## Related Skills
- Use **code-review** as the final quality gate before merging.
- Use **python-testing** to convert important doubts into permanent regression tests.
- Use **tech-research** when doubt reveals unconsidered alternatives or SOTA options.
- Use **code-simplification** only after the design and invariants are sound.
- Use **deprecation-migration** when the decision concerns high-risk cutover or legacy sunsetting.

## Final Checklist
- [ ] Decision is verified to be non-trivial
- [ ] Claim, rationale, and stakes are explicitly stated
- [ ] Artifact and contract are isolated cleanly
- [ ] Review prompt is genuinely adversarial (seeks failure modes)
- [ ] Findings are classified and prioritized
- [ ] Actionable issues are fixed or explicitly deferred
- [ ] Stop condition reached ($\le 3$ cycles)
- [ ] Residual risks are visible and communicated to the user
