-- Answer all the questions below with aggegate SQL queries
-- don't forget to add a screenshot of the result from BigQuery directly in the basics/ folder

-- 1. What was the total revenue and order count for 2018?

SELECT 
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS date,
  COUNT(DISTINCT o.order_id) AS order_count,
  ROUND (SUM(oi.price + oi.freight_value),2) AS total_revenue,
FROM BRONZE.orders o
JOIN BRONZE.order_items  oi ON o.order_id = oi.order_id
WHERE EXTRACT (YEAR FROM o.order_purchase_timestamp)=2018
GROUP BY 1

-- 2. What is the total_sales, average_order_sales, and first_order_date by customer? 
-- Round the values to 2 decimal places & order by total_sales descending
-- limit to 1000 results

SELECT 
  o.customer_id,
  ROUND(SUM(oi.price + oi.freight_value),2) AS total_sales,
  ROUND(AVG(oi.price + oi.freight_value),2) AS average_order_sales,
  MIN(o.order_purchase_timestamp) AS first_order_date
FROM BRONZE.orders o
JOIN `BRONZE.order_items`oi 
ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY 2 DESC
LIMIT 1000

-- 3. Who are the top 10 most successful sellers?

SELECT 
  s.seller_id,
  ROUND(SUM(oi.price + oi.freight_value),2) AS total_sales,
FROM BRONZE.order_items oi
JOIN BRONZE.sellers s 
ON oi.seller_id = s.seller_id
GROUP BY s.seller_id
ORDER BY 2 ASC
LIMIT 10

-- 4. What’s the preferred payment method by product category?

SELECT
  category AS product_category,
  p.payment_type,
  COUNT(*) AS payment_count
FROM BRONZE.order_summary os
JOIN BRONZE.payments p
ON os.order_id = p.order_id,
UNNEST(os.product_categories) AS category
GROUP BY category, p.payment_type
ORDER BY payment_count DESC;


