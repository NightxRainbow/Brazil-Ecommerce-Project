USE EcommerceProject_BrazilDataset;
GO

IF OBJECT_ID('dbo.v_data_quality_summary', 'V') IS NOT NULL
    DROP VIEW dbo.v_data_quality_summary;
GO

CREATE VIEW dbo.v_data_quality_summary AS
SELECT
    'olist_customers_dataset' AS table_name,
    'customer_id' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL OR LTRIM(RTRIM(CAST(customer_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) AS missing_value_count,
    SUM(CASE WHEN customer_id IS NOT NULL AND LTRIM(RTRIM(CAST(customer_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END) AS valid_value_count
FROM dbo.olist_customers_dataset
UNION ALL
SELECT
    'olist_customers_dataset',
    'customer_unique_id',
    COUNT(*),
    SUM(CASE WHEN customer_unique_id IS NULL OR LTRIM(RTRIM(CAST(customer_unique_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN customer_unique_id IS NOT NULL AND LTRIM(RTRIM(CAST(customer_unique_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_customers_dataset
UNION ALL
SELECT
    'olist_customers_dataset',
    'customer_zip_code_prefix',
    COUNT(*),
    SUM(CASE WHEN customer_zip_code_prefix IS NULL OR LTRIM(RTRIM(CAST(customer_zip_code_prefix AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN customer_zip_code_prefix IS NOT NULL AND LTRIM(RTRIM(CAST(customer_zip_code_prefix AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_customers_dataset
UNION ALL
SELECT
    'olist_customers_dataset',
    'customer_city',
    COUNT(*),
    SUM(CASE WHEN customer_city IS NULL OR LTRIM(RTRIM(CAST(customer_city AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN customer_city IS NOT NULL AND LTRIM(RTRIM(CAST(customer_city AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_customers_dataset
UNION ALL
SELECT
    'olist_customers_dataset',
    'customer_state',
    COUNT(*),
    SUM(CASE WHEN customer_state IS NULL OR LTRIM(RTRIM(CAST(customer_state AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN customer_state IS NOT NULL AND LTRIM(RTRIM(CAST(customer_state AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_customers_dataset

UNION ALL

SELECT
    'olist_geolocation_dataset',
    'geolocation_zip_code_prefix',
    COUNT(*),
    SUM(CASE WHEN geolocation_zip_code_prefix IS NULL OR LTRIM(RTRIM(CAST(geolocation_zip_code_prefix AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN geolocation_zip_code_prefix IS NOT NULL AND LTRIM(RTRIM(CAST(geolocation_zip_code_prefix AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_geolocation_dataset
UNION ALL
SELECT
    'olist_geolocation_dataset',
    'geolocation_lat',
    COUNT(*),
    SUM(CASE WHEN geolocation_lat IS NULL OR LTRIM(RTRIM(CAST(geolocation_lat AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN geolocation_lat IS NOT NULL AND LTRIM(RTRIM(CAST(geolocation_lat AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_geolocation_dataset
UNION ALL
SELECT
    'olist_geolocation_dataset',
    'geolocation_lng',
    COUNT(*),
    SUM(CASE WHEN geolocation_lng IS NULL OR LTRIM(RTRIM(CAST(geolocation_lng AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN geolocation_lng IS NOT NULL AND LTRIM(RTRIM(CAST(geolocation_lng AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_geolocation_dataset
UNION ALL
SELECT
    'olist_geolocation_dataset',
    'geolocation_city',
    COUNT(*),
    SUM(CASE WHEN geolocation_city IS NULL OR LTRIM(RTRIM(CAST(geolocation_city AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN geolocation_city IS NOT NULL AND LTRIM(RTRIM(CAST(geolocation_city AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_geolocation_dataset
UNION ALL
SELECT
    'olist_geolocation_dataset',
    'geolocation_state',
    COUNT(*),
    SUM(CASE WHEN geolocation_state IS NULL OR LTRIM(RTRIM(CAST(geolocation_state AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN geolocation_state IS NOT NULL AND LTRIM(RTRIM(CAST(geolocation_state AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_geolocation_dataset

UNION ALL

SELECT
    'olist_order_items_dataset',
    'order_id',
    COUNT(*),
    SUM(CASE WHEN order_id IS NULL OR LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_id IS NOT NULL AND LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_items_dataset
UNION ALL
SELECT
    'olist_order_items_dataset',
    'order_item_id',
    COUNT(*),
    SUM(CASE WHEN order_item_id IS NULL OR LTRIM(RTRIM(CAST(order_item_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_item_id IS NOT NULL AND LTRIM(RTRIM(CAST(order_item_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_items_dataset
UNION ALL
SELECT
    'olist_order_items_dataset',
    'product_id',
    COUNT(*),
    SUM(CASE WHEN product_id IS NULL OR LTRIM(RTRIM(CAST(product_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_id IS NOT NULL AND LTRIM(RTRIM(CAST(product_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_items_dataset
UNION ALL
SELECT
    'olist_order_items_dataset',
    'seller_id',
    COUNT(*),
    SUM(CASE WHEN seller_id IS NULL OR LTRIM(RTRIM(CAST(seller_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN seller_id IS NOT NULL AND LTRIM(RTRIM(CAST(seller_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_items_dataset
UNION ALL
SELECT
    'olist_order_items_dataset',
    'shipping_limit_date',
    COUNT(*),
    SUM(CASE WHEN shipping_limit_date IS NULL OR LTRIM(RTRIM(CAST(shipping_limit_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN shipping_limit_date IS NOT NULL AND LTRIM(RTRIM(CAST(shipping_limit_date AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_items_dataset
UNION ALL
SELECT
    'olist_order_items_dataset',
    'price',
    COUNT(*),
    SUM(CASE WHEN price IS NULL OR LTRIM(RTRIM(CAST(price AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN price IS NOT NULL AND LTRIM(RTRIM(CAST(price AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_items_dataset
UNION ALL
SELECT
    'olist_order_items_dataset',
    'freight_value',
    COUNT(*),
    SUM(CASE WHEN freight_value IS NULL OR LTRIM(RTRIM(CAST(freight_value AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN freight_value IS NOT NULL AND LTRIM(RTRIM(CAST(freight_value AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_items_dataset

UNION ALL

SELECT
    'olist_order_payments_dataset',
    'order_id',
    COUNT(*),
    SUM(CASE WHEN order_id IS NULL OR LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_id IS NOT NULL AND LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_payments_dataset
UNION ALL
SELECT
    'olist_order_payments_dataset',
    'payment_sequential',
    COUNT(*),
    SUM(CASE WHEN payment_sequential IS NULL OR LTRIM(RTRIM(CAST(payment_sequential AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN payment_sequential IS NOT NULL AND LTRIM(RTRIM(CAST(payment_sequential AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_payments_dataset
UNION ALL
SELECT
    'olist_order_payments_dataset',
    'payment_type',
    COUNT(*),
    SUM(CASE WHEN payment_type IS NULL OR LTRIM(RTRIM(CAST(payment_type AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN payment_type IS NOT NULL AND LTRIM(RTRIM(CAST(payment_type AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_payments_dataset
UNION ALL
SELECT
    'olist_order_payments_dataset',
    'payment_installments',
    COUNT(*),
    SUM(CASE WHEN payment_installments IS NULL OR LTRIM(RTRIM(CAST(payment_installments AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN payment_installments IS NOT NULL AND LTRIM(RTRIM(CAST(payment_installments AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_payments_dataset
UNION ALL
SELECT
    'olist_order_payments_dataset',
    'payment_value',
    COUNT(*),
    SUM(CASE WHEN payment_value IS NULL OR LTRIM(RTRIM(CAST(payment_value AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN payment_value IS NOT NULL AND LTRIM(RTRIM(CAST(payment_value AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_payments_dataset

UNION ALL

SELECT
    'olist_order_reviews_dataset',
    'review_id',
    COUNT(*),
    SUM(CASE WHEN review_id IS NULL OR LTRIM(RTRIM(CAST(review_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN review_id IS NOT NULL AND LTRIM(RTRIM(CAST(review_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_reviews_dataset
UNION ALL
SELECT
    'olist_order_reviews_dataset',
    'order_id',
    COUNT(*),
    SUM(CASE WHEN order_id IS NULL OR LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_id IS NOT NULL AND LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_reviews_dataset
UNION ALL
SELECT
    'olist_order_reviews_dataset',
    'review_score',
    COUNT(*),
    SUM(CASE WHEN review_score IS NULL OR LTRIM(RTRIM(CAST(review_score AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN review_score IS NOT NULL AND LTRIM(RTRIM(CAST(review_score AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_reviews_dataset
UNION ALL
SELECT
    'olist_order_reviews_dataset',
    'review_comment_title',
    COUNT(*),
    SUM(CASE WHEN review_comment_title IS NULL OR LTRIM(RTRIM(CAST(review_comment_title AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN review_comment_title IS NOT NULL AND LTRIM(RTRIM(CAST(review_comment_title AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_reviews_dataset
UNION ALL
SELECT
    'olist_order_reviews_dataset',
    'review_comment_message',
    COUNT(*),
    SUM(CASE WHEN review_comment_message IS NULL OR LTRIM(RTRIM(CAST(review_comment_message AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN review_comment_message IS NOT NULL AND LTRIM(RTRIM(CAST(review_comment_message AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_reviews_dataset
UNION ALL
SELECT
    'olist_order_reviews_dataset',
    'review_creation_date',
    COUNT(*),
    SUM(CASE WHEN review_creation_date IS NULL OR LTRIM(RTRIM(CAST(review_creation_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN review_creation_date IS NOT NULL AND LTRIM(RTRIM(CAST(review_creation_date AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_reviews_dataset
UNION ALL
SELECT
    'olist_order_reviews_dataset',
    'review_answer_timestamp',
    COUNT(*),
    SUM(CASE WHEN review_answer_timestamp IS NULL OR LTRIM(RTRIM(CAST(review_answer_timestamp AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN review_answer_timestamp IS NOT NULL AND LTRIM(RTRIM(CAST(review_answer_timestamp AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_order_reviews_dataset

UNION ALL

SELECT
    'olist_orders_dataset',
    'order_id',
    COUNT(*),
    SUM(CASE WHEN order_id IS NULL OR LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_id IS NOT NULL AND LTRIM(RTRIM(CAST(order_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset
UNION ALL
SELECT
    'olist_orders_dataset',
    'customer_id',
    COUNT(*),
    SUM(CASE WHEN customer_id IS NULL OR LTRIM(RTRIM(CAST(customer_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN customer_id IS NOT NULL AND LTRIM(RTRIM(CAST(customer_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset
UNION ALL
SELECT
    'olist_orders_dataset',
    'order_status',
    COUNT(*),
    SUM(CASE WHEN order_status IS NULL OR LTRIM(RTRIM(CAST(order_status AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_status IS NOT NULL AND LTRIM(RTRIM(CAST(order_status AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset
UNION ALL
SELECT
    'olist_orders_dataset',
    'order_purchase_timestamp',
    COUNT(*),
    SUM(CASE WHEN order_purchase_timestamp IS NULL OR LTRIM(RTRIM(CAST(order_purchase_timestamp AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_purchase_timestamp IS NOT NULL AND LTRIM(RTRIM(CAST(order_purchase_timestamp AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset
UNION ALL
SELECT
    'olist_orders_dataset',
    'order_approved_at',
    COUNT(*),
    SUM(CASE WHEN order_approved_at IS NULL OR LTRIM(RTRIM(CAST(order_approved_at AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_approved_at IS NOT NULL AND LTRIM(RTRIM(CAST(order_approved_at AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset
UNION ALL
SELECT
    'olist_orders_dataset',
    'order_delivered_carrier_date',
    COUNT(*),
    SUM(CASE WHEN order_delivered_carrier_date IS NULL OR LTRIM(RTRIM(CAST(order_delivered_carrier_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_delivered_carrier_date IS NOT NULL AND LTRIM(RTRIM(CAST(order_delivered_carrier_date AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset
UNION ALL
SELECT
    'olist_orders_dataset',
    'order_delivered_customer_date',
    COUNT(*),
    SUM(CASE WHEN order_delivered_customer_date IS NULL OR LTRIM(RTRIM(CAST(order_delivered_customer_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_delivered_customer_date IS NOT NULL AND LTRIM(RTRIM(CAST(order_delivered_customer_date AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset
UNION ALL
SELECT
    'olist_orders_dataset',
    'order_estimated_delivery_date',
    COUNT(*),
    SUM(CASE WHEN order_estimated_delivery_date IS NULL OR LTRIM(RTRIM(CAST(order_estimated_delivery_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN order_estimated_delivery_date IS NOT NULL AND LTRIM(RTRIM(CAST(order_estimated_delivery_date AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_orders_dataset

UNION ALL

SELECT
    'olist_products_dataset',
    'product_id',
    COUNT(*),
    SUM(CASE WHEN product_id IS NULL OR LTRIM(RTRIM(CAST(product_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_id IS NOT NULL AND LTRIM(RTRIM(CAST(product_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_category_name',
    COUNT(*),
    SUM(CASE WHEN product_category_name IS NULL OR LTRIM(RTRIM(CAST(product_category_name AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_category_name IS NOT NULL AND LTRIM(RTRIM(CAST(product_category_name AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_name_lenght',
    COUNT(*),
    SUM(CASE WHEN product_name_lenght IS NULL OR LTRIM(RTRIM(CAST(product_name_lenght AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_name_lenght IS NOT NULL AND LTRIM(RTRIM(CAST(product_name_lenght AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_description_lenght',
    COUNT(*),
    SUM(CASE WHEN product_description_lenght IS NULL OR LTRIM(RTRIM(CAST(product_description_lenght AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_description_lenght IS NOT NULL AND LTRIM(RTRIM(CAST(product_description_lenght AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_photos_qty',
    COUNT(*),
    SUM(CASE WHEN product_photos_qty IS NULL OR LTRIM(RTRIM(CAST(product_photos_qty AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_photos_qty IS NOT NULL AND LTRIM(RTRIM(CAST(product_photos_qty AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_weight_g',
    COUNT(*),
    SUM(CASE WHEN product_weight_g IS NULL OR LTRIM(RTRIM(CAST(product_weight_g AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_weight_g IS NOT NULL AND LTRIM(RTRIM(CAST(product_weight_g AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_length_cm',
    COUNT(*),
    SUM(CASE WHEN product_length_cm IS NULL OR LTRIM(RTRIM(CAST(product_length_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_length_cm IS NOT NULL AND LTRIM(RTRIM(CAST(product_length_cm AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_height_cm',
    COUNT(*),
    SUM(CASE WHEN product_height_cm IS NULL OR LTRIM(RTRIM(CAST(product_height_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_height_cm IS NOT NULL AND LTRIM(RTRIM(CAST(product_height_cm AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset
UNION ALL
SELECT
    'olist_products_dataset',
    'product_width_cm',
    COUNT(*),
    SUM(CASE WHEN product_width_cm IS NULL OR LTRIM(RTRIM(CAST(product_width_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_width_cm IS NOT NULL AND LTRIM(RTRIM(CAST(product_width_cm AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_products_dataset

UNION ALL

SELECT
    'olist_sellers_dataset',
    'seller_id',
    COUNT(*),
    SUM(CASE WHEN seller_id IS NULL OR LTRIM(RTRIM(CAST(seller_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN seller_id IS NOT NULL AND LTRIM(RTRIM(CAST(seller_id AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_sellers_dataset
UNION ALL
SELECT
    'olist_sellers_dataset',
    'seller_zip_code_prefix',
    COUNT(*),
    SUM(CASE WHEN seller_zip_code_prefix IS NULL OR LTRIM(RTRIM(CAST(seller_zip_code_prefix AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN seller_zip_code_prefix IS NOT NULL AND LTRIM(RTRIM(CAST(seller_zip_code_prefix AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_sellers_dataset
UNION ALL
SELECT
    'olist_sellers_dataset',
    'seller_city',
    COUNT(*),
    SUM(CASE WHEN seller_city IS NULL OR LTRIM(RTRIM(CAST(seller_city AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN seller_city IS NOT NULL AND LTRIM(RTRIM(CAST(seller_city AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_sellers_dataset
UNION ALL
SELECT
    'olist_sellers_dataset',
    'seller_state',
    COUNT(*),
    SUM(CASE WHEN seller_state IS NULL OR LTRIM(RTRIM(CAST(seller_state AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN seller_state IS NOT NULL AND LTRIM(RTRIM(CAST(seller_state AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.olist_sellers_dataset

UNION ALL

SELECT
    'product_category_name_translation',
    'product_category_name',
    COUNT(*),
    SUM(CASE WHEN product_category_name IS NULL OR LTRIM(RTRIM(CAST(product_category_name AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_category_name IS NOT NULL AND LTRIM(RTRIM(CAST(product_category_name AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.product_category_name_translation
UNION ALL
SELECT
    'product_category_name_translation',
    'product_category_name_english',
    COUNT(*),
    SUM(CASE WHEN product_category_name_english IS NULL OR LTRIM(RTRIM(CAST(product_category_name_english AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN product_category_name_english IS NOT NULL AND LTRIM(RTRIM(CAST(product_category_name_english AS NVARCHAR(4000)))) <> '' THEN 1 ELSE 0 END)
FROM dbo.product_category_name_translation;
GO

SELECT *
FROM dbo.v_data_quality_summary
ORDER BY table_name, column_name;
GO
