USE EcommerceProject_BrazilDataset;
GO

-- =====================================================
-- Order reviews cleaned view: fill missing review title/message with placeholder
-- =====================================================
IF OBJECT_ID('dbo.v_order_reviews_cleaned', 'V') IS NOT NULL
    DROP VIEW dbo.v_order_reviews_cleaned;
GO

CREATE VIEW dbo.v_order_reviews_cleaned AS
SELECT
    review_id,
    order_id,
    review_score,
    -- Treat empty string as missing too
    CASE WHEN review_comment_title IS NULL OR LTRIM(RTRIM(review_comment_title)) = '' THEN 'no comment provided' ELSE review_comment_title END AS review_comment_title_clean,
    CASE WHEN review_comment_message IS NULL OR LTRIM(RTRIM(review_comment_message)) = '' THEN 'no comment provided' ELSE review_comment_message END AS review_comment_message_clean,
    review_creation_date,
    review_answer_timestamp
FROM dbo.olist_order_reviews_dataset;
GO

-- Quick preview
SELECT TOP 200 *
FROM dbo.v_order_reviews_cleaned
ORDER BY review_creation_date DESC;
GO
