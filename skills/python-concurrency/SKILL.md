---
name: python-concurrency
description: "Comprehensive guidance for choosing and implementing the right concurrency and parallelism model in Python: asyncio for I/O, ThreadPoolExecutor for blocking I/O, and multiprocessing/ProcessPoolExecutor for CPU-bound tasks."
risk: safe
source: local
date_added: "2026-02-27"
---

# Python Concurrency & Parallelism Skill

Expert guidance for selecting and implementing the right concurrency or parallelism model in Python (asyncio, threads, and processes).

> **Core Perspective**: This skill is not just about `asyncio` — it is about selecting the **right concurrency/parallelism model** for the workload:
> - `asyncio` is the default choice for **I/O-bound** concurrency.
> - Parallel CPU computing is a separate domain (`multiprocessing` / `ProcessPoolExecutor`), used only when computationally necessary.
> - `ThreadPoolExecutor` bridges legacy or simple blocking I/O without requiring full async rewrites.

---

## When to Use
- Designing or implementing async services and APIs (FastAPI, aiohttp, Starlette)
- Handling high-concurrency I/O operations (HTTP, databases, files, network sockets)
- Executing CPU-intensive tasks in parallel (data transformation, image/video processing, large parsing)
- Offloading blocking I/O or CPU work from an async event loop
- Deciding between `asyncio`, `ThreadPoolExecutor`, and `ProcessPoolExecutor`

## When Not to Use
- Simple, sequential scripts with no performance or concurrency bottlenecks
- Environments where standard single-threaded execution is completely sufficient
- Non-Python technology stacks

## Related Skills
- Use **python-patterns** when the broader architecture choice is still open.
- Use **python-performance** to measure whether concurrency/parallelism actually helps.
- Use **python-testing** for async/concurrent test coverage.
- Use **code-review** before merge.

---

## 1. Decision Guide (Workload vs Concurrency Model)

| Workload Scenario | Recommended Model | Avoid | Rationale |
| :--- | :--- | :--- | :--- |
| **High I/O Waiting** (HTTP, DB, APIs, WebSockets) | **`asyncio`** | `multiprocessing` | Massive concurrency with minimal memory overhead; no OS process creation costs. |
| **CPU-Bound** (heavy computation, ML inference, large parsing, image/video processing) | **`ProcessPoolExecutor`** / `multiprocessing` | Pure `asyncio` | Bypasses the Global Interpreter Lock (GIL) across multiple CPU cores. |
| **Simple Blocking I/O / Legacy Sync Code** | **`ThreadPoolExecutor`** | Full async rewrites | Easy concurrency for blocking C-extensions or legacy SDKs without rewriting codebase. |
| **Mixed Workloads** (I/O streaming + heavy CPU transforms) | **`asyncio` + offload to `ProcessPoolExecutor`** | Running heavy CPU directly on event loop | Keeps the event loop responsive while delegating heavy compute to worker processes. |

---

## 2. Core Principles
1. **Match Model to Workload**: Use `asyncio` for I/O-bound concurrency; use processes for CPU-bound parallelism.
2. **Structured Concurrency**: Prefer `TaskGroup` (Python 3.11+) or well-bounded task lifecycles over loose fire-and-forget coroutines.
3. **Never Block the Event Loop**: Offload blocking I/O (`loop.run_in_executor(ThreadPoolExecutor)`) and heavy CPU work (`ProcessPoolExecutor`).
4. **Safety by Default**: Always configure timeouts, cancellation handlers, and clean resource disposal.
5. **Simplicity over Fashion**: Do not force async onto simple synchronous scripts or CPU-bound jobs.

---

## 3. Parallel CPU Computing (Multiprocessing)
Use `concurrent.futures.ProcessPoolExecutor` or `multiprocessing` for CPU-bound computation.

**Crucial Considerations**:
- **Process Overhead**: Spawning processes has higher memory and startup overhead than threads or coroutines.
- **Pickling Requirement**: Data passed into and returned from processes must be serializable via `pickle`.
- **No Shared Memory by Default**: Separate memory spaces prevent race conditions but require data transfer overhead (use shared memory/buffers for very large arrays when necessary).
- **Batching Work**: Best suited for batched, coarse-grained CPU jobs — avoid dispatching thousands of tiny tasks.
- **Hybrid Async Integration**:
  ```python
  loop = asyncio.get_running_loop()
  result = await loop.run_in_executor(process_pool, cpu_heavy_function, data)
  ```

---

## 4. Key Async Patterns
- **TaskGroups / Gather**: Concurrent execution with structured failure handling.
- **Semaphores (`asyncio.Semaphore`)**: Bound parallelism and prevent overwhelming downstream databases/APIs (backpressure).
- **Queues (`asyncio.Queue`)**: Decouple producers and consumers safely.
- **Timeouts**: `asyncio.timeout` (Python 3.11+) or `asyncio.wait_for` on all external network calls.
- **Cancellation Cleanup**: Use `try...finally` to ensure database sessions and network connections close properly upon cancellation.

---

## 5. Anti-Patterns to Avoid
- **Using `asyncio` for CPU-bound work**: Coroutines share a single thread; heavy math completely freezes the event loop.
- **Spawning excessive processes for simple I/O**: Wastes massive system memory and CPU cycles on IPC and process management.
- **Calling long-running blocking functions inside event loop**: Halts all concurrent request handling.
- **Assuming "Async = Faster in all cases"**: Async improves concurrency (handling many simultaneous I/O waits), not raw computational speed.
- **Swallowing task exceptions**: Failing to handle task failures cleanly in gather/queues.

---

## 6. Testing & Debugging
- Test async workflows with `pytest-asyncio`.
- Always test cancellation, timeouts, and exception paths alongside happy paths.
- Avoid fragile `asyncio.sleep()` assertions; test with deterministic events (`asyncio.Event`).
- Enable debug mode (`PYTHONASYNCIODEBUG=1`) to detect unawaited coroutines and blocking calls.

---

## Output Expectations
- Clear statement explaining **why** `asyncio`, `threads`, or `processes` was chosen for the specific case.
- Concrete pattern selection (TaskGroup, Queue, Semaphore, Executor offloading).
- Explicit handling of timeouts, cancellation, and exceptions.
- Notes on performance trade-offs, resource costs, and potential risks.

---

## Final Checklist
- [ ] Workload is clearly classified as I/O-bound vs CPU-bound
- [ ] Concurrency model is explicitly justified (`asyncio` / threads / processes)
- [ ] CPU-heavy work is not run directly on the event loop
- [ ] Parallelism overhead (IPC, process spawn, pickling) is measured and justified
- [ ] Timeouts are configured for all external network/DB calls
- [ ] Cancellation and resource cleanup paths are handled safely
- [ ] No blocking calls exist inside the active event loop
- [ ] Tests cover success, timeout, failure, and cancellation paths
