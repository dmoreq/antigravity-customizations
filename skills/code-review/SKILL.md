---
name: code-review
description: "Conduct multi-axis code review. Use before merging any change. Evaluates correctness, readability, architecture, security, and performance with actionable severity labels."
risk: safe
source: local
date_added: "2026-02-27"
---

# Code Review Skill

Multi-axis code review with a practical approval standard: approve when the change clearly improves overall code health, even if it is not perfect.

## When to Use
- Before merging a PR or applying a significant change
- After feature implementation, bug fix, or refactor
- When evaluating code produced by another agent or model
- When a change needs a structured quality gate

## When Not to Use
- Trivial typo/docs-only edits with no behavioral risk
- Early exploratory spikes that are not intended for merge
- Pure research/analysis tasks with no code change

## Approval Standard
Approve when the change:
- Improves the codebase overall
- Matches project conventions
- Does not introduce unacceptable correctness, security, or maintainability risk

Do not block only because the solution is not exactly how you would have written it.

## Five-Axis Review

### 1. Correctness
- Matches the task/spec
- Handles edge cases and error paths
- Tests are meaningful and pass
- No obvious logic bugs, race conditions, or state inconsistencies

### 2. Readability & Simplicity
- Clear names and straightforward control flow
- Related logic is grouped; no unnecessary cleverness
- Comments explain non-obvious intent only
- No dead code, leftover shims, or tangled conditionals on unrelated flows

### 3. Architecture
- Fits existing patterns unless a new pattern is justified
- Clean module boundaries and dependency direction
- Avoids over-abstraction and feature logic leaking into shared modules
- Prefers deleting complexity over relocating it
- Reuses canonical helpers instead of near-duplicates

### 4. Security (Boundary Checklist)
- **Always**:
  - Validate and sanitize all input at trust boundaries (APIs, public interfaces)
  - Parameterize all database queries (zero string concatenation in SQL/commands)
  - Encode output to prevent injection and XSS
  - Enforce explicit AuthN/AuthZ checks on protected resources
- **Never**:
  - Log secrets, tokens, passwords, or sensitive PII
  - Trust client-side validation as a security boundary
  - Expose raw internal stack traces or system details to clients

### 5. Performance
- No N+1 or unbounded work on hot paths
- Expensive operations are justified
- Pagination/limits where needed
- No obvious blocking work in async/request paths

If deeper investigation is needed:
- Security deep-dive → dedicated security guidance
- Runtime bottleneck analysis → `python-performance`

## Review Process
1. **Understand intent** — what changed, why, expected behavior
2. **Review tests first** — coverage of behavior, edge cases, regressions
3. **Review implementation** across the five axes
4. **Categorize findings** by severity
5. **Verify verification** — tests/build/manual checks actually done

## Finding Severity
| Label | Meaning | Action |
| :--- | :--- | :--- |
| **Critical** | Security, data loss, broken behavior | Must fix before merge |
| **Required** | Important defect or structural issue | Must address or justify |
| **Optional / Consider** | Improvement suggestion | Author discretion |
| **Nit** | Style/preference | Optional |
| **FYI** | Context only | No action |

Lead with high-leverage issues. A few strong findings beat a long nit list.

## Change Sizing & Git Discipline
- **Sizing targets**: ~100 lines changed (ideal), ~300 lines (acceptable for single logical change), >1000 lines (split required).
- **Atomic Commits**: Each commit must represent a single, self-contained logical unit.
- **Slicing Strategies**: Split large changes into vertical slices, shared foundation PRs, or stacked PRs.
- **Isolate Refactors**: Strictly separate pure refactoring from behavioral/feature changes into distinct commits/PRs.

## Structural Remedies
When flagging structure problems, propose a concrete move:
- Replace conditional chains with a model/dispatcher
- Extract orchestration from business logic
- Move feature logic into the owning module
- Reuse the canonical helper
- Delete pass-through abstractions
- Split oversized files before adding more

## Dependency Discipline
Before accepting a new dependency, check:
- Can the current stack already solve it?
- Maintenance status and security posture
- Size/license impact
Prefer standard library and existing utilities.

## Dead Code Hygiene
After review/refactor, identify newly unused code and ask before deleting when uncertain.

## Related Skills
- Send implementation fixes to **python-pro**.
- Use **code-simplification** when complexity, deep nesting, or duplication is flagged.
- Use **deprecation-migration** when retiring legacy APIs or sunsetting duplicate paths.
- Use **python-testing** when tests are missing or weak.
- Use **python-performance** only for confirmed runtime concerns.
- Use **context7-mcp** when reviewing API usage against current docs.

## Review Checklist
- [ ] Intent and scope are understood
- [ ] Tests cover the change and likely regressions
- [ ] Correctness issues checked
- [ ] Readability/simplicity is acceptable
- [ ] Architecture fits the system
- [ ] Security boundaries are respected
- [ ] No obvious performance footguns
- [ ] Findings are severity-labeled
- [ ] Verdict is explicit: Approve / Request changes

## Verdict Format
- **Approve** — ready to merge
- **Request changes** — list Critical/Required items first, then optional suggestions

## Anti-Patterns
- Rubber-stamp "LGTM" without real review
- Blocking on pure style preference when code health improved
- Accepting "fix later" for known structural/security issues
- Reviewing only whether tests pass
- Leaving severity unlabeled
