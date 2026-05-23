## Heading 2 CDC Chronic Disease Indicators (CDI) — SQL Analysis

SQL analysis project using the CDC Chronic Disease Indicators dataset (27,300 records covering all 50 U.S. states from 2016–2022). This project explores national disease trends, demographic disparities, and state-level health outcomes using analytical SQL in DuckDB.

What this project covers
Descriptive statistics by disease category
State rankings for diabetes prevalence
Longitudinal hypertension gender-gap trends
Obesity rankings using SQL window functions
Smoking disparities across demographic groups
Dataset

Source: CDC Chronic Disease Indicators Dataset

- **Topics Included:**
    - <sub>Diabetes</sub>
    - <sub>Cardiovascular disease</sub>
    - <sub>Obesity</sub>
    - <sub>Hypertension</sub>
    - <sub>Smoking</sub>
- **Tools Used:**
    - <sub>DuckDB</sub>
    - <sub>SQL window functions</sub>
    - <sub>Aggregate analysis and trend analysis</sub>
- **SQL Concepts Demonstrated:**
    - <sub>GROUP BY aggregation</sub>
    - <sub>AVG, MIN, MAX, COUNT</sub>
    - <sub>Common Table Expressions (CTEs)</sub>
    - <sub>CASE WHEN</sub>
    - <sub>Window functions with RANK() OVER()</sub>
    - <sub>Comparative demographic analysis</sub>
    - <sub>Time-series trend analysis</sub>
- **Key Findings:**
    - <sub>Cardiovascular disease showed the highest overall burden.</sub>
    - <sub>Diabetes had large variation across states.</sub>
    - <sub>The hypertension gender gap shifted from slightly higher in women (2016) to higher in men (2022).</sub>
    - <sub>Michigan and Ohio ranked among the highest obesity prevalence states.</sub>
    - <sub>Smoking prevalence differed noticeably across demographic groups.</sub>
- **Files:**
    - <sub>`cdc_cdi_analysis.sql` — Main SQL analysis queries</sub>
- **Goal**


This project was built to practice applied SQL analytics on public health data and demonstrate skills in:

Data exploration
Statistical summarization
Window functions
Public health trend analysis
Reproducible SQL workflows
