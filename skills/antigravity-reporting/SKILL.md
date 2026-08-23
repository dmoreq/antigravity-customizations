---
name: antigravity-reporting
description: "Guidance for creating clean, professional technical reports, benchmarks, and data visualizations optimized for Antigravity, GitHub, and external readers."
risk: safe
source: local
date_added: "2026-08-22"
---

# Antigravity Reporting & Visualization Skill

Guidance for creating clean, professional technical reports, benchmark evaluations, and data analyses within Antigravity.

## When to Use
Use this skill for formal reports, benchmark summaries, architecture analyses, or data storytelling.  
Skip formal reports and visuals for simple answers — prefer concise text + tables.

## Related Skills
- Use as the presentation standard for **tech-research**, **data-science**, and **algorithm-optimization** when a formal report is required.
- Use **data-visualization** for Plotly/SVG charts embedded in reports; enforce Text Density Rules and visual QA before embedding.
- Do not force full report format for short intermediate answers.

---

## 1. Execution Flow
1. **Generate Assets First**: Run data computations and export visual assets (`.svg`) before drafting the report.
2. **Draft Report**: Write the Markdown document using verified quantitative metrics.
3. **Embed Assets**: Reference visual assets using proper relative paths from the report file.

---

## 2. File Organization & Naming
- **Date Prefix**: Prefix persistent report/artifact files with ISO date: `YYYY-MM-DD_<topic>.md`.
- **Session Artifact**: Default location is the conversation artifact directory (`<appDataDir>/brain/<conversation-id>/`).
- **Workspace Reports**: Match the project's existing docs structure (fallback to `docs/reports/YYYY-MM-DD_<topic>.md`).
- **Asset Storage**: Store assets in `docs/reports/assets/YYYY-MM-DD_<topic>/` or alongside the artifact. Always use relative paths when embedding.

---

## 3. Visualization Rules

### Tier 1 – Native Mermaid (Simple flows, lightweight sketches)
- **Supported Headers**: ONLY use `xychart-beta`, `flowchart TD` / `flowchart LR` / `graph`, `sequenceDiagram`, `stateDiagram-v2`, `erDiagram`, `classDiagram`.
- Keep diagrams compact (3-5 nodes for quick sketches). Avoid HTML tags inside nodes.

### Tier 2 – Vector Assets (Complex data, architecture, EDA)
- **Format**: Bắt buộc ưu tiên Vector `.svg` (fallback sang `.png` chỉ khi không thể tạo SVG).
- **Tool Mapping**:
  - **Plotly / Seaborn / Matplotlib**: Exploratory data analysis (EDA), statistical distributions, benchmarks, heatmaps.
  - **`diagrams` (Mingrammer)**: Cloud infrastructure, data pipelines, system architecture.
  - **`graphviz`**: Decision trees, state machines, algorithmic flows.
- Do not embed raw HTML or iframes in static Markdown.

### Text Density & Visual Hygiene
- **One visual = one main idea**: Do not overload a single visual with competing narratives.
- **Titles**: Short, specific, max ~1 line. Avoid subtitles inside the visual; place explanation in surrounding prose.
- **Labels & Legends**: Concise words or abbreviations. Rename verbose raw fields before rendering.
- **Annotations**: Highlight only 1–3 key insights/milestones; never embed paragraphs in the canvas.
- **Collision Handling**: If text collides, shorten labels first before enlarging canvas width/height.
- **Zero Duplication**: Never repeat identical text across title, subtitle, legend, and annotations.

---

## 4. Content Standards
- **TL;DR First**: Always start with a short `TL;DR` or `Executive Summary` highlighting core metrics and takeaways.
- **Objective Tone**: Professional engineering prose. Zero fluff, zero emojis, no Unicode sparklines (` ▂▃▄▅`) or character bars (`▏▎▍▌`).
- **Structured Tables**: Default to clean Markdown tables with explicit numbers, percentages (2 decimals), and delta comparisons vs baseline.
- **Data over Visuals**: Only create charts when they reveal patterns not obvious from a compact table.

---

## Final Checklist
- [ ] Filename has ISO date prefix (`YYYY-MM-DD_<topic>.md` for persistent files)
- [ ] TL;DR present with key metrics and conclusions upfront
- [ ] Professional engineering tone (no emojis, no Unicode sparklines/bars)
- [ ] Tables preferred; charts added only when delivering non-obvious insights
- [ ] Correct visualization tier selected (Mermaid supported headers or Vector .svg)
- [ ] Text density rules applied (1 idea/visual, short labels, $\le 1$ line title, no text collisions)
- [ ] Relative paths used for embedded assets
- [ ] All claims backed by quantitative numbers/deltas
- [ ] No unnecessary reports or superfluous visuals created
