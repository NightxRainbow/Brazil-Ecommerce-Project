USE EcommerceProject_BrazilDataset;
GO

-- =====================================================
-- Utility: standardize text (normalize spaces & underscores, title case)
-- =====================================================
IF OBJECT_ID('dbo.fn_StandardizeText', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_StandardizeText;
GO

CREATE FUNCTION dbo.fn_StandardizeText(@s NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    IF @s IS NULL RETURN NULL;
    DECLARE @t NVARCHAR(MAX) = LTRIM(RTRIM(@s));
    SET @t = REPLACE(@t, '_', ' ');
    -- collapse multiple spaces
    WHILE CHARINDEX('  ', @t) > 0
        SET @t = REPLACE(@t, '  ', ' ');
    SET @t = LOWER(@t);

    DECLARE @i INT = 1;
    DECLARE @len INT = LEN(@t);
    DECLARE @out NVARCHAR(MAX) = N'';
    DECLARE @prev NCHAR(1) = ' ';
    WHILE @i <= @len
    BEGIN
        DECLARE @ch NCHAR(1) = SUBSTRING(@t, @i, 1);
        IF @prev = ' ' OR @i = 1
            SET @out = @out + UPPER(@ch);
        ELSE
            SET @out = @out + @ch;
        SET @prev = @ch;
        SET @i = @i + 1;
    END
    RETURN @out;
END
GO

-- =====================================================
-- Create standardized customer view only 
-- =====================================================

IF OBJECT_ID('dbo.v_customers_standardized', 'V') IS NOT NULL
    DROP VIEW dbo.v_customers_standardized;
GO
CREATE VIEW dbo.v_customers_standardized AS
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    dbo.fn_StandardizeText(customer_city) AS customer_city_std,
    dbo.fn_StandardizeText(customer_state) AS customer_state_std
FROM dbo.olist_customers_dataset;
GO

-- =====================================================
-- Create standardized products view
-- Fill missing category values with 'outros' and numeric values with 0
-- =====================================================
IF OBJECT_ID('dbo.v__products_standarized', 'V') IS NOT NULL
    DROP VIEW dbo.v__products_standarized;
GO

CREATE VIEW dbo.v__products_standarized AS
SELECT
    product_id,
    COALESCE(NULLIF(LTRIM(RTRIM(product_category_name)), ''), 'outros') AS product_category_name,
    COALESCE(product_name_lenght, 0) AS product_name_lenght,
    COALESCE(product_description_lenght, 0) AS product_description_lenght,
    COALESCE(product_photos_qty, 0) AS product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM dbo.olist_products_dataset;
GO

-- =====================================================
-- Duplicate detection queries (customers only)
-- These return normalized values that appear more than once in customers
-- =====================================================

-- Customers: duplicated cities (normalized)
SELECT TOP 100
    dbo.fn_StandardizeText(customer_city) AS normalized_city,
    COUNT(*) AS occurrences
FROM dbo.olist_customers_dataset
WHERE COALESCE(customer_city,'') <> ''
GROUP BY dbo.fn_StandardizeText(customer_city)
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;
GO
