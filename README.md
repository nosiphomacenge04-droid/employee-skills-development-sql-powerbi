# employee-skills-development-sql-powerbi
SQL Server and Power BI project analysing employee skills, proficiency levels and tool transitions (e.g. Excel → Power BI), with a database design, analysis queries and an interactive dashboard.

# Employee Skills Development and Tool Transitions

An end-to-end data analysis project that tracks which tools employees know, how proficient they are, and how they are moving from one tool to another (for example Excel → Power BI) as part of training. The data is stored and analysed in **SQL Server** and presented in a **Power BI** dashboard.

![Dashboard](images/dashboard.png)

## Business questions

- How many employees are in each department?
- Which skills/tools are the most common, and how experienced are employees in each?
- What is the proficiency level for each tool?
- Which tools are employees moving from and to, and what is the most common transition?
- How many transitions have been completed vs. are still in progress?
- Which departments have the most skill transitions?

## Tools used

- **SQL Server (SSMS)**: database design, data loading, analysis queries (joins, aggregation, subqueries, CTEs, CASE)
- **Power BI**: interactive dashboard

## Database structure

| Table | Description |
|---|---|
| `Employees` | Employee, department, job role and hire date |
| `Skills` | Tools/technologies and their category |
| `EmployeeSkills` | Which employee has which skill, with proficiency level and years of experience |
| `SkillTransitions` | Records of employees moving from one tool to another, with reason, date and training status |

`EmployeeSkills` and `SkillTransitions` link back to `Employees` and `Skills` through foreign keys.

## Key findings

- The dataset covers **10 employees**, **7 skills** and **13 transitions**; **10 transitions (76.92%)** are completed.
- **Excel → Power BI** is the most common transition (3 employees).
- **Excel** is the most common skill (7 employees), followed by **SQL** (6) and **Power BI** (4).
- **Finance** and **IT** are the largest departments (3 employees each).
- Proficiency: 11 Advanced, 10 Intermediate, 2 Beginner.

## Repository structure

```
├── sql/
│   ├── 01_create_tables.sql      # creates the database and tables
│   ├── 02_insert_data.sql        # loads the sample data
│   └── 03_analysis_queries.sql   # analysis queries
├── powerbi/
│   └── Employee_Skills_Dashboard.pbix
└── images/
    └── dashboard.png
```

## How to run

1. Open SQL Server Management Studio.
2. Run the scripts in order: `01_create_tables.sql`, `02_insert_data.sql`, `03_analysis_queries.sql`.
3. Open `powerbi/Employee_Skills_Dashboard.pbix` in Power BI Desktop to explore the dashboard.

## Note

The employee data is fictional sample data created for practice.
