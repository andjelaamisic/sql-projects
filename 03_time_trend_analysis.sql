-- Project: Changes Over Time
-- Goal: Track how key business metrics (sales, customers, and quantity sold)
-- evolve over time at different levels of granularity (yearly and monthly).
--
-- This file contains:
--   • Year-over-year summary of total sales, customers, and quantity
--   • Month-over-month analysis of the same metrics
--   • Use of DATE functions to group and compare performance by time period
--
-- Purpose: To identify business growth trends, seasonality, and potential
-- slowdowns or improvements over time.

-- changes over year
select
year(order_date) as year,
sum(sales_amount) as total_sales,
COUNT(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold.fact_sales]
where year(order_date) is not null
group by year(order_date)
order by year(order_date)

-- changes over month
select
month(order_date) as month,
sum(sales_amount) as total_sales,
COUNT(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold.fact_sales]
where month(order_date) is not null
group by month(order_date)
order by month(order_date)
----------
select
datetrunc(month,order_date) as month,
sum(sales_amount) as total_sales,
COUNT(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from [gold.fact_sales]
where datetrunc(month,order_date) is not null
group by datetrunc(month,order_date)
order by datetrunc(month,order_date)