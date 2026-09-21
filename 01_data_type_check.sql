USE EcommerceProject_BrazilDataset;
GO

IF OBJECT_ID('dbo.v_table_data_types', 'V') IS NOT NULL
    DROP VIEW dbo.v_table_data_types;
GO

CREATE VIEW dbo.v_table_data_types AS
SELECT
    t.name AS table_name,
    c.column_id,
    c.name AS column_name,
    ty.name AS data_type,
    c.max_length,
    c.precision,
    c.scale,
    c.is_nullable
FROM sys.tables AS t
INNER JOIN sys.columns AS c
    ON c.object_id = t.object_id
INNER JOIN sys.types AS ty
    ON ty.user_type_id = c.user_type_id
WHERE t.schema_id = SCHEMA_ID('dbo');
GO

SELECT *
FROM dbo.v_table_data_types
ORDER BY table_name, column_id;
GO
