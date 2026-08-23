---
name: python-pro
description: "Master modern Python with typing, async, performance optimization, and production practices. Adapts to Python 3.12+ features or legacy runtime constraints."
risk: safe
source: local
date_added: "2026-02-27"
---

# Modern Python Skill

Expert guidance for writing clean, typed, and production-ready Python code, with strong preference for Python 3.12+ practices when possible.

## When to Use
- Writing or reviewing Python code
- Setting up or modernizing a Python project
- Implementing async workflows or performance-sensitive code
- Designing production services, APIs, or tooling in Python

## When Not to Use
- Non-Python stacks
- Basic syntax questions only

## Related Skills
- Use **python-patterns** for framework, structure, and architecture decisions.
- Use **python-concurrency** for async/parallel implementation choices.
- Use **python-testing-patterns** to protect behavior with tests.
- Use **context7-mcp** for current library/API documentation.
- Use **code-review-and-quality** before merge.

## Version Handling
- Always confirm the target Python version first.
- If the project is on Python 3.12+: use modern features and tooling freely.
- If the project is locked to an older version (3.8–3.11) and cannot be upgraded:
  - Stay fully compatible with that version
  - Still apply modern practices that are supported (typing, structure, testing, compatible tooling)
  - Avoid 3.12+ only syntax and libraries
  - Note limitations and potential benefits of a future upgrade when relevant

## Core Principles
- Prefer the newest Python features allowed by the target version.
- Use strong typing (type hints, Protocol, generics) as much as the version supports.
- Prefer modern tooling when compatible: `uv`, `ruff`, `pyright`/`mypy`.
- Default to `pyproject.toml` when possible.
- Write readable, maintainable code first; optimize only when needed.
- Prefer the standard library when it is sufficient.
- Always consider error handling, testing, and production concerns.

## Recommended Defaults (adapt to version)
- **Package & environment**: `uv` (if supported) or compatible alternative
- **Lint + format**: `ruff`
- **Type checking**: `pyright` or `mypy`
- **Testing**: `pytest`
- **Config**: `pyproject.toml` when feasible
- **Data validation**: `pydantic` v2 if version allows, otherwise compatible approach
- **API**: `FastAPI` when building HTTP services (check version compatibility)
- **Async**: standard `asyncio` patterns appropriate for the target version

## Working Approach
1. Confirm Python version, dependencies, and constraints.
2. Choose patterns and tools that work with the target version.
3. Implement with clear structure, type hints, and proper error handling.
4. Add or update tests.
5. Run formatting, linting, and type checks compatible with the environment.
6. Profile and optimize only when there is a measured need.

## Output Expectations
- Code that runs on the stated Python version
- Type hints used to the fullest extent supported
- Clear notes when a better approach exists on newer Python
- Tests or testing guidance
- Minimal, justified dependencies

## Final Checklist
- [ ] Target Python version is confirmed
- [ ] Code is compatible with that version
- [ ] Type hints are used appropriately
- [ ] Tooling recommendations match the environment
- [ ] Error handling is explicit
- [ ] Tests are considered or included
- [ ] Performance decisions are justified
- [ ] Limitations due to old Python version are noted when relevant
