USE EcommerceProject_BrazilDataset;
GO

SELECT
    dt.table_name,
    dt.column_name,
    dt.data_type,
    dq.total_rows,
    dq.missing_value_count,
    dq.valid_value_count,
    CAST(100.0 * dq.missing_value_count / NULLIF(dq.total_rows, 0) AS DECIMAL(10,2)) AS missing_percent,
    CASE
        WHEN dq.missing_value_count > 0 THEN 'needs_review'
        ELSE 'clean'
    END AS quality_status
FROM dbo.v_table_data_types dt
LEFT JOIN dbo.v_data_quality_summary dq
    ON dq.table_name = dt.table_name
   AND dq.column_name = dt.column_name
ORDER BY dt.table_name, dt.column_id;
GO

SELECT *
FROM dbo.v_id_quality_dashboard
ORDER BY id_type, id_value;
GO
