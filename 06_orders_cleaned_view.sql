USE EcommerceProject_BrazilDataset;
GO

-- =====================================================
-- Orders cleaned view: adds optimize_approval_times using COALESCE
-- This provides a fallback approval timestamp when order_approved_at is missing
-- =====================================================
IF OBJECT_ID('dbo.v_orders_cleaned', 'V') IS NOT NULL
    DROP VIEW dbo.v_orders_cleaned;
GO

CREATE VIEW dbo.v_orders_cleaned AS
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    FORMAT(CAST(order_purchase_timestamp AS datetime), 'MMMM yyyy') AS month_year,
    YEAR(CAST(order_purchase_timestamp AS datetime)) * 100 
        + MONTH(CAST(order_purchase_timestamp AS datetime)) AS month_year_sort,
    order_estimated_delivery_date,
    -- optimized approval time: prefer approved timestamp, otherwise use purchase timestamp
    COALESCE(order_approved_at, order_purchase_timestamp) AS optimize_approval_times,
    -- optimized carrier delivery date: prefer actual carrier date, then estimated delivery, then purchase timestamp
    COALESCE(order_delivered_carrier_date, order_estimated_delivery_date, order_purchase_timestamp) AS optimize_delivered_carrier_date,
    -- optimized customer delivery date: prefer actual customer delivery date, then carrier date, then estimated, then purchase
    COALESCE(order_delivered_customer_date, order_delivered_carrier_date, order_estimated_delivery_date, order_purchase_timestamp) AS optimize_delivered_customer_date
FROM dbo.olist_orders_dataset;
GO

-- Quick preview
SELECT TOP 200 *
FROM dbo.v_orders_cleaned
ORDER BY order_purchase_timestamp DESC;
GO
