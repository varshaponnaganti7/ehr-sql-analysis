-- ==================================================
-- Healthcare EHR Data Analysis
-- Author: Varsha Ponnaganti
-- ==================================================

-- Table: Patients
CREATE TABLE patients (
    subject_id INT,
    gender VARCHAR(5),
    anchor_age INT,
    anchor_year INT,
    anchor_year_group VARCHAR(20),
    dod DATE
);

-- Table: Admissions
CREATE TABLE admissions (
    subject_id INT,
    hadm_id BIGINT,
    admittime TIMESTAMP,
    dischtime TIMESTAMP,
    deathtime TIMESTAMP,
    admission_type VARCHAR(50),
    admission_location VARCHAR(100),
    discharge_location VARCHAR(100),
    insurance VARCHAR(50),
    language VARCHAR(20),
    marital_status VARCHAR(20),
    race VARCHAR(100),
    hospital_expire_flag INT
);

-- Table: Diagnoses
CREATE TABLE diagnoses (
    subject_id INT,
    hadm_id BIGINT,
    seq_num INT,
    icd_code VARCHAR(10),
    icd_version INT
);

-- =============================================
-- DATA EXPLORATION
-- =============================================

SELECT COUNT(*) FROM patients;
SELECT COUNT(*) FROM admissions;
SELECT COUNT(*) FROM diagnoses;

-- Gender distribution
SELECT gender, COUNT(*) AS patient_count
FROM patients
GROUP BY gender;

-- =============================================
-- DISEASE ANALYSIS
-- =============================================

SELECT icd_code, COUNT(*) AS cases
FROM diagnoses
GROUP BY icd_code
ORDER BY cases DESC
LIMIT 10;

-- =============================================
-- MORTALITY ANALYSIS
-- =============================================

SELECT 
COUNT(*) AS total_admissions,
SUM(hospital_expire_flag) AS deaths,
AVG(hospital_expire_flag) AS mortality_rate
FROM admissions;

-- Mortality by age
SELECT 
p.anchor_age,
AVG(a.hospital_expire_flag) AS mortality_rate
FROM admissions a
JOIN patients p
ON a.subject_id = p.subject_id
GROUP BY p.anchor_age
ORDER BY p.anchor_age;

-- Mortality by age groups
SELECT 
CASE 
WHEN p.anchor_age < 30 THEN 'Under 30'
WHEN p.anchor_age BETWEEN 30 AND 50 THEN '30-50'
WHEN p.anchor_age BETWEEN 50 AND 70 THEN '50-70'
ELSE '70+'
END AS age_group,
COUNT(*) AS patients,
AVG(a.hospital_expire_flag) AS mortality_rate
FROM admissions a
JOIN patients p
ON a.subject_id = p.subject_id
GROUP BY age_group
ORDER BY age_group;

-- =============================================
-- HIGH RISK DISEASES
-- =============================================

SELECT 
d.icd_code,
COUNT(*) AS cases,
AVG(a.hospital_expire_flag) AS mortality_rate
FROM diagnoses d
JOIN admissions a
ON d.hadm_id = a.hadm_id
GROUP BY d.icd_code
HAVING COUNT(*) > 5
ORDER BY mortality_rate DESC
LIMIT 10;