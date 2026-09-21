# Hospital Patient Care Operations Analytics

## MySQL Business Analytics Project

A practical SQL analytics project designed to understand hospital patient care operations using relational data.

The project analyzes patient demand, appointment behaviour, treatment performance, doctor performance, room utilization, and operational problems using MySQL.

---

## Project Overview

This project uses a synthetic hospital dataset representing the operations of **CarePlus Hospital**.

The database contains five interconnected tables:

- Patients
- Appointments
- Treatments
- Doctors
- Rooms

The analysis was developed to answer business-oriented questions using SQL rather than simply performing database queries.

---

## Dataset

| Table | Records |
|---|---:|
| Patients | 400 |
| Appointments | 3,000 |
| Treatments | 3,500 |
| Doctors | 80 |
| Rooms | 50 |

---

## Business Questions

The project investigates questions such as:

- Which cities generate the highest appointment volume?
- Which booking channels are used most frequently?
- What is the estimated appointment value?
- How do patient types differ in estimated appointment value?
- What is the overall appointment completion rate?
- Which treatments require multiple attempts?
- Which cities have higher operational problem rates?
- Which doctors handle higher workloads?
- Which rooms have higher workload and waiting time?
- What operational patterns can be identified from the data?

---

## SQL Techniques Used

The project applies a range of MySQL concepts, including:

- Database and table creation
- Primary keys and foreign keys
- Data filtering
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`
- Aggregate functions
- `CASE`
- String functions
- Date functions
- Mathematical functions
- `INNER JOIN`
- `LEFT JOIN`
- Multi-table joins
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- `RANK()`
- `LAG()`
- Conditional aggregation
- Business-oriented analytical queries

---

## Analysis Areas

### 1. Patient Demand Analysis

Analyzed appointment volume across cities and booking channels to understand patient demand patterns.

### 2. Patient Behaviour Analysis

Examined patient types, appointment activity, and treatment attempts to identify behavioural patterns.

### 3. Treatment Performance Analysis

Analyzed treatment duration, treatment status, completion patterns, cancellations, rescheduling, and no-shows.

### 4. Doctor and Room Performance

Compared doctor workloads and room utilization to identify areas with higher operational activity.

### 5. Operational Problems

Investigated waiting time, appointment issues, treatment attempts, and city-level operational problem rates.

---

## Key Findings

Some of the major findings from the analysis include:

- The database contains **3,000 appointments** across **400 patients**.
- There are **3,500 treatment records** across the hospital operations.
- **72 doctors** are active in the appointment data.
- The estimated total appointment value is approximately **₹14.33 million**.
- The average treatment duration is approximately **38.72 minutes**.
- **Completed** treatments represent the largest treatment-status category.
- Approximately **70.4%** of appointments/treatment records fall into the completed category used in the analysis.
- Approximately **16.7%** of appointments had more than one treatment attempt.
- The overall average waiting time is approximately **15.62 minutes**.
- Several rooms show workload and waiting-time levels above the overall room averages.
- City-level analysis reveals differences in appointment volume and operational problem rates.

---

## Business Insights

The analysis shows that hospital operations can be examined from multiple perspectives using relational data.

Appointment volume helps identify demand patterns, while booking-channel analysis provides insight into how patients access hospital services.

Treatment-status analysis highlights operational issues such as cancellations, rescheduling, and no-shows.

Doctor and room analysis can help identify areas where workload and waiting time may require further operational attention.

---

## Recommendations

Based on the SQL analysis, the following areas could be considered for further operational improvement:

- Monitor cities with relatively higher operational problem rates.
- Investigate rooms with both higher workload and higher waiting time.
- Analyze repeated treatment attempts to understand potential process inefficiencies.
- Monitor cancellation, rescheduling, and no-show patterns.
- Review booking-channel usage to understand patient preferences.
- Use workload analysis to support future resource planning.

These recommendations are based on the patterns observed in the synthetic dataset.

---

## Project Structure

```text
Hospital-Patient-Care-Operations-Analytics/
│
├── database/
│   └── CarePlus_Hospital_database.sql
│
├── documentation/
│   └── ER Diagram and project documentation
│
├── presentation/
│   └── Hospital Patient Care Operations Analytics presentation
│
├── screenshots/
│   ├── 01-Basic-SQL-Analysis.png
│   ├── 02-Patient-Demand-Analysis.png
│   ├── 03-Patient-Behaviour.png
│   ├── 04-Treatment-Performance.png
│   ├── 05-Doctor-Room-Performance.png
│   └── 06-Operational-Problems.png
│
└── README.md

Tools Used
MySQL
MySQL Workbench
SQL
GitHub
GitHub Desktop


Project Team
Syed Areeb

B.E. Computer Science Engineering
Muffakham Jah College of Engineering and Technology

LinkedIn: https://www.linkedin.com/in/syed-areeb-ds

GitHub: https://github.com/areebbaha

Syed Abdul Sattar

B.E. Computer Science Engineering
Muffakham Jah College of Engineering and Technology

LinkedIn: https://www.linkedin.com/in/syed-abdul-sattar-575589277

GitHub: https://github.com/syed-abdul-sattar

What I Learned
Through this project, I practiced:

Designing and understanding relational databases
Writing SQL queries for business questions
Joining multiple related tables
Aggregating and summarizing data
Using subqueries and CTEs
Applying window functions
Validating analytical results
Translating SQL outputs into business insights
Presenting analytical findings clearly

Repository Purpose
This project is part of my SQL and Data Analytics learning portfolio.
It demonstrates the progression from learning individual SQL concepts to applying SQL to a larger, business-oriented analytics problem.