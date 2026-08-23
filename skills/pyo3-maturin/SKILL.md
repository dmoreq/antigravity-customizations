---
name: pyo3-maturin
description: "Build and maintain high-performance Python native extensions with Rust using PyO3 and Maturin. Use for CPU-bound optimization and native packaging."
risk: safe
source: local
date_added: "2026-08-23"
---

# PyO3 + Maturin Skill

Build and maintain high-performance Python native extensions with Rust using PyO3 and Maturin.

## When to Use
- Creating or modifying a Python module backed by Rust
- Speeding up a confirmed CPU-bound Python hotspot
- Packaging Rust code as a Python native extension
- Debugging Maturin/PyO3 develop, build, or import issues

## When Not to Use
- Bottleneck is I/O-bound (network, disk, database)
- No profiling evidence that native code is required
- Existing fast libraries (NumPy, Polars, SciPy) already solve the problem
- Pure Python feature work with no native requirements

## Decision Gate
Use Rust only when all conditions are true:
1. **Measured Hotspot**: Hotspot is profiled and confirmed CPU-bound.
2. **High Leverage**: Pure compute or requires low-level control (memory, SIMD, threads).
3. **Justified Cost**: Expected speedup justifies added build/maintenance complexity.
4. **Small Boundary**: Python API boundary remains small, clean, and stable.

*Prefer extracting a hot function over rewriting an entire module in Rust.*

## Recommended Stack
- **PyO3**: Rust ↔ Python bindings and type conversions
- **Maturin**: Fast build tool and packaging engine (`maturin develop`, `maturin build`)
- **`pyproject.toml` + `Cargo.toml`**: Dual configuration as single source of truth
- **`uv`**: Virtual environment and dependency management

## Project Layout (Mixed Layout)
Prefer mixed layout with Python wrapper and native module:

```text
my-project/
  pyproject.toml        # [build-system] requires = ["maturin>=1.0"]
  Cargo.toml            # crate-type = ["cdylib"]
  python/
    my_project/
      __init__.py       # Exposes public API, imports _native
  src/
    lib.rs              # #[pymodule] bindings
```

### Layout Rules:
- Set `python-source = "python"` in `pyproject.toml` under `[tool.maturin]`.
- Expose native Rust code as a submodule, e.g., `my_project._native`.
- Specify `crate-type = ["cdylib"]` in `Cargo.toml`.
- Add local compiled build artifacts (`*.so`, `*.pyd`, `target/`) to `.gitignore`.

## Implementation & GIL Rules

### GIL Management for CPU-bound Work:
1. **Extract Data**: Extract/copy needed arguments while attached to Python (holding GIL).
2. **Release GIL**: Call `py.allow_threads(...)` to detach from the Python interpreter.
3. **Execute Compute**: Run pure Rust computation (using Rayon or worker threads freely).
4. **Re-acquire & Return**: Return results converted cleanly into `PyResult<T>`.

### Golden Rules:
- **Never hold the GIL** during long, CPU-intensive Rust loops.
- **Detach GIL before multi-threading**: When using Rayon or OS threads, release the GIL first to avoid interpreter deadlocks.
- **Minimize Boundary Crossings**: Process data in bulk; avoid crossing the Python ↔ Rust boundary inside tight loops.
- **Map Errors Cleanly**: Return `PyResult<T>` and map Rust error types to meaningful Python exceptions (`PyValueError`, `PyRuntimeError`).

## Maturin Workflow
1. **Profile First**: Confirm the bottleneck via `python-performance`.
2. **Isolate Boundary**: Define the minimal interface (types, inputs, outputs).
3. **Develop & Iterate**: Run `maturin develop` inside the active virtualenv.
4. **Verify Parity**: Run `pytest` to confirm parity with previous Python behavior.
5. **Benchmark Release**: Benchmark strictly using `maturin develop --release`.
6. **Integrate**: Commit only after verifying measurable gains.

## Troubleshooting Quick Guide
- **ImportError: symbol not found**: Ensure module name in `#[pymodule]` matches the `.so` / `.pyd` filename exactly.
- **Unexpected Slowdown**: Verify you built with `--release` (debug builds of Rust are significantly slower).
- **Deadlock with Rayon**: Ensure `py.allow_threads` was called before invoking Rayon parallel iterators.
- **Wheel Compatibility**: Use `--zig` for cross-compilation or target `abi3` for broad Python version support.

## Related Skills
- Use **python-performance** first to measure and confirm CPU-bound bottlenecks.
- Use **tech-research** if comparing Rust against Cython, C extensions, or Julia.
- Use **python-testing** for parity verification, edge cases, and regression test suites.
- Use **doubt-driven-development** for high-stakes decisions before introducing Rust into a pure Python repository.
- Use **code-review** before merging native extension changes.
- Use **python-pro** for packaging standards, typing wrappers, and `pyproject.toml` configurations.

## Final Checklist
- [ ] Hotspot is profiled and confirmed CPU-bound
- [ ] Python ↔ Rust boundary is minimal and stable
- [ ] Project follows Maturin mixed layout (`python/` + `src/`)
- [ ] GIL is released (`py.allow_threads`) during heavy compute
- [ ] Multi-threaded Rust code detaches from GIL to avoid deadlocks
- [ ] Fallible functions return `PyResult<T>` with standard Python exceptions
- [ ] `maturin develop` and `pytest` pass cleanly
- [ ] Performance gain validated on a `--release` build
- [ ] Build artifacts (`target/`, `*.so`, `*.pyd`) are in `.gitignore`
