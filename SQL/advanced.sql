-- Answer all the questions below with advanced SQL queries (partitioning, CASE WHENs)
-- don't forget to add a screenshot of the result from BigQuery directly in the basics/ folder

-- 1. Where are located the clients that ordered more than the average?

WITH order_count_per_customer AS (
  SELECT 
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS customer_order_count,
  FROM `BRONZE.orders` o
  JOIN `BRONZE.customers` c 
    ON o.customer_id = c.customer_id
  GROUP BY 1,2,3
),
average_orders AS (
  SELECT AVG(customer_order_count) AS avg_orders
  FROM order_count_per_customer
)
SELECT *
FROM order_count_per_customer, average_orders
WHERE customer_order_count > avg_orders
ORDER BY customer_order_count DESC;

-- 2. Segment clients in categories based on the amount spent (use CASE WHEN)

WITH total_spent_per_customer AS (
  SELECT 
    c.customer_unique_id,
    ROUND(SUM(oi.price), 2) AS total_spent
  FROM `BRONZE.orders` o
  JOIN `BRONZE.customers` c ON o.customer_id = c.customer_id
  JOIN `BRONZE.order_items` oi ON o.order_id = oi.order_id
  GROUP BY c.customer_unique_id
)
SELECT 
  customer_unique_id,
  total_spent,
  CASE 
    WHEN total_spent < 100 THEN 'Low spender'
    WHEN total_spent < 500 THEN 'Medium spender'
    WHEN total_spent < 1000 THEN 'High spender'
    ELSE 'Very high spender'
  END AS spending_category
FROM total_spent_per_customer
ORDER BY total_spent 
DESC;

-- 3. Compute the difference in days between the first and last order of a client. Compute then the average (use PARTITION BY)

WITH orders_per_client AS (
  SELECT 
    c.customer_unique_id,
    MIN(DATE(o.order_purchase_timestamp)) AS first_order,
    MAX(DATE(o.order_purchase_timestamp)) AS last_order
  FROM `BRONZE.orders` o
  JOIN `BRONZE.customers` c 
    ON o.customer_id = c.customer_id
  GROUP BY c.customer_unique_id
),
diffs AS (
  SELECT 
    customer_unique_id,
    DATE_DIFF(last_order, first_order, DAY) AS days_between_orders
  FROM orders_per_client
)
SELECT 
  customer_unique_id,
  days_between_orders,
  ROUND(AVG(days_between_orders) OVER (), 2) AS avg_days_between_orders
FROM diffs
ORDER BY days_between_orders 
DESC;

-- 4. Add a column to the query in basics question 2.: what was their first product category purchased?

WITH delivered_orders AS (
  SELECT 
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    o.order_purchase_timestamp
  FROM `BRONZE.orders` o
  JOIN `BRONZE.customers` c 
    ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
),
orders_with_category AS (
  SELECT 
    do.customer_id,
    do.customer_unique_id,
    do.customer_city,
    do.order_purchase_timestamp,
    p.product_category_name,
    ROW_NUMBER() OVER (PARTITION BY do.customer_id ORDER BY do.order_purchase_timestamp ASC) AS rn
  FROM delivered_orders do
  JOIN `BRONZE.order_items` oi 
    ON do.order_id = oi.order_id
  JOIN `BRONZE.products` p 
    ON oi.product_id = p.product_id
),
first_category_per_customer AS (
  SELECT 
    customer_id,
    customer_unique_id,
    customer_city,
    product_category_name AS first_product_category
  FROM orders_with_category
  WHERE rn = 1
),
last_5_customers AS (
  SELECT 
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    o.order_purchase_timestamp
  FROM `BRONZE.orders` o
  JOIN `BRONZE.customers` c 
    ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  ORDER BY o.order_purchase_timestamp 
  DESC
  LIMIT 5
)
SELECT 
  l.customer_id,
  l.customer_unique_id,
  l.customer_city,
  f.first_product_category
FROM last_5_customers l
LEFT JOIN first_category_per_customer f 
  ON l.customer_id = f.customer_id;