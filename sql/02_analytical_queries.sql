--: Do delayed deliveries result in a higher number of customer care calls than on-time deliveries?
SELECT
	CASE
		WHEN reached_on_time = 1 THEN 'Delayed'
		ELSE 'On Time'
	END AS delivery_status,
	COUNT(*) as total_deliveries, 
	SUM(customer_care_calls) as total_calls, 
	ROUND(AVG(customer_care_calls), 2) AS avg_calls_per_delievery
FROM customer_analytics
GROUP BY reached_on_time;

--: What is the most common mode of shipment for each warehouse, and on average, how many customer care calls occur as a result? 
WITH shipment_summary AS (
	SELECT 
		warehouse_block,
		mode_of_shipment,
		COUNT(*) AS total_shipments,
		ROUND(AVG(customer_care_calls), 2) AS avg_calls,
		ROW_NUMBER() OVER (
			PARTITION BY warehouse_block
			ORDER BY COUNT(*) DESC
		) AS rank_position
	FROM customer_analytics
	GROUP BY warehouse_block, mode_of_shipment
)
SELECT
	warehouse_block,
	mode_of_shipment AS most_common_mode,
	total_shipments,
	avg_calls
FROM shipment_summary
WHERE rank_position = 1;

--: the relation of the customer care calls and reached on time to the customer rating
SELECT
	warehouse_block,
	CASE
		WHEN reached_on_time = 1 THEN 'Delayed'
		ELSE 'On Time'
	END AS delivery_status,
	COUNT(*) AS total_orders,
	ROUND(AVG(customer_care_calls), 2) AS avg_calls,
	ROUND(AVG(customer_rating), 2) AS avg_rating
FROM customer_analytics
GROUP BY warehouse_block, reached_on_time
ORDER BY warehouse_block ASC, delivery_status;

--: Percentage of reached on time and it's relevance to the product importance
SELECT
	ROUND(
		SUM(CASE WHEN reached_on_time = 0 THEN 1 ELSE 0 END) * 100.0/ COUNT(*),
		2
	) AS on_time_pct,
	product_importance,
	COUNT(*) AS total_orders
FROM customer_analytics
GROUP BY product_importance;

SELECT
	ROUND(
		SUM(CASE WHEN reached_on_time = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
		2
	) AS delayed_pct,
	product_importance,
	COUNT(*) AS total_orders
FROM customer_analytics
GROUP BY product_importance;

--: Correlation / relationship between customer care calls and customer rating.
SELECT
	customer_care_calls,
	COUNT(*) AS total_orders,
	ROUND(AVG(customer_rating), 2) AS avg_customer_rating
FROM customer_analytics
GROUP BY customer_care_calls
ORDER BY customer_care_calls ASC;

--: Warehouse block performance (delivery success rate and customer ratings per warehouse)
SELECT
	warehouse_block,
		ROUND(
			SUM(CASE WHEN reached_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
			AS on_time_pct,
		ROUND(
			SUM(CASE WHEN reached_on_time = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
			AS delayed_pct,
		COUNT(*) AS total_deliveries,
		AVG(customer_rating) AS avg_customer_rating
FROM customer_analytics
GROUP BY warehouse_block
ORDER BY warehouse_block ASC;
	
	


--: Percentage of on-time delivery/delayed deliveries by each means of transportation (mode_of_shipment)
SELECT
	mode_of_shipment,
	COUNT(*) AS total_shipment,
	ROUND(
		SUM(CASE WHEN reached_on_time = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
		2
	) AS on_time_pct,
	ROUND(
		SUM(CASE WHEN reached_on_time = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
		2
	) AS delayed_pct
FROM customer_analytics
GROUP BY mode_of_shipment
