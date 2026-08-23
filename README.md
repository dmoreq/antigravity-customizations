# Antigravity Customizations

A curated, token-efficient collection of **Global Agent Rules** and **Custom Skills** designed for the **Google Antigravity** coding assistant environment.

---

## Repository Structure

```
antigravity-customizations/
├── rules/
│   └── GEMINI.md                    # Global agent behavioral directives & standards
├── skills/
│   ├── algorithm-optimization/      # Systematic KPI & algorithm improvement loop
│   ├── antigravity-reporting/       # Technical reporting, benchmarks & 2-tier visualization
│   ├── code-review/                 # Multi-axis code review checklist before merging
│   ├── code-simplification/         # Safe refactoring, reducing nesting & accidental complexity
│   ├── context7-mcp/                # Live documentation lookup for libraries/frameworks
│   ├── data-science/                # EDA, modeling, statistics, causal inference & A/B testing
│   ├── data-storytelling/           # Decision-ready narratives for business stakeholders
│   ├── data-visualization/          # Plotly-first charts, layout optimization & anti-overlap QA
│   ├── deprecation-migration/       # Safe removal, replacement & sunsetting of legacy APIs/systems
│   ├── python-concurrency/          # Concurrency models: asyncio, thread pool, process pool
│   ├── python-patterns/             # Pragmatic architecture, framework choice & typing principles
│   ├── python-performance/          # Profile-driven performance optimization
│   ├── python-pro/                  # Modern Python 3.12+ engineering & legacy version handling
│   ├── python-testing/              # Testing strategies with pytest, fixtures & TDD
│   └── tech-research/               # SOTA survey, benchmark comparison & technical trade-offs
├── setup.sh                         # Automatic installer script for ~/.gemini
└── README.md
```

---

## Skills Catalog

| Skill Name | Purpose |
| :--- | :--- |
| **`algorithm-optimization`** | Systematic workflow to optimize algorithms/processes against target metrics while guarding healthy cases. |
| **`antigravity-reporting`** | Clean technical reports, benchmarks, and Tier 1 (Mermaid) / Tier 2 (Vector SVG) visualizations. |
| **`tech-research`** | SOTA methods, benchmark evaluation, and conditional recommendations before implementation. |
| **`data-science`** | Statistical modeling, machine learning, A/B testing, exploratory analysis, and causal inference. |
| **`data-storytelling`** | Turning quantitative analytics into decision-focused stories for stakeholders. |
| **`data-visualization`** | Plotly-first clean visual creation, SVG export, text density hygiene, and anti-overlap QA. |
| **`deprecation-migration`** | Safely sunset, replace, and migrate legacy APIs/systems using Strangler, Adapter, and Feature Flags. |
| **`python-pro`** | Idiomatic Python 3.12+ development, strong typing, `uv`, `ruff`, and backward compatibility. |
| **`python-patterns`** | Architectural decision-making: async vs sync, framework choice, and project structure. |
| **`python-concurrency`** | Concurrency models: `asyncio` for I/O, `ThreadPool` for blocking I/O, `ProcessPool` for CPU. |
| **`python-performance`** | Measure-first, profile-driven optimization with `cProfile`, `py-spy`, and memory profilers. |
| **`python-testing`** | Pytest strategies, focused fixtures, mocking, and robust test suites. |
| **`code-review`** | Systematic code review across correctness, security, performance, and style. |
| **`code-simplification`** | Safe refactoring to improve readability and reduce nesting without changing behavior. |
| **`context7-mcp`** | Fetching up-to-date documentation and code references via Context7 MCP. |

---

## Installation & Setup

### Option 1: Automatic Setup Script (Recommended)

Run `setup.sh` to install or symlink into your local `~/.gemini/` configuration:

```bash
chmod +x setup.sh
./setup.sh
```

### Option 2: Manual Installation

1. **Global Rules**:
   ```bash
   cp rules/GEMINI.md ~/.gemini/GEMINI.md
   ```

2. **Global Skills**:
   ```bash
   mkdir -p ~/.gemini/config/skills
   cp -R skills/* ~/.gemini/config/skills/
   ```

---

## Customization Precedence in Antigravity

Antigravity discovers customizations hierarchically:
1. **Workspace Project**: `.agents/` or `.agents/skills/` located in the root repository.
2. **Global Config**: `~/.gemini/config/skills/` and `~/.gemini/GEMINI.md`.
3. **Built-in System**: Default skills bundled with the Antigravity application.
