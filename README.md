# 🌍 World Energy Consumption Analysis (SQL Project)

## 📌 Project Overview
This project explores **global energy consumption, production, emissions, GDP, and population trends** using structured datasets.  
The goal is to understand the **relationship between economic power, energy usage, and environmental impact** through SQL-based analysis.  

Data was sourced from the **U.S. Energy Information Administration (EIA)** and imported into a MySQL database.  

---

## 🗂️ Dataset & Schema
The database `ENERGYDB2` contains 6 tables:

- **country** → master table with unique country codes and names  
- **emission_3** → CO₂ emissions by country, year, and energy type  
- **population** → population values by country and year  
- **production** → energy production by country, year, and type  
- **consumption** → energy consumption by country, year, and type  
- **gdp_3** → GDP (PPP) values by country and year  

**Schema Design:**  
- Central table: `country`  
- One-to-many relationships with: `emission_3`, `population`, `production`, `consumption`, and `gdp_3`.

---

## ⚡ Key Analysis Questions
This project answers critical global questions such as:

### 🔹 General & Comparative Analysis
- What is the total emission per country for the most recent year?
- What are the top 5 countries by GDP?
- How does production compare to consumption across countries?
- Which energy types contribute most to emissions?

### 🔹 Trend Analysis
- How have global emissions changed year over year?
- What is the GDP growth trend for each country?
- How has population growth affected emissions?
- Has energy consumption increased or decreased in major economies?

### 🔹 Ratios & Per Capita Analysis
- Emission-to-GDP ratio per country
- Energy consumption per capita in the last decade
- Energy production per capita by country
- Which countries consume the most energy relative to GDP?

### 🔹 Global Comparisons
- Top 10 most populated countries and their emissions
- Countries reducing per capita emissions the most in the last decade
- Global share (%) of emissions by country
- Global average GDP, emissions, and population by year

---

## 🛠️ Tools & Technologies
- **MySQL** (Workbench) → Database setup, schema, and queries  
- **SQL** → Joins, Grouping, Aggregations, Ratios, Trend Analysis  
- **EIA Dataset (CSV)** → Real-world structured data  

---

## ✅ Advantages of this Project
- Hands-on practice in **database design, normalization, and ER modeling**  
- Strong understanding of **data analysis using SQL (aggregations, joins, groupings)**  
- Real-world insights into **energy, economy, and environmental impact**  
- Readily extendable for **BI dashboards** (Power BI / Tableau)  
- Great **portfolio project** for interviews (Data Analyst / SQL / BI roles)  

---

## 🚀 How to Run
1. Clone/download the repo and open MySQL Workbench  
2. Run the script [`Energy Consumption Project(SQL).sql`](./Energy%20Consumption%20Project(SQL).sql)  
3. Import CSV datasets into tables (`Table Data Import Wizard`)  
4. Execute queries to explore trends and insights  

---

## 📊 Future Improvements
- Add **visualizations** (Power BI / Tableau)  
- Build a **dashboard** for interactive exploration  
- Integrate with **Python (Pandas, Matplotlib, Seaborn)** for deeper analysis  

---

## 🤝 Contributions
Contributions, issues, and suggestions are welcome!  
If you find this useful, ⭐ the repo and share your feedback.  

---
