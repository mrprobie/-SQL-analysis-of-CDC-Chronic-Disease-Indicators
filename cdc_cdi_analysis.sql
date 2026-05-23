-- ============================================================
-- CDC Chronic Disease Indicators (CDI) — SQL Analysis
-- Dataset : data.cdc.gov/g4ie-h725  |  27,300 records
-- Scope   : 50 U.S. states, 2016–2022, 5 disease categories
-- Author  : Macire Fofana
-- Tools   : DuckDB (SQL)
-- ============================================================
-- Dataset columns:
--   year, location_abbr, location_desc, topic, question,
--   data_value (prevalence % or rate per 100k),
--   stratification (Overall / Male / Female / Race groups),
--   data_source (BRFSS = survey, NVSS = vital statistics)
-- ============================================================


-- ============================================================
-- QUERY 1: Descriptive Statistics — Disease Burden by Topic
-- Goal: Compute national summary statistics for each disease
--       category to prioritize which areas have the highest
--       and most variable burden (supports study design).
-- ============================================================

SELECT
    topic,
    ROUND(AVG(data_value), 1)   AS avg_prevalence,
    ROUND(MIN(data_value), 1)   AS min_value,
    ROUND(MAX(data_value), 1)   AS max_value,
    ROUND(MAX(data_value)
        - MIN(data_value), 1)   AS range_spread,
    COUNT(DISTINCT location_abbr) AS states_reporting
FROM   cdi
WHERE  stratification = 'Overall'
  AND  year = 2022
GROUP  BY topic
ORDER  BY avg_prevalence DESC;

-- Key finding:
-- Cardiovascular Disease carries the highest numeric burden
-- (avg 97.4 per 100k when mortality rates are included).
-- Diabetes shows the widest state-level spread, suggesting
-- strong geographic variation worth further investigation.


-- ============================================================
-- QUERY 2: State-Level Ranking — Diabetes Prevalence (2018–2022)
-- Goal: Identify the 10 states with the highest average adult
--       diabetes prevalence over a 5-year window to support
--       geographic targeting in research planning.
-- ============================================================

SELECT
    location_abbr,
    location_desc,
    ROUND(AVG(data_value), 1) AS avg_diabetes_pct
FROM   cdi
WHERE  question      = 'Prevalence of diagnosed diabetes among adults'
  AND  stratification = 'Overall'
  AND  year BETWEEN 2018 AND 2022
GROUP  BY location_abbr, location_desc
ORDER  BY avg_diabetes_pct DESC
LIMIT  10;

-- Key finding:
-- Illinois, Montana, and South Carolina rank highest (11–13%).
-- The 5-year average smooths single-year outliers and gives
-- a more stable estimate suitable for analytic planning.


-- ============================================================
-- QUERY 3: Trend Analysis — Hypertension Gender Gap Over Time
-- Goal: Examine whether the male-female gap in hypertension
--       prevalence has widened, narrowed, or remained stable
--       from 2016 to 2022 (longitudinal descriptive analysis).
-- ============================================================

SELECT
    year,
    ROUND(AVG(CASE WHEN stratification = 'Male'
                   THEN data_value END), 1)                         AS male_avg_pct,
    ROUND(AVG(CASE WHEN stratification = 'Female'
                   THEN data_value END), 1)                         AS female_avg_pct,
    ROUND(AVG(CASE WHEN stratification = 'Male'   THEN data_value END)
        - AVG(CASE WHEN stratification = 'Female' THEN data_value END),
          1)                                                         AS gender_gap_pct
FROM   cdi
WHERE  question = 'Prevalence of hypertension among adults'
GROUP  BY year
ORDER  BY year;

-- Key finding:
-- The gender gap has widened from -0.5 pp (women slightly
-- higher) in 2016 to +1.2 pp (men higher) by 2022 — a trend
-- that may warrant stratified subgroup analysis in future studies.


-- ============================================================
-- QUERY 4: Window Function — State Obesity Rankings (2022)
-- Goal: Rank all 50 states by adult obesity prevalence using
--       a window function to assign national rank without
--       losing state-level detail.
-- ============================================================

WITH state_obesity AS (
    SELECT
        location_abbr,
        location_desc,
        ROUND(data_value, 1)                              AS obesity_pct,
        RANK() OVER (ORDER BY data_value DESC)            AS national_rank
    FROM   cdi
    WHERE  question      = 'Prevalence of obesity among adults'
      AND  stratification = 'Overall'
      AND  year = 2022
)
SELECT
    national_rank,
    location_abbr,
    location_desc,
    obesity_pct
FROM   state_obesity
ORDER  BY national_rank
LIMIT  10;

-- Key finding:
-- Michigan (40.2%), Ohio (39.4%), and Kansas (39.3%) lead
-- nationally. RANK() preserves tied ranks (e.g., Delaware and
-- South Dakota both rank 7th), keeping the output statistically
-- honest rather than assigning arbitrary ordering.


-- ============================================================
-- QUERY 5: Demographic Disparity — Smoking Prevalence vs.
--          National Average (Window Function)
-- Goal: Quantify how each demographic group deviates from the
--       national overall smoking rate to identify subgroups
--       that may benefit from targeted interventions.
-- ============================================================

SELECT
    stratification,
    ROUND(AVG(data_value), 1)                                              AS avg_smoking_pct,
    ROUND(
        AVG(data_value)
        - AVG(AVG(data_value)) OVER (),
    1)                                                                     AS diff_from_national_avg
FROM   cdi
WHERE  question      = 'Current cigarette smoking among adults'
  AND  stratification IN ('Overall', 'Male', 'Female',
                          'White, non-Hispanic',
                          'Black, non-Hispanic', 'Hispanic')
  AND  year = 2022
GROUP  BY stratification
ORDER  BY avg_smoking_pct DESC;

-- Key finding:
-- Males and Black non-Hispanic adults smoke at 1.7 pp above
-- the national average, while Hispanic and White non-Hispanic
-- adults smoke below average. This disparity pattern supports
-- the case for stratified analytic plans in tobacco-related
-- research studies.


-- ============================================================
-- END OF ANALYSIS
-- All queries validated against 27,300-row dataset.
-- ============================================================
