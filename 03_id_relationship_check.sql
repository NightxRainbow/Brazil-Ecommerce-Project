USE EcommerceProject_BrazilDataset;
GO

IF OBJECT_ID('dbo.v_id_quality_dashboard', 'V') IS NOT NULL
    DROP VIEW dbo.v_id_quality_dashboard;
GO

CREATE VIEW dbo.v_id_quality_dashboard AS
WITH customer_quality AS (
    SELECT
        c.customer_id AS id_value,
        'customer' AS id_type,
        COUNT(DISTINCT o.order_id) AS related_record_count,
        CASE
            WHEN MAX(CASE WHEN c.customer_unique_id IS NULL OR LTRIM(RTRIM(CAST(c.customer_unique_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN c.customer_city IS NULL OR LTRIM(RTRIM(CAST(c.customer_city AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN c.customer_state IS NULL OR LTRIM(RTRIM(CAST(c.customer_state AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
            THEN 1 ELSE 0 END AS has_missing_value,
        CASE
            WHEN COUNT(DISTINCT o.order_id) = 0 THEN 'no_related_order'
            ELSE 'linked_to_orders'
        END AS match_status,
        CASE
            WHEN MAX(CASE WHEN c.customer_unique_id IS NULL OR LTRIM(RTRIM(CAST(c.customer_unique_id AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'customer_unique_id; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN c.customer_city IS NULL OR LTRIM(RTRIM(CAST(c.customer_city AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'customer_city; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN c.customer_state IS NULL OR LTRIM(RTRIM(CAST(c.customer_state AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'customer_state' ELSE ''
        END AS missing_fields
    FROM dbo.olist_customers_dataset c
    LEFT JOIN dbo.olist_orders_dataset o
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_id
),
order_quality AS (
    SELECT
        o.order_id AS id_value,
        'order' AS id_type,
        COUNT(DISTINCT oi.product_id) + COUNT(DISTINCT op.order_id) + COUNT(DISTINCT r.order_id) AS related_record_count,
        CASE
            WHEN MAX(CASE WHEN o.order_status IS NULL OR LTRIM(RTRIM(CAST(o.order_status AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN o.order_purchase_timestamp IS NULL OR LTRIM(RTRIM(CAST(o.order_purchase_timestamp AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN o.order_approved_at IS NULL OR LTRIM(RTRIM(CAST(o.order_approved_at AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN o.order_delivered_carrier_date IS NULL OR LTRIM(RTRIM(CAST(o.order_delivered_carrier_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN o.order_delivered_customer_date IS NULL OR LTRIM(RTRIM(CAST(o.order_delivered_customer_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN o.order_estimated_delivery_date IS NULL OR LTRIM(RTRIM(CAST(o.order_estimated_delivery_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
            THEN 1 ELSE 0 END AS has_missing_value,
        CASE
            WHEN COUNT(DISTINCT oi.product_id) = 0 AND COUNT(DISTINCT op.order_id) = 0 AND COUNT(DISTINCT r.order_id) = 0 THEN 'no_related_records'
            ELSE 'linked_to_items_payments_reviews'
        END AS match_status,
        CASE
            WHEN MAX(CASE WHEN o.order_status IS NULL OR LTRIM(RTRIM(CAST(o.order_status AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'order_status; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN o.order_purchase_timestamp IS NULL OR LTRIM(RTRIM(CAST(o.order_purchase_timestamp AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'order_purchase_timestamp; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN o.order_approved_at IS NULL OR LTRIM(RTRIM(CAST(o.order_approved_at AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'order_approved_at; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN o.order_delivered_carrier_date IS NULL OR LTRIM(RTRIM(CAST(o.order_delivered_carrier_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'order_delivered_carrier_date; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN o.order_delivered_customer_date IS NULL OR LTRIM(RTRIM(CAST(o.order_delivered_customer_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'order_delivered_customer_date; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN o.order_estimated_delivery_date IS NULL OR LTRIM(RTRIM(CAST(o.order_estimated_delivery_date AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'order_estimated_delivery_date' ELSE ''
        END AS missing_fields
    FROM dbo.olist_orders_dataset o
    LEFT JOIN dbo.olist_order_items_dataset oi
        ON oi.order_id = o.order_id
    LEFT JOIN dbo.olist_order_payments_dataset op
        ON op.order_id = o.order_id
    LEFT JOIN dbo.olist_order_reviews_dataset r
        ON r.order_id = o.order_id
    GROUP BY o.order_id
),
product_quality AS (
    SELECT
        p.product_id AS id_value,
        'product' AS id_type,
        COUNT(DISTINCT oi.order_id) AS related_record_count,
        CASE
            WHEN MAX(CASE WHEN p.product_category_name IS NULL OR LTRIM(RTRIM(CAST(p.product_category_name AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN p.product_name_lenght IS NULL OR LTRIM(RTRIM(CAST(p.product_name_lenght AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN p.product_description_lenght IS NULL OR LTRIM(RTRIM(CAST(p.product_description_lenght AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN p.product_photos_qty IS NULL OR LTRIM(RTRIM(CAST(p.product_photos_qty AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN p.product_weight_g IS NULL OR LTRIM(RTRIM(CAST(p.product_weight_g AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN p.product_length_cm IS NULL OR LTRIM(RTRIM(CAST(p.product_length_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN p.product_height_cm IS NULL OR LTRIM(RTRIM(CAST(p.product_height_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN p.product_width_cm IS NULL OR LTRIM(RTRIM(CAST(p.product_width_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
            THEN 1 ELSE 0 END AS has_missing_value,
        CASE
            WHEN COUNT(DISTINCT oi.order_id) = 0 THEN 'not_used_in_orders'
            ELSE 'linked_to_order_items'
        END AS match_status,
        CASE
            WHEN MAX(CASE WHEN p.product_category_name IS NULL OR LTRIM(RTRIM(CAST(p.product_category_name AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_category_name; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN p.product_name_lenght IS NULL OR LTRIM(RTRIM(CAST(p.product_name_lenght AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_name_lenght; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN p.product_description_lenght IS NULL OR LTRIM(RTRIM(CAST(p.product_description_lenght AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_description_lenght; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN p.product_photos_qty IS NULL OR LTRIM(RTRIM(CAST(p.product_photos_qty AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_photos_qty; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN p.product_weight_g IS NULL OR LTRIM(RTRIM(CAST(p.product_weight_g AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_weight_g; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN p.product_length_cm IS NULL OR LTRIM(RTRIM(CAST(p.product_length_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_length_cm; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN p.product_height_cm IS NULL OR LTRIM(RTRIM(CAST(p.product_height_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_height_cm; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN p.product_width_cm IS NULL OR LTRIM(RTRIM(CAST(p.product_width_cm AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'product_width_cm' ELSE ''
        END AS missing_fields
    FROM dbo.olist_products_dataset p
    LEFT JOIN dbo.olist_order_items_dataset oi
        ON oi.product_id = p.product_id
    GROUP BY p.product_id
),
seller_quality AS (
    SELECT
        s.seller_id AS id_value,
        'seller' AS id_type,
        COUNT(DISTINCT oi.order_id) AS related_record_count,
        CASE
            WHEN MAX(CASE WHEN s.seller_zip_code_prefix IS NULL OR LTRIM(RTRIM(CAST(s.seller_zip_code_prefix AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN s.seller_city IS NULL OR LTRIM(RTRIM(CAST(s.seller_city AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
              OR MAX(CASE WHEN s.seller_state IS NULL OR LTRIM(RTRIM(CAST(s.seller_state AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1
            THEN 1 ELSE 0 END AS has_missing_value,
        CASE
            WHEN COUNT(DISTINCT oi.order_id) = 0 THEN 'not_used_in_orders'
            ELSE 'linked_to_order_items'
        END AS match_status,
        CASE
            WHEN MAX(CASE WHEN s.seller_zip_code_prefix IS NULL OR LTRIM(RTRIM(CAST(s.seller_zip_code_prefix AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'seller_zip_code_prefix; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN s.seller_city IS NULL OR LTRIM(RTRIM(CAST(s.seller_city AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'seller_city; ' ELSE ''
        END +
        CASE
            WHEN MAX(CASE WHEN s.seller_state IS NULL OR LTRIM(RTRIM(CAST(s.seller_state AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END) = 1 THEN 'seller_state' ELSE ''
        END AS missing_fields
    FROM dbo.olist_sellers_dataset s
    LEFT JOIN dbo.olist_order_items_dataset oi
        ON oi.seller_id = s.seller_id
    GROUP BY s.seller_id
)
SELECT
    id_type,
    id_value,
    related_record_count,
    has_missing_value,
    match_status,
    missing_fields
FROM customer_quality
UNION ALL
SELECT
    id_type,
    id_value,
    related_record_count,
    has_missing_value,
    match_status,
    missing_fields
FROM order_quality
UNION ALL
SELECT
    id_type,
    id_value,
    related_record_count,
    has_missing_value,
    match_status,
    missing_fields
FROM product_quality
UNION ALL
SELECT
    id_type,
    id_value,
    related_record_count,
    has_missing_value,
    match_status,
    missing_fields
FROM seller_quality;
GO

SELECT *
FROM dbo.v_id_quality_dashboard
ORDER BY id_type, id_value;
GO
