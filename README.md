#  Healthcare EHR Data Analysis (SQL + Excel Dashboard)

##  Project Overview

This project analyzes Electronic Health Records (EHR) data to uncover insights into patient demographics, mortality trends, and disease patterns.
It combines **advanced SQL querying** with an **interactive Excel dashboard** to deliver business-ready insights.

---

##  Tools & Technologies

* **SQL** (Joins, CTEs, Window Functions, Aggregations)
* **Microsoft Excel** (Pivot Tables, XLOOKUP, Slicers, Dashboard Design)
* **Data Visualization**
* **Data Analysis**

---

##  Dashboard Preview

![Dashboard](images/dashboard.png)

---

##  Key Analysis Performed

###  SQL Analysis

* Joined multiple datasets (patients, admissions, diagnoses)
* Used **CTEs** for structured queries
* Applied **window functions** (RANK) to identify top diseases
* Calculated **mortality rates** and patient-level metrics
* Performed **age-based segmentation**

---

###  Excel Analysis & Dashboard

* Data integration using **XLOOKUP**
* Created derived feature: **age groups**
* Built **pivot tables** for aggregation
* Designed **interactive charts**
* Added **slicers for filtering (gender)**
* Developed **KPI cards**:

  * Total Admissions
  * Total Deaths
  * Mortality Rate

---

##  Key Insights

* Higher mortality observed in patients aged **70+**
* Patients aged **50–70** also show elevated risk
* Identified most frequent disease codes using ranking
* Dashboard enables **interactive exploration by gender**

---

##  Project Structure

```
ehr-sql-analysis/
│
├── data/              # Raw datasets (CSV)
├── sql/               # SQL queries
├── excel/             # Excel dashboard
├── images/            # Dashboard screenshots
├── README.md
└── .gitignore
```

---

##  How to Run

###  SQL Analysis

* Load CSV files into your SQL environment
* Run queries from:

```text
sql/analysis.sql
```

###  Excel Dashboard

* Open:

```text
excel/dashboard.xlsx
```

* Use slicers to interact with the data

---

## 💡 Project Highlights

* End-to-end data analysis workflow
* Integration of SQL and Excel
* Interactive dashboard for business insights
* Clean and professional project structure

---

##  Author

**Varsha Ponnaganti**

---
