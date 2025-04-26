"""
build the following table in Big Query. You don't have to create the table, just write the code in this file
if you want, you can also create it in a dataset of your name in Big Query - like AMAURY.customer_summary
"""


"""
the table must have the following columns:

-- customer identifiers
customer_unique_id: unique identifier for each customer
customer_zip_code_prefix: customer's postal code prefix
customer_city: city where the customer is located
customer_state: state where the customer is located

-- order metrics
total_orders: total number of orders placed by the customer
first_order_date: date of the customer's first purchase
last_order_date: date of the customer's most recent purchase
customer_lifetime_days: number of days between first and last order
delivered_orders: number of successfully delivered orders
canceled_orders: number of canceled orders
cancellation_rate: percentage of orders that were canceled

-- purchase patterns
avg_days_between_orders: average time between consecutive orders
days_since_last_order: number of days since the customer's most recent purchase (with current date = 2018-09-04, when the data stops)

-- customer life time value / cost metrics
total_spend: total amount spent by the customer
avg_order_value: average monetary value per order
total_freight_cost: total shipping costs paid
freight_to_price_ratio: shipping cost as a percentage of product price

-- product metrics
unique_products_purchased: number of different products bought
unique_categories_count: number of different product categories explored
top_categories: most frequently purchased product categories

-- payment behavior
payment_methods_count: number of different payment methods used
primary_payment_method: most frequently used payment method
avg_installments: average number of installments used for payments

-- review behavior
total_reviews: number of reviews submitted
avg_review_score: average rating given in reviews
review_rate: percentage of orders that received a review
five_star_percent: percentage of reviews with 5-star rating
one_star_percent: percentage of reviews with 1-star rating
avg_days_to_review: average time between purchase and first review submission by order
customer_sentiment: overall sentiment category based on reviews (e.g., positive, neutral, negative)

-- delivery experience
avg_delivery_time: average time from order to delivery
avg_delivery_vs_estimated: average difference between actual and estimated delivery dates
on_time_delivery_rate: percentage of orders delivered on or before estimated date

-- seller relationships
unique_sellers: number of different sellers purchased from
same_state_purchase_percent: percentage of purchases from sellers in the same state

-- rfm analysis (rfm = recency, frequency, monetary)
recency_days: days since last purchase (with current date = 2018-09-04)
frequency: number of purchases
recency_score: score based on recency (1-5 scale)
frequency_score: score based on frequency (1-5 scale)
monetary_score: score based on monetary value (1-5 scale)
rfm_score: combined rfm score
customer_segment: customer segment based on rfm analysis (Champions, Promising, Recent Customers, At Risk, Lost, Other)

-- time metrics
acquisition_year: year when the customer made their first purchase
acquisition_quarter: quarter when the customer made their first purchase
acquisition_month: month when the customer made their first purchase
etl_timestamp: timestamp when the data was last processed


"""