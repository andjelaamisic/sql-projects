-- Project: Part-to-Whole Analysis
-- Goal: Determine each product category's contribution to total company sales.
--
-- This query calculates:
--   • Total sales for each product category
--   • Overall company sales across all categories
--   • Percentage share of each category in total sales
--
-- Purpose: To understand which product categories generate the most revenue and
-- how they contribute to the company’s overall performance.
--
-- Key SQL concepts used:
--   - Common Table Expression (CTE)
--   - Window function SUM() OVER() for total aggregation
--   - Type casting and rounding for percentage calculation
--   - CONCAT() for clear percentage formatting

with category_sales as (select
p.category,
sum(s.sales_amount) total_sales
from [gold.fact_sales] as s left join [gold.dim_products] as p on s.product_key=p.product_key
group by p.category)

select
category,
total_sales,
sum(total_sales) over() as sum_sales,
concat(round((cast(total_sales as float)/sum(total_sales) over()) * 100,2), '%') as percentage_of_total
from category_sales
