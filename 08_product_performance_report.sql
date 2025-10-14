-- Project: Product Performance Report
-- Goal: Generate a comprehensive view of product-level metrics and profitability.
--
-- This query creates a detailed product report that:
--   • Joins sales and product dimension tables
--   • Aggregates product-level KPIs (orders, sales, quantity, customers)
--   • Segments products by total sales into High, Mid, or Low Performance groups
--   • Calculates:
--       - Product lifespan (months active)
--       - Recency (months since last sale)
--       - Average Selling Price (ASP)
--       - Average Order Revenue (AOR)
--       - Average Monthly Revenue (AMR)
--
-- Purpose: To provide a single, unified view of each product’s business performance,
-- supporting decisions about inventory, marketing, and pricing strategies.
--
-- Key SQL concepts used:
--   - View creation (CREATE VIEW)
--   - Multiple CTEs for modular structure
--   - CASE WHEN for segmentation and KPI classification
--   - Aggregations, joins, and date functions for performance metrics

IF OBJECT_ID('report_products', 'V') IS NOT NULL
    DROP VIEW report_products;
GO
create view report_products as
with base_query as (select
s.order_number,
s.customer_key,
s.order_date,
s.sales_amount,
s.quantity,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
from [gold.fact_sales] as s
left join 
[gold.dim_products] as p
on s.product_key=p.product_key
where order_date is not null),
/*---------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/
product_aggregation as (select
product_key,
product_name,
category,
subcategory,
cost,
count(distinct order_number) as total_orders,
sum(sales_amount) as total_sales,
sum(quantity) as total_quantity,
count(distinct customer_key) as total_customers,
datediff(month,min(order_date), max(order_date)) as lifespan,
max(order_date) as last_order,
round(avg(cast(sales_amount as float) / nullif(quantity,0)),1) AS avg_selling_price
from base_query
group by
product_key,
product_name,
category,
subcategory,
cost)
--3) Final Query: Combines all product results into one output--
 select
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_order,
	case when total_sales > 50000 then 'High Performance'
	when total_sales >= 10000 then 'Mid Performance'
	else 'Low performance' end as product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	datediff(month,last_order,getdate()) as recency_in_months,
	-- Average Order Revenue (AOR)
	case 
		when total_orders = 0 then '0'
		else total_sales/total_orders
    end as avg_order_revenue,
	-- Average Monthly Revenue
	case 
		when lifespan=0 then total_sales
		else total_sales / lifespan
	end  as average_monthly_revenue
from product_aggregation


