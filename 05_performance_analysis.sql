-- Project: Performance Analysis
-- Goal: Evaluate yearly product performance and identify sales trends over time.
--
-- This query calculates:
--   • Yearly total sales per product
--   • Average yearly sales (across all years) for each product
--   • Difference between current year sales and the product’s average sales
--   • Classification of each year as 'Above Average', 'Below Average', or 'Average'
--
--   Additionally, it performs Year-over-Year (YoY) analysis using window functions:
--   • Retrieves previous year’s sales for each product (LAG)
--   • Calculates the difference compared to the prior year
--   • Labels yearly performance as 'Increase', 'Decrease', or 'No Change'
--
-- Purpose: To understand how each product performs compared to its historical average
-- and how its sales evolve from year to year.
--
-- Key SQL concepts used:
--   - Common Table Expression (CTE)
--   - Window functions (AVG() OVER, LAG() OVER)
--   - Conditional logic with CASE statements
--   - Year-over-Year (YoY) trend analysis

with yearly_product_sales as ( select
year(s.order_date) as order_year,
p.product_name as product,
sum(s.sales_amount) as current_sales
from [gold.fact_sales] as s left join [gold.dim_products] as p on s.product_key=p.product_key
where year(s.order_date) is not null
group by year(s.order_date),
p.product_name )

select
order_year,
product,
current_sales,
avg(current_sales) over (partition by product) as avg_sales,
current_sales - avg(current_sales) over (partition by product) as avg_diff,
case when current_sales - avg(current_sales) over (partition by product) > 0 then 'Above Average'
when current_sales - avg(current_sales) over (partition by product) < 0 then 'Below Average'
else 'Average' end as avg_change,
--YoY Analaysis--
lag(current_sales) over (partition by product order by order_year) as py_sales,
current_sales - lag(current_sales) over (partition by product order by order_year) as sales_diff,
case when current_sales - lag(current_sales) over (partition by product order by order_year) > 0 then 'Increase'
 when current_sales - lag(current_sales) over (partition by product order by order_year) < 0 then 'Decrease'
 else 'No Change' end as sales_change
from yearly_product_sales
order by product, order_year

