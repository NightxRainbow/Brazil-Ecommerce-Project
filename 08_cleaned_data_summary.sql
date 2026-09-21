USE EcommerceProject_BrazilDataset;
GO

-- =====================================================
-- Cleaned data quality summary view
-- Shows total rows and missing counts for cleaned views/tables
-- =====================================================
IF OBJECT_ID('dbo.v_cleaned_data_quality_summary','V') IS NOT NULL
    DROP VIEW dbo.v_cleaned_data_quality_summary;
GO

CREATE VIEW dbo.v_cleaned_data_quality_summary AS

-- Customers (standardized view)
SELECT
    'v_customers_standardized' AS table_name,
    'customer_id' AS column_name,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_count
FROM dbo.v_customers_standardized
UNION ALL
SELECT 'v_customers_standardized','customer_unique_id',COUNT(*),SUM(CASE WHEN customer_unique_id IS NULL OR LTRIM(RTRIM(customer_unique_id)) = '' THEN 1 ELSE 0 END)
FROM dbo.v_customers_standardized
UNION ALL
SELECT 'v_customers_standardized','customer_zip_code_prefix',COUNT(*),SUM(CASE WHEN customer_zip_code_prefix IS NULL OR LTRIM(RTRIM(CAST(customer_zip_code_prefix AS NVARCHAR(4000)))) = '' THEN 1 ELSE 0 END)
FROM dbo.v_customers_standardized
UNION ALL
SELECT 'v_customers_standardized','customer_city_std',COUNT(*),SUM(CASE WHEN customer_city_std IS NULL OR LTRIM(RTRIM(customer_city_std)) = '' THEN 1 ELSE 0 END)
FROM dbo.v_customers_standardized
UNION ALL
SELECT 'v_customers_standardized','customer_state_std',COUNT(*),SUM(CASE WHEN customer_state_std IS NULL OR LTRIM(RTRIM(customer_state_std)) = '' THEN 1 ELSE 0 END)
FROM dbo.v_customers_standardized

UNION ALL

-- Orders (cleaned view)
SELECT 'v_orders_cleaned','order_id',COUNT(*),SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_orders_cleaned
UNION ALL
SELECT 'v_orders_cleaned','customer_id',COUNT(*),SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_orders_cleaned
UNION ALL
SELECT 'v_orders_cleaned','order_purchase_timestamp',COUNT(*),SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_orders_cleaned
UNION ALL
SELECT 'v_orders_cleaned','optimize_approval_times',COUNT(*),SUM(CASE WHEN optimize_approval_times IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_orders_cleaned
UNION ALL
SELECT 'v_orders_cleaned','optimize_delivered_carrier_date',COUNT(*),SUM(CASE WHEN optimize_delivered_carrier_date IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_orders_cleaned
UNION ALL
SELECT 'v_orders_cleaned','optimize_delivered_customer_date',COUNT(*),SUM(CASE WHEN optimize_delivered_customer_date IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_orders_cleaned
UNION ALL

-- Reviews (cleaned view)
SELECT 'v_order_reviews_cleaned','review_id',COUNT(*),SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_order_reviews_cleaned
UNION ALL
SELECT 'v_order_reviews_cleaned','order_id',COUNT(*),SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_order_reviews_cleaned
UNION ALL
SELECT 'v_order_reviews_cleaned','review_score',COUNT(*),SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END)
FROM dbo.v_order_reviews_cleaned
UNION ALL
SELECT 'v_order_reviews_cleaned','review_comment_title_clean',COUNT(*),SUM(CASE WHEN review_comment_title_clean IS NULL OR LTRIM(RTRIM(review_comment_title_clean)) = '' THEN 1 ELSE 0 END)
FROM dbo.v_order_reviews_cleaned
UNION ALL
SELECT 'v_order_reviews_cleaned','review_comment_message_clean',COUNT(*),SUM(CASE WHEN review_comment_message_clean IS NULL OR LTRIM(RTRIM(review_comment_message_clean)) = '' THEN 1 ELSE 0 END)
FROM dbo.v_order_reviews_cleaned
;
GO

-- Preview cleaned rows (top 50 per view)
SELECT TOP 50 * FROM dbo.v_customers_standardized ORDER BY customer_id;
SELECT TOP 50 * FROM dbo.v_orders_cleaned ORDER BY order_purchase_timestamp DESC;
SELECT TOP 50 * FROM dbo.v_order_reviews_cleaned ORDER BY review_creation_date DESC;
GO
