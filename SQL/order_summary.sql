"""
build the following table in Big Query. You don't have to create the table, just write the code in this file
if you want, you can also create it in a dataset of your name in Big Query - like AMAURY.order_summary
"""


"""
the table must have the following columns:

-- order identifiers
order_id: unique identifier for each order
customer_unique_id: unique identifier for the customer who placed the order
order_status: current status of the order (delivered, shipped, canceled, etc.)
order_purchase_timestamp: date and time when the order was placed
order_approved_at: date and time when the order was approved
order_delivered_carrier_date: date and time when the order was handed to the carrier
order_delivered_customer_date: date and time when the order was delivered to the customer
order_estimated_delivery_date: estimated date for delivery provided to customer

-- delivery metrics
actual_delivery_time_days: number of days between purchase and delivery to customer
delivery_delay_days: difference between estimated and actual delivery date
is_delivered_on_time: boolean indicating if order was delivered by the estimated date

-- order items metrics
total_items: total number of items in the order
unique_products: number of different products in the order
unique_sellers: number of different sellers in the order
total_order_value: total monetary value of the order
total_freight_value: total shipping cost for the order
avg_item_price: average price of items in the order
seller_ids_string: comma-separated list of seller IDs involved in the order
product_categories: array of product categories in the order

-- payment metrics
payment_installments_count: number of payment installments
payment_types: types of payment methods used (array)
total_payment_amount: total amount paid
credit_card_amount: amount paid via credit card
voucher_amount: amount paid via voucher
boleto_amount: amount paid via boleto
debit_card_amount: amount paid via debit card

-- review metrics
total_reviews: number of reviews submitted for the order
avg_review_score: average review score
min_review_score: minimum review score
max_review_score: maximum review score
review_titles: array of review titles
review_messages: concatenated review messages
days_to_review: days between purchase and first review
customer_satisfaction_category: category based on review scores (e.g., satisfied, neutral, dissatisfied)

-- customer location metrics
customer_zip_code_prefix: postal code prefix of the customer
customer_city: city of the customer
customer_state: state of the customer
customer_seller_location_match: indicates if customer and seller are in the same state

-- customer order history
is_repeat_order: boolean indicating if this is not the customer's first order
order_sequence_number: the sequence number of this order for the customer
is_repeat_seller_purchase: boolean indicating if customer purchased from this seller before
order_value_vs_customer_avg: difference between order value and customer's average order value

-- state comparative metrics
state_order_value_percentile: percentile of order value within the state
delivery_speed_vs_state_avg: indicates if delivery was faster or slower than state average

-- business categorization
order_value_category: categorization of order based on value (high, medium, low)
gross_profit: order value minus freight cost
shopping_season_category: categorization based on shopping season (christmas, black_friday, easter, regular, etc.)

-- time metrics
etl_timestamp: timestamp when the data was last processed

"""