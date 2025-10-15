-- Project: Cumulative Analysis
-- Goal: Analyze cumulative sales and average price trends over time.
--
-- This query calculates:
--   • Monthly total sales and average product price
--   • Running (cumulative) total of sales within each year using window functions
--   • Moving average of prices by month (to smooth short-term price fluctuations).
--
-- Purpose: To identify how total sales and average product prices evolve cumulatively
-- over time and to detect general growth or decline patterns.
--
-- Key SQL concepts used:
--   - Window functions (SUM() OVER, AVG() OVER)
--   - ORDER BY and PARTITION BY for cumulative calculations
--   - Monthly aggregation via subquery before applying analytic functions

select
month,
total_sales,
sum(total_sales) over (partition by year(month) order by month) running_total,
avg(avg_price) over (order by month) moving_avg_price
from
(select
datetrunc(month,order_date) as month,
sum(sales_amount) as total_sales,
avg(price) as avg_price
from [gold.fact_sales]
where order_date is not null
group by datetrunc(month,order_date)
)t

