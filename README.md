# Healthcare EHR Data Analysis (SQL and Excel Dashboard)

## Project Overview

This project analyzes Electronic Health Records (EHR) data to uncover insights into patient demographics, mortality patterns, and disease trends. The analysis combines advanced SQL techniques with an interactive Excel dashboard to deliver meaningful business insights.

---

## Tools and Technologies

* SQL (CTEs, Window Functions, Joins, Aggregations)
* Microsoft Excel (Pivot Tables, XLOOKUP, Slicers, Dashboard Design)
* Data Analysis and Visualization

---

## Dataset

The dataset consists of three core tables:

* patients.csv
* admissions.csv
* diagnoses_icd.csv

These datasets were used to perform relational analysis and derive patient-level and disease-level insights.

---

## SQL Analysis

The SQL analysis includes:

* Data validation and record counts
* Demographic analysis by gender
* Mortality rate calculations
* Age-based segmentation using CASE statements
* Common Table Expressions (CTEs) for structured queries
* Window functions such as RANK and LAG
* Top 10 most frequent diseases
* High-risk disease identification based on mortality rate
* Patient-level admission and mortality analysis
* Length of stay calculation
* Time-series analysis of admissions
* Readmission analysis within 30 days
* Disease contribution percentage analysis

---

## Excel Dashboard

The Excel dashboard provides an interactive interface for exploring key insights:

* KPI Metrics:

  * Total Admissions
  * Total Deaths
  * Mortality Rate

* Visualizations:

  * Mortality Rate by Age Group
  * Top 10 Most Common Diseases

* Features:

  * Pivot Tables for aggregation
  * Slicers for gender-based filtering
  * XLOOKUP for data integration
  * Structured tables for clean data handling

---

## Business Questions Answered

* What is the overall mortality rate across patients?
* How does mortality vary by age group?
* Which diseases are most common?
* Which diseases have higher associated mortality risk?
* How do readmissions impact patient outcomes?

---

## Key Insights

* Patients aged 70 and above show the highest mortality rate
* Patients aged 50 to 70 also demonstrate elevated risk
* A small number of diseases contribute significantly to total cases
* Certain diseases are associated with higher mortality rates
* Readmission within 30 days is a measurable factor in patient outcomes

---

## Project Structure

ehr-sql-analysis/
│
├── data/ Raw datasets (CSV files)
├── sql/ SQL queries for analysis
├── excel/ Excel dashboard
├── images/ Dashboard screenshots
├── README.md
└── .gitignore

## How to Run

### SQL Analysis

1. Load the CSV files into a SQL environment (PostgreSQL or similar)
2. Execute queries from:
   sql/analysis.sql

### Excel Dashboard

1. Open:
   excel/dashboard.xlsx
2. Use slicers to interact with the dashboard

---

## Skills Demonstrated

* Advanced SQL querying and optimization
* Data transformation and aggregation
* Analytical thinking and problem solving
* Dashboard development in Excel
* Business insight generation from raw data

---

## Author

Varsha Ponnaganti
