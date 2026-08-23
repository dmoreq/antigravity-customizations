---
name: data-visualization
description: "Create clear, accurate, readable charts with Plotly. Prefer lean visuals, correct layout, and no overlapping text."
risk: safe
source: local
date_added: "2026-08-23"
---

# Data Visualization Skill (Plotly-first)

Create clear, accurate, readable charts with Plotly. Prefer lean visuals, correct layout, and no overlapping text.

## When to Use
- Building analytical charts for reports or exploration
- Choosing the right chart for a dataset and question
- Exporting SVG/PNG figures for documents
- Fixing unreadable charts (overlap, clipping, bad sizing)
- Creating diagrams/visuals where text density and layout matter

## When Not to Use
- Simple comparisons already clear in a small table
- Non-visual debugging or pure statistical computation
- Decorative charts that add no analytical value

## Core Principles
1. Choose chart by purpose, not by habit.
2. Prefer fewer labels over complete labels.
3. Optimize layout for readability before styling.
4. Never deliver a chart with overlapping or clipped text.
5. If exact values matter more than shape, use a table.
6. Keep in-chart text short; put long explanation outside the visual.

## Text Density Rules
- Titles: short and specific (about one line).
- Avoid long subtitles inside the chart.
- Legend/series labels: concise.
- Axis labels: short, with units when needed.
- Annotations: only key insights (1–3 max).
- If text collides, reduce text density before increasing size.
- Detailed interpretation belongs in report/story prose, not inside the figure.

## Chart Selection
| Purpose | Prefer | Avoid |
| :--- | :--- | :--- |
| **Compare categories** | Bar / horizontal bar | Pie with many slices |
| **Trend over time** | Line | Overplotted lines without focus |
| **Distribution** | Histogram / box / violin | 3D charts |
| **Relationship** | Scatter | Dual-axis unless justified |
| **Composition** | Stacked bar (few parts) | Pie > 6 slices |

If categories are many or names are long → prefer horizontal bar.

## Plotly Defaults
- Prefer Plotly Express for simple charts; Graph Objects when fine control is needed.
- Set explicit `width` and `height` for content density.
- Enable axis automargin (`xaxis_automargin=True`, `yaxis_automargin=True`).
- Keep legend off the data area when possible.
- Use consistent units and clear axis titles.

## Anti-Overlap Rules
- Do not label every point by default.
- Label only key points: top-N, outliers, or highlighted series.
- For dense labels, alternate `textposition`, thin ticks, or rely on hover.
- Rotate or shorten ticks when categories collide.
- If still colliding:
  1. Reduce label count
  2. Modestly increase figure size
  3. Keep only 1–3 annotations
- Never "solve" overlap by making font unreadable.

## Layout & Export
- Leave margin for title, ticks, legend, annotations.
- Prefer one message per chart.
- Export with explicit size, e.g. `fig.write_image("chart.svg", width=900, height=560)`.
- Prefer SVG for report-quality vector output.
- Visually inspect the exported file before delivery.

## Visual QA Checklist
- [ ] Chart type matches purpose
- [ ] Table considered when exact values matter more
- [ ] In-chart text is short and necessary
- [ ] No overlapping labels/ticks/legend
- [ ] No clipped text or overflow
- [ ] Width/height fit content
- [ ] Readable at final display size
- [ ] Long explanation moved outside the figure

## Related Skills
- Use **data-science** for analysis that produces the metrics/data to visualize.
- Use **antigravity-reporting** when embedding figures into formal reports.
- Use **data-storytelling** when the chart supports a decision narrative.
- Use **tech-research** only when an unfamiliar visualization method is needed.
- For Mermaid/simple structure diagrams in reports, follow the same Text Density Rules and **antigravity-reporting** Tier-1 guidance.

## Output Expectations
- Purpose-appropriate Plotly chart
- Lean text inside the figure
- No overlap/clipping after export QA
- Clear separation between visual signal and written interpretation
