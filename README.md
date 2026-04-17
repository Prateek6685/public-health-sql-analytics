# 🏥 Public Health Crisis Analytics — SQL Project

## Overview
An end-to-end SQL analytics project analyzing real-world disease outbreak 
patterns, hospital capacity pressure, and mortality trends across 8 global 
regions using MySQL.

Built to demonstrate practical Data Analyst skills including relational 
database design, multi-table joins, subqueries, CTEs, and window functions.

---

## 📂 Project Structure

| File | Description |
|------|-------------|
| `schema_and_data.sql` | Database schema (DDL) + sample data (DML) |
| `module1_basic_exploration.sql` | Mortality rates, continent trends, bed capacity |
| `module2_intermediate_analysis.sql` | Deaths per 100k, age group analysis, subqueries |
| `module3_advanced_analytics.sql` | Window functions, CTEs, hospital pressure index |

---

## 🗄️ Database Schema

5 related tables:

- **regions** — countries and populations
- **diseases** — disease categories and contagion flags
- **hospitals** — bed and ICU capacity per region
- **outbreaks** — case and death counts per disease per region
- **admissions** — patient-level records with outcomes

---

## 🔍 Key Business Questions Answered

1. Which diseases have the highest mortality rate globally?
2. Which regions are most vulnerable by deaths per 100k population?
3. Which age groups face the highest fatality risk?
4. Which hospitals are under the most critical pressure?
5. How do outbreak durations correlate with death tolls?
6. Which diseases have spread across multiple continents?

---

## 💡 Advanced SQL Concepts Used

- `JOINS` across 3+ tables
- `GROUP BY` with `HAVING` filters
- `CASE WHEN` for dynamic categorization
- `Subqueries` for filtered aggregations
- `CTEs` (Common Table Expressions) for multi-step logic
- `Window Functions` — `RANK()`, `SUM() OVER`, `PARTITION BY`
- `NULLIF` and `COALESCE` for safe division and null handling

---

## ⚙️ How to Run This Project

1. Install MySQL (v8.0+)
2. Open MySQL Workbench
3. Run `schema_and_data.sql` to create and populate the database
4. Run each module file in order to explore the analysis

---

## 📊 Sample Insight

> Maharashtra and Lombardy showed the highest hospital pressure index
> (cases per available bed), flagging them as **critical zones** during
> peak outbreak periods — highlighting the need for surge capacity planning.

---

## 🛠️ Tools Used

- **MySQL 8.0**
- **MySQL Workbench**
- **GitHub**

---

## 👤 Author
**Prateek Billavar**  
Aspiring Data Analyst  
linkedin.com/in/prateek-billavar-5540b6310 • prateekb1905@gmail.com
