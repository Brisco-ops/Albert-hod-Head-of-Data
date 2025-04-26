-- Answer all the questions below with basics SQL queries
-- don't forget to add a screenshot of the result from BigQuery directly in the basics/ folder

-- 1. What are the possible values of an order status? 

SELECT
DISTINCT order_status
FROM `BRONZE.orders` 
ORDER BY order_status



-- 2. Who are the 5 last customers that purchased a DELIVERED order (order with status DELIVERED)?
-- print their customer_id, their unique_id, and city

SELECT 
  o.customer_id,
  c.customer_unique_id,
  c.customer_city
FROM 
  `BRONZE.orders` o
JOIN 
  `BRONZE.customers` c
ON 
  o.customer_id = c.customer_id
WHERE 
  o.order_status = 'delivered'
ORDER BY 
  o.order_purchase_timestamp DESC
LIMIT 5;


-- 3. Add a column is_sp which returns 1 if the customer is from São Paulo and 0 otherwise

SELECT 
  customer_id,customer_city,
IF (customer_city ='sao paulo',1,0) AS is_sp,
FROM `BRONZE.customers`

-- 4. add a new column: what's the product category associated to the order?

SELECT 
  o.customer_id,
  c.customer_unique_id,
  c.customer_city,
  p.product_category_name
FROM 
  `BRONZE.orders` o
JOIN 
  `BRONZE.customers` c
  ON o.customer_id = c.customer_id
JOIN 
  `BRONZE.order_items` oi
  ON o.order_id = oi.order_id
JOIN 
  `BRONZE.products` p
  ON oi.product_id = p.product_id
WHERE 
  o.order_status = 'delivered'
ORDER BY 
  o.order_purchase_timestamp DESC
LIMIT 5;