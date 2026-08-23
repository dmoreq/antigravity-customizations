---
name: python-testing
description: "Implement comprehensive testing strategies with pytest, fixtures, mocking, and test-driven development. Use when writing Python tests, setting up test suites, or implementing testing best practices."
risk: safe
source: local
date_added: "2026-02-27"
---

# Python Testing Skill

Practical guidance for designing and writing effective Python tests with pytest.

## When to Use
- Writing unit, integration, or API tests in Python
- Setting up pytest suites, fixtures, and test layout
- Applying TDD in a pragmatic way
- Mocking external dependencies
- Testing async code
- Improving flaky, slow, or hard-to-maintain tests

## When Not to Use
- Non-Python testing
- Pure production-feature implementation with no test intent
- Load/performance benchmarking as the primary goal

## Core Principles
1. Test behavior and contracts, not implementation details.
2. Prefer fast, deterministic unit tests for core logic.
3. Use integration tests for boundaries (DB, API, filesystem).
4. Mock only what you do not own or cannot control reliably.
5. Keep tests readable: arrange → act → assert.
6. Optimize for maintainability over maximum coverage theater.

## Test Strategy
| Layer | Purpose | Typical Tools |
| :--- | :--- | :--- |
| **Unit** | Business logic, pure functions, services | pytest, parametrize |
| **Integration** | API routes, DB, queue, external boundaries | pytest + TestClient/httpx |
| **End-to-end** | Critical user/system flows | fewer, high-value tests |

Prioritize:
1. Critical paths
2. Edge cases and failure modes
3. Regression coverage for previously fixed bugs

## Pytest Patterns
- Use **fixtures** for reusable setup, not hidden magic.
- Use **parametrize** for input matrix testing.
- Prefer factory helpers over giant fixture graphs.
- Keep one main behavior per test.
- Name tests by behavior: `test_rejects_invalid_token`, not `test_1`.

## Mocking Guidelines
Mock when:
- External HTTP APIs
- Third-party services
- Time, randomness, or unstable boundaries

Do not mock when:
- The logic under test itself
- In-process pure functions
- Local code you can exercise directly

Prefer explicit mocks and fakes over over-spy heavy tests.

## Async Testing
- Use `pytest-asyncio` for async def tests.
- Test success, timeout, cancellation, and exception paths.
- Avoid `sleep`-based assertions when deterministic waits are possible.

## TDD Guidance
Use TDD when it improves design clarity:
1. Write a failing test for the intended behavior
2. Implement the minimal code to pass
3. Refactor with tests green

Skip rigid TDD ritual for pure exploration spikes; add tests before stabilizing the code.

## Systematic Debugging (Bug Fixing Loop)
When diagnosing and fixing bugs, follow this 4-step loop:
1. **Reproduce**: Write a minimal, deterministic failing test reproducing the exact issue.
2. **Isolate**: Locate the exact line/boundary where actual state diverges from expected state.
3. **Fix**: Implement the minimal, clean fix for the root cause.
4. **Guard**: Keep the failing test as a permanent **regression test** to prevent future recurrence.

## Test Design Checklist
- [ ] Behavior under test is clear
- [ ] Test is deterministic and isolated
- [ ] Assertions are specific and meaningful
- [ ] External dependencies are handled appropriately
- [ ] Failure messages are diagnosable
- [ ] Edge cases and error paths are considered
- [ ] Test runtime stays reasonable

## Related Skills
- Use with **python-pro** and **python-concurrency** to protect implementation changes.
- Use **code-review** as the final quality gate before merge.

## Output Expectations
- Clear recommendation of test layers needed
- Concrete pytest structure and naming
- Focused examples when useful
- Notes on trade-offs (what to mock, what not to mock)
- Guidance that keeps tests maintainable
