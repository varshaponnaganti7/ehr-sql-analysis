-- =========================================================
-- Healthcare EHR Data Analysis (Advanced SQL Project)
-- Author: Varsha Ponnaganti
-- Description: Advanced SQL analysis on healthcare EHR data
-- =========================================================


-- =============================
-- 1. DATA VALIDATION
-- =============================

SELECT COUNT(*) AS total_patients FROM patients;
SELECT COUNT(*) AS total_admissions FROM admissions;
SELECT COUNT(*) AS total_diagnoses FROM diagnoses;


-- =============================
-- 2. DEMOGRAPHIC ANALYSIS
-- =============================

SELECT 
gender,
COUNT(*) AS patient_count,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM patients
GROUP BY gender;


-- =============================
-- 3. OVERALL MORTALITY
-- =============================

SELECT 
COUNT(*) AS total_admissions,
SUM(hospital_expire_flag) AS deaths,
ROUND(AVG(hospital_expire_flag), 4) AS mortality_rate
FROM admissions;


-- =============================
-- 4. AGE-BASED MORTALITY (CTE)
-- =============================

WITH age_data AS (
    SELECT 
    p.anchor_age,
    a.hospital_expire_flag
    FROM patients p
    JOIN admissions a
    ON p.subject_id = a.subject_id
)

SELECT 
anchor_age,
COUNT(*) AS total_patients,
ROUND(AVG(hospital_expire_flag), 4) AS mortality_rate
FROM age_data
GROUP BY anchor_age
ORDER BY anchor_age;


-- =============================
-- 5. AGE GROUP SEGMENTATION
-- =============================

WITH age_groups AS (
    SELECT 
    CASE 
        WHEN p.anchor_age < 30 THEN 'Under 30'
        WHEN p.anchor_age BETWEEN 30 AND 50 THEN '30-50'
        WHEN p.anchor_age BETWEEN 50 AND 70 THEN '50-70'
        ELSE '70+'
    END AS age_group,
    a.hospital_expire_flag
    FROM patients p
    JOIN admissions a
    ON p.subject_id = a.subject_id
)

SELECT 
age_group,
COUNT(*) AS patients,
ROUND(AVG(hospital_expire_flag), 4) AS mortality_rate
FROM age_groups
GROUP BY age_group
ORDER BY mortality_rate DESC;


-- =============================
-- 6. TOP DISEASES (WINDOW FUNCTION)
-- =============================

SELECT *
FROM (
    SELECT 
    icd_code,
    COUNT(*) AS cases,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM diagnoses
    GROUP BY icd_code
) ranked
WHERE rank <= 10;


-- =============================
-- 7. HIGH RISK DISEASES
-- =============================

WITH disease_stats AS (
    SELECT 
    d.icd_code,
    COUNT(*) AS cases,
    AVG(a.hospital_expire_flag) AS mortality_rate
    FROM diagnoses d
    JOIN admissions a
    ON d.hadm_id = a.hadm_id
    GROUP BY d.icd_code
)

SELECT *
FROM disease_stats
WHERE cases > 5
ORDER BY mortality_rate DESC
LIMIT 10;


-- =============================
-- 8. MORTALITY RANKING BY DISEASE
-- =============================

SELECT 
icd_code,
cases,
mortality_rate,
RANK() OVER (ORDER BY mortality_rate DESC) AS risk_rank
FROM (
    SELECT 
    d.icd_code,
    COUNT(*) AS cases,
    AVG(a.hospital_expire_flag) AS mortality_rate
    FROM diagnoses d
    JOIN admissions a
    ON d.hadm_id = a.hadm_id
    GROUP BY d.icd_code
) t
WHERE cases > 5;


-- =============================
-- 9. PATIENT-LEVEL ANALYSIS
-- =============================

SELECT 
subject_id,
COUNT(*) AS total_admissions,
SUM(hospital_expire_flag) AS death_flag
FROM admissions
GROUP BY subject_id
ORDER BY total_admissions DESC;


-- =============================
-- 10. LENGTH OF STAY ANALYSIS
-- =============================

-- For PostgreSQL
SELECT 
subject_id,
AVG(EXTRACT(EPOCH FROM (dischtime - admittime)) / 3600) AS avg_length_of_stay_hours
FROM admissions
GROUP BY subject_id
ORDER BY avg_length_of_stay_hours DESC;


-- =============================
-- 11. RUNNING MORTALITY TREND
-- =============================

SELECT 
anchor_age,
AVG(mortality_rate) OVER (ORDER BY anchor_age) AS cumulative_mortality
FROM (
    SELECT 
    p.anchor_age,
    AVG(a.hospital_expire_flag) AS mortality_rate
    FROM patients p
    JOIN admissions a
    ON p.subject_id = a.subject_id
    GROUP BY p.anchor_age
) t;


-- =============================
-- 12. ADMISSION TREND (TIME SERIES)
-- =============================

SELECT 
EXTRACT(YEAR FROM admittime) AS year,
COUNT(*) AS total_admissions,
AVG(hospital_expire_flag) AS mortality_rate
FROM admissions
GROUP BY year
ORDER BY year;


-- =============================
-- 13. READMISSION ANALYSIS (ADVANCED)
-- =============================

WITH patient_admissions AS (
    SELECT 
    subject_id,
    admittime,
    LAG(admittime) OVER (PARTITION BY subject_id ORDER BY admittime) AS previous_admission
    FROM admissions
)

SELECT 
COUNT(*) AS total_records,
COUNT(CASE 
    WHEN previous_admission IS NOT NULL 
    AND admittime - previous_admission <= INTERVAL '30 days' 
    THEN 1 END) AS readmissions_30_days
FROM patient_admissions;


-- =============================
-- 14. HIGH-RISK PATIENTS (RANKING)
-- =============================

SELECT 
subject_id,
total_admissions,
death_flag,
RANK() OVER (ORDER BY death_flag DESC, total_admissions DESC) AS risk_rank
FROM (
    SELECT 
    subject_id,
    COUNT(*) AS total_admissions,
    SUM(hospital_expire_flag) AS death_flag
    FROM admissions
    GROUP BY subject_id
) t
LIMIT 20;


-- =============================
-- 15. DISEASE CONTRIBUTION (%)
-- =============================

SELECT 
icd_code,
COUNT(*) AS cases,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS contribution_percentage
FROM diagnoses
GROUP BY icd_code
ORDER BY contribution_percentage DESC
LIMIT 10;