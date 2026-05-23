CDC Chronic Disease Indicators (CDI) — SQL Analysis

SQL analysis project using the CDC Chronic Disease Indicators dataset (27,300 records covering all 50 U.S. states from 2016–2022). This project explores national disease trends, demographic disparities, and state-level health outcomes using analytical SQL in DuckDB.

What this project covers
Descriptive statistics by disease category
State rankings for diabetes prevalence
Longitudinal hypertension gender-gap trends
Obesity rankings using SQL window functions
Smoking disparities across demographic groups
Dataset

Source: CDC Chronic Disease Indicators Dataset

Topics include:

Diabetes
Cardiovascular disease
Obesity
Hypertension
Smoking
Tools Used
DuckDB
Python
SQL window functions
Aggregate analysis and trend analysis
SQL Concepts Demonstrated
GROUP BY aggregation
AVG, MIN, MAX, COUNT
Common Table Expressions (CTEs)
CASE WHEN
Window functions with RANK() OVER()
Comparative demographic analysis
Time-series trend analysis
Key Findings
Cardiovascular disease showed the highest overall burden.
Diabetes had large variation across states.
The hypertension gender gap shifted from slightly higher in women (2016) to higher in men (2022).
Michigan and Ohio ranked among the highest obesity prevalence states.
Smoking prevalence differed noticeably across demographic groups.
Files
cdc_cdi_analysis.sql — Main SQL analysis queries
cdi_loader.py — Dataset loading and validation pipeline
Goal

This project was built to practice applied SQL analytics on public health data and demonstrate skills in:

Data exploration
Statistical summarization
Window functions
Public health trend analysis
Reproducible SQL workflows
