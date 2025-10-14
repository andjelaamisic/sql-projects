# My SQL Projects and Practice Queries

## Project Overview
This repository contains SQL projects and practice queries completed as part of the "SQL From Zero to Hero" course by Data with Bara.  
The goal of these projects is to extract insights from sales and product data, track performance over time, segment data, and generate comprehensive reports — simulating a real-world business scenario.

**Dataset:** Provided as part of the course. Contains fictional sales, product, and customer data for learning purposes.

---

## SQL Files & Descriptions

| File | Purpose |
|------|---------|
| `01_key_metrics_report.sql` | Generates a high-level report summarizing all key business metrics such as total sales, total orders, total customers, and quantities. |
| `02_measure_by_dimension.sql` | Analyzes key metrics across dimensions like country, gender, category, and customers; identifies top/bottom products and customers. |
| `03_changes_over_time.sql` | Tracks business metrics over time (yearly and monthly) to identify trends and seasonality. |
| `04_cumulative_analysis.sql` | Calculates running totals and cumulative sums to observe long-term sales and price trends. |
| `05_performance_analysis.sql` | Evaluates yearly product performance, compares current sales to historical averages, and performs YoY (Year-over-Year) analysis. |
| `06_part_to_whole_analysis.sql` | Determines each product category's contribution to total sales (part-to-whole analysis). |
| `07_data_segmentation.sql` | Segments products into cost-based groups and counts how many products fall into each range. |
| `08_product_performance_report.sql` | Comprehensive product report combining key metrics, performance segmentation, and KPIs like recency, average order revenue, and monthly revenue. |

---

## Key SQL Concepts Used
- **CTE (Common Table Expressions)** for modular and readable queries  
- **Window Functions** (`SUM() OVER`, `AVG() OVER`, `LAG() OVER`) for cumulative and YoY calculations  
- **Conditional Logic** (`CASE WHEN`) for segmentation and KPI classification  
- **Aggregations** (`SUM`, `COUNT`, `AVG`) for metrics calculations  
- **Date Functions** (`YEAR()`, `MONTH()`, `DATEDIFF()`, `DATETRUNC()`) for trend analysis  
- **Views** (`CREATE VIEW`) for reusable reports  

---

## Project Purpose & Outcomes
- Demonstrates the ability to extract actionable insights from raw sales and product data  
- Highlights trends, top/bottom performers, and product segmentation  
- Produces reports ready for business decision-making  
- Serves as a portfolio piece showcasing both SQL technical skills and business understanding  

---

## Optional Next Steps
- Visualize results in **Power BI**  
- Create interactive dashboards for KPIs and product performance  
- Extend analyses to include customer lifetime value (CLV) or retention metrics
