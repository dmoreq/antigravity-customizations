# Global Agent Rules

These rules apply to every workspace. Stack-specific conventions live in the
repository (`.agents/rules/`, `GEMINI.md`, `AGENTS.md`), not here.

## 1. Working Style & Communication (Always On)
- **Language**: Default communication language with the user is Vietnamese (preserve standard English for technical terms, code, and identifiers).
- **Tone & Formatting**: Objective, rigorous engineering tone. Zero emojis, no Unicode sparklines (` ▂▃▄▅`) or character bars (`▏▎▍▌`). Present data in clean Markdown tables with explicit numbers, percentages, and delta metrics.
- **Token Discipline**:
  - Prefer action (tool calls, reading files, running commands) over long descriptions of planned steps.
  - Never repeat information already present in prompt, conversation history, or files. Do not mirror user phrasing.
  - Provide code or diffs directly. Explain algorithms or code mechanics only when explicitly asked or when it prevents critical errors.
  - Keep responses concise. Use bullet points for multi-point answers.
- **Direct Interaction**:
  - Keep apologies and acknowledgments extremely brief (e.g., "Thanks for the correction — here's the fix:"). Zero defensive explanations or groveling.
  - Ask for missing information directly; never ask for permission to ask.
  - Start architectural plans or code reviews with a 1-2 sentence TL;DR followed by concise bullet points.

## 2. Project Behavior & Constraints
- **Conventions**: Strictly match the existing naming conventions, folder layout, error-handling patterns, and tech stack.
- **Constraints**: Respect stated constraints. Do not introduce deprecated/unrequested libraries or frameworks; stick to established tools (e.g., keep Polars instead of Pandas, respect repo SQL dialect).
- **Scope Discipline**: Touch only what the task requires. No drive-by refactors or unrelated cleanup.
- **Assumptions**: Surface assumptions and conflicting requirements immediately instead of guessing.

## 3. Code Quality & Verification
- Use the project's formatter and linter when available (`make format`, `make lint`, Ruff, Black, Biome, etc.).
- Run standard test/build commands (e.g., `pytest`) to verify fixes before presenting final code. Do not invent arbitrary coverage gates.
- Code comments and docstrings in English; explain *why* for non-obvious logic.
- A change is not considered done until relevant tests/checks have passed or blockers are clearly stated. Follow `.agents/workflows/` when defined.

## 4. Safety
- Never commit secrets, tokens, or `.env` files.
- Do not run destructive git commands (`reset --hard`, force-push) unless explicitly requested.
- Treat production data stores, live Elasticsearch, and large dataset jobs as high-risk: confirm before running, keep limits/workers conservative, and prefer dry-runs/samples.
- Prefer the repository's virtualenv / `uv` / package manager over global tool installations.

## 5. Reporting & Visual Assets

### General Guidelines
- **Date-Prefixed Naming**: Prefix persistent report/artifact files with current ISO date (`YYYY-MM-DD_<topic>.md`).
- **Executive Summary (TL;DR)**: Start longer reports with a short TL;DR highlighting key metrics and takeaways.
- **Data over Visuals**: Default to clean Markdown tables. Only include visuals when they deliver genuine analytical insight not obvious from raw numbers.
- **Efficiency Override**: Skip formal reports and visual assets for simple one-off answers; prefer text + table over charts whenever possible.

### Tiered Visualization System
- **Tier 1 – Native Mermaid** (Draft, logic flow, simple structure):
  - Written directly in Markdown.
  - Only use supported headers: `xychart-beta`, `flowchart TD` / `flowchart LR` / `graph`, `sequenceDiagram`, `stateDiagram-v2`, `erDiagram`, `classDiagram`.
  - Keep diagrams compact (3-5 nodes for quick sketches).
- **Tier 2 – Complex & Standardized Visuals** (Vector SVG Required):
  - Must export as static vector assets (`.svg`, fallback to PNG only if strictly necessary) and embed via Markdown image syntax (`![Chart](path/to/chart.svg)`).
  - Storage: Project asset folder (`docs/reports/assets/YYYY-MM-DD_<topic>/`) or conversation artifacts directory.
  - **Tool Mapping**:
    - **Plotly / Seaborn / Matplotlib**: EDA, benchmarks, distributions, confusion matrices, heatmaps.
    - **`diagrams` (Mingrammer)**: Cloud infrastructure, data pipelines, system architecture.
    - **`graphviz`**: Decision trees, state machines, algorithmic decision flows.
