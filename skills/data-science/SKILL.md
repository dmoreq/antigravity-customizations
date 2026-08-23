---
name: data-science
description: "Expert data science guidance for advanced analytics, machine learning, and statistical modeling. Handles complex data analysis, predictive modeling, and business intelligence."
risk: safe
source: local
date_added: "2026-02-27"
---

# Data Science Skill

Use this skill for data science tasks: exploratory analysis, statistical modeling, machine learning, experimentation, forecasting, and turning data into business insights.

## When to Use
- EDA, statistical analysis, hypothesis testing, A/B testing
- Building or evaluating predictive / ML models
- Time series forecasting, causal inference, segmentation
- Designing experiments or measuring impact
- Turning analysis into clear recommendations

## When Not to Use
- Pure software engineering or backend development
- Simple data cleaning without analytical intent
- Tasks outside data science / analytics scope

## Related Skills
- Use **algorithm-optimization** when findings should drive iterative KPI improvement on real cases.
- Use **data-visualization** to create clean, publication-ready Plotly charts without text overlap.
- Use **data-storytelling** when results must be communicated to non-technical stakeholders.
- Use **context7-mcp** for library/API documentation when needed.
- Follow **antigravity-reporting** when producing a formal analytical report.

## Core Approach
1. **Clarify Objectives**: Clarify the business goal, success metrics, constraints, and available data.
2. **Explore Data**: Explore the data thoroughly (distributions, missingness, outliers, relationships).
3. **Select Methodology**: Choose methods appropriate to the data and question (statistical vs ML, causal vs predictive).
4. **Rigorous Validation**: Validate rigorously (cross-validation, statistical tests, residual checks, robustness).
5. **Communicate Insights**: Communicate findings with clear metrics, visualizations, and actionable recommendations.
6. **Document**: Document assumptions, limitations, and next steps.

## Key Principles
- Prefer simpler, interpretable methods when they perform adequately.
- Always report effect sizes, confidence intervals, and practical significance — not just p-values.
- Check assumptions and test model robustness.
- Separate exploratory findings from confirmatory results.
- Keep plots clean and focused: short labels, no overlapping text, 1 primary insight per visual.
- Focus on actionable insights over technical complexity.
- Flag data quality issues and potential biases early.

## Output Expectations
- Start with a short summary of the key finding or recommendation.
- Show relevant metrics, tables, or plots.
- State assumptions and limitations clearly.
- Provide concrete next steps or verification methods when useful.

## Final Checklist
- [ ] Business objective and success metrics are clearly defined
- [ ] Data explored thoroughly (missing values, outliers, distributions, correlations)
- [ ] Methodology is well-suited to the research question and data characteristics
- [ ] Results rigorously validated (cross-validation, residual checks, robustness tests)
- [ ] Effect sizes and confidence intervals reported, not just p-values
- [ ] Assumptions and limitations explicitly stated
- [ ] Recommendations are feasible and actionable
- [ ] Concrete next steps and verification methods provided
