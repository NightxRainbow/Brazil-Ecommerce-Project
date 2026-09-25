ALTER VIEW dbo.v_orders_cleaned AS
SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    
    -- Returns an actual DATE (e.g., 2018-09-01) instead of text
    DATEFROMPARTS(
        YEAR(CAST(order_purchase_timestamp AS datetime)), 
        MONTH(CAST(order_purchase_timestamp AS datetime)), 
        1
    ) AS month_year,
    
    -- You can drop month_year_sort if you want, as Power BI sorts true dates automatically
    YEAR(CAST(order_purchase_timestamp AS datetime)) * 100 
        + MONTH(CAST(order_purchase_timestamp AS datetime)) AS month_year_sort,
        
    order_estimated_delivery_date,
    COALESCE(order_approved_at, order_purchase_timestamp) AS optimize_approval_times,
    COALESCE(order_delivered_carrier_date, order_estimated_delivery_date, order_purchase_timestamp) AS optimize_delivered_carrier_date,
    COALESCE(order_delivered_customer_date, order_delivered_carrier_date, order_estimated_delivery_date, order_purchase_timestamp) AS optimize_delivered_customer_date
FROM dbo.olist_orders_dataset;
GO

select * from dbo.v_orders_cleaned