---
name: python-patterns
description: "Decision-making principles for Python architecture, framework choice, async design, and project structure. Focus on thinking, not copying patterns."
risk: safe
source: local
date_added: "2026-02-27"
---

# Python Patterns Skill

Decision-making principles for Python architecture, framework choice, async design, and project structure. Focus on thinking, not copying patterns.

## When to Use
- Choosing a Python framework or architecture
- Deciding between async and sync
- Structuring a Python project
- Designing APIs, services, or background workers
- Making trade-off decisions in Python systems

## When Not to Use
- Basic syntax questions
- Non-Python stacks
- Simple one-off scripts with no architectural decisions

## Related Skills
- Use **python-pro** once architecture and design decisions are made and implementation is needed.
- Use **python-concurrency** when choosing among asyncio, threads, and processes.

## 1. Framework Selection
Choose based on context, not habit.

- **API / microservices / AI serving** → FastAPI
- **Full-stack / CMS / admin-heavy** → Django
- **Simple service or learning** → Flask
- **Background workers** → Celery, ARQ, or similar (with any web framework)

Ask before deciding:
- API-only or full-stack?
- Need built-in admin?
- Team comfortable with async?
- Existing infrastructure constraints?

## 2. Async vs Sync
**Use async when:**
- I/O-bound work (DB, HTTP, files)
- High concurrency
- Real-time features
- Async-native stack (FastAPI, async ORM, etc.)

**Use sync when:**
- CPU-bound work
- Simple scripts
- Legacy or blocking libraries
- Team is not ready for async complexity

Golden rule:
- I/O-bound → async
- CPU-bound → sync + multiprocessing / concurrent.futures

Avoid mixing sync and async carelessly. Do not force async onto CPU-heavy work.

## 3. Typing Strategy
Always type:
- Function parameters and return values
- Public APIs
- Class attributes that matter

Can be lighter on:
- Obvious local variables
- One-off scripts
- Some tests

Prefer modern syntax (`list[str]`, `str | None`) when the Python version allows.  
Use Pydantic for request/response models, settings, and validation.

## 4. Project Structure
Match structure to size and complexity:

- **Small**: flat files
- **Medium API**: `app/` with routes, services, models, schemas
- **Large**: `src/myapp/` with clear layers or feature modules

Prefer clear separation:
- Routes / views → thin
- Services → business logic
- Models / schemas → data shape
- Repositories or data access → isolated when needed

## 5. Error Handling
- Raise domain-specific exceptions in services
- Convert them to clean API responses at the boundary
- Return consistent error shape (code, message, details)
- Never expose stack traces to clients

## 6. Testing Principles
- Unit test business logic
- Integration test API endpoints
- Use `pytest` (+ `pytest-asyncio` when needed)
- Prefer focused fixtures over heavy setup
- Test critical paths first

## 7. Background Tasks
- Simple fire-and-forget → framework background tasks
- Long-running / retry / distributed → Celery, ARQ, or equivalent

Choose based on persistence, retry needs, and scale.

## Design Principles
Apply these pragmatically, not dogmatically:

- Prefer clear naming over clever naming
- Keep functions and modules focused (single responsibility)
- Avoid duplication when abstraction is cheaper than repetition (DRY)
- Prefer simple, readable design over rigid pattern usage
- Use OOP when it clarifies the domain; prefer composition over deep inheritance
- Write tests for critical behavior; use TDD when it improves design, not as a ritual

## Core Decision Checklist
- [ ] Framework chosen based on actual context (not default habit)
- [ ] Async vs sync decision is justified
- [ ] Typing strategy is clear for public interfaces
- [ ] Project structure matches current scale
- [ ] Error handling is consistent and safe
- [ ] Testing approach covers critical paths
- [ ] Background work is handled with the right tool
- [ ] Trade-offs are understood before implementing

## Anti-Patterns
- Defaulting to one framework for every project
- Using sync libraries inside async code without care
- Putting business logic in routes/views
- Skipping types on public APIs
- Ignoring N+1 or obvious performance issues
- Over-engineering small projects

## Principle
Python architecture decisions should serve the specific problem, team, and constraints. Prefer clarity and fit over fashion.
