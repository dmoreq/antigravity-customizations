---
name: python-performance
description: "Profile and optimize Python code using cProfile, memory profilers, and performance best practices. Use when debugging slow Python code, optimizing bottlenecks, or improving application performance."
risk: safe
source: local
date_added: "2026-02-27"
---

# Python Performance Optimization Skill

Practical guidance for finding and fixing real performance problems in Python code.

## When to Use
- Investigating slow Python code or high latency
- Reducing CPU usage or memory consumption
- Optimizing data processing, I/O, or database access
- Improving throughput of services or pipelines
- Profiling before and after changes

## When Not to Use
- No evidence of a performance problem
- Premature optimization of code that is not on the critical path
- Non-Python performance issues

## Related Skills
- Use **tech-research** when a better algorithm/library may be required.
- Use **data-science** when the issue involves analytical metrics or model behavior.
- Use **python-concurrency** when the bottleneck is I/O-bound or CPU-parallel.
- Use **algorithm-optimization** when optimizing quality KPIs on real cases rather than pure runtime.

## Core Principles
1. **Measure first** — never optimize based on guesses.
2. Optimize the actual bottleneck, not the whole codebase.
3. Prefer simple, readable improvements before complex rewrites.
4. Re-measure after every meaningful change.
5. Stop when the performance target is met.

## Optimization Process

### 1. Clarify Goals
- What is slow or expensive? (latency, CPU, memory, throughput)
- What is the target? (p95 latency, memory limit, requests/sec…)
- What are the constraints? (Python version, dependencies, cannot change architecture…)

### 2. Profile
Choose the right level:

- **CPU / runtime**: `cProfile`, `py-spy`, `scalene`
- **Memory**: `tracemalloc`, `memory_profiler`, `scalene`
- **Line-level hotspots**: `line_profiler` or sampling profilers
- **I/O & external calls**: logging + timing, or async-aware profilers

Focus on the top hotspots. Ignore micro-gains outside the critical path.

### 3. Analyze the Bottleneck
Classify the problem:

| Type | Typical Signs | Common Directions |
| :--- | :--- | :--- |
| **CPU-bound** | High CPU, pure computation | Algorithm, vectorization, concurrency |
| **I/O-bound** | Waiting on network/disk/DB | Async, batching, caching, pooling |
| **Memory-bound** | High RSS, swapping, GC pressure | Generators, in-place ops, smaller structures |
| **Database** | Slow queries, N+1, locks | Indexes, query shape, batching |
| **Algorithmic** | Scales poorly with input size | Better complexity, early exit |

### 4. Apply Targeted Improvements
Prefer in this order:

1. Better algorithm or data structure
2. Reduce work (caching, batching, avoiding repeated computation)
3. More efficient libraries (NumPy, Polars, appropriate async drivers…)
4. Concurrency / parallelism only when appropriate
5. Low-level tricks last (and only if justified)

Examples of high-leverage moves:
- Replace slow Python loops with vectorized or bulk operations
- Fix N+1 queries and missing indexes
- Use generators / streaming for large data
- Cache pure, expensive results
- Move blocking I/O out of async event loops
- Avoid unnecessary object creation in hot paths

### 5. Validate
- Re-run the same benchmark or profile
- Compare against the original baseline
- Check correctness is preserved
- Confirm the gain is worth the complexity

## Output Expectations
- Clear statement of the bottleneck found
- Evidence from profiling (not guesses)
- Specific, prioritized changes
- Before/after impact when possible
- Notes on trade-offs and risks

## Final Checklist
- [ ] Performance goal and constraints are clear
- [ ] Profiling was done before optimizing
- [ ] Bottleneck type is identified
- [ ] Changes target the actual hotspot
- [ ] Simpler fixes were considered first
- [ ] Results were re-measured
- [ ] Correctness is preserved
- [ ] Complexity added is justified by the gain
