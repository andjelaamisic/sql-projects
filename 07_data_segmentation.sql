-- Project: Data Segmentation
-- Goal: Categorize products into cost-based segments to understand price distribution.
--
-- This query creates:
--   • Four cost segments ('below 100', '100–500', '500–1000', 'above 1000')
--   • Counts how many products fall into each price range
--
-- Purpose: To identify how products are distributed across different price categories
-- and highlight which segments contain the most products.
--
-- Key SQL concepts used:
--   - Common Table Expression (CTE)
--   - CASE WHEN statements for conditional segmentation
--   - Aggregation and sorting to rank segments by total products

with product_segments as (select
	product_key,
	product_name,
	cost,
	case when cost <100 then 'below 100'
	when cost between 100 and 500 then '100-500'
	when cost between 500 and 1000 then '500-1000'
	else 'above 1000' end as cost_range
from [gold.dim_products])

select
	cost_range,
	count(product_key) total_products
	from product_segments
	group by cost_range
order by total_products desc