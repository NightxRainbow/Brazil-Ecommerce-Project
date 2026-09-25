# Brazil E-commerce Data Quality and Analytics Project

## Executive Summary
This project analyzes the Brazilian e-commerce dataset from Olist and transforms the raw CSV files into a cleaner, more reliable analytical model for business reporting. The main challenge was that the source data contained inconsistent field types, missing values, broken or weak identity relationships, and formatting issues that would affect dashboard quality and decision making.

The solution involved importing the raw data into SQL Server, checking schema and quality issues, standardizing values, cleaning key views, and creating reusable analysis layers for Power BI. The final outcome is a more trustworthy dataset that supports operational and customer analytics, including order performance, customer patterns, seller behavior, and review sentiment.

## Introduction
Brazilian e-commerce datasets often contain messy source data, especially when they are collected from multiple sellers, systems, or operational stages. In this project, the dataset includes customer, order, payment, product, seller, geolocation, and review information.

The project aims to:
- validate the integrity of the imported data
- detect missing or inconsistent values
- standardize text fields and dates
- create cleaned views for downstream analysis
- support reporting and dashboarding in Power BI

The files in this repository show a complete data preparation and analytics workflow, from raw import to quality checks and cleaned business-ready views.

## Data Collection
The dataset used in this project is based on the Olist Brazilian E-commerce Public Dataset, which contains a variety of tables representing the e-commerce lifecycle.

Key datasets included:
- customers
- geolocation
- orders
- order items
- order payments
- order reviews
- products
- sellers
- product category translation

The Python script, `Import_DatatoSql.py`, was used to load the CSV data into SQL Server. The script reads all CSV files in the `Brazil Ecommerce` folder and imports them into a database using SQLAlchemy and pandas.

## Methodology
The methodology followed a structured data quality pipeline:

1. Data import into SQL Server
   - Raw CSV files were loaded into a target database.
   - This created the base tables used for all later quality checks.

2. Schema and data type validation
   - `01_data_type_check.sql` reviews table schemas and data types.
   - This helps identify mismatches or fields that need transformation.

3. Missing value analysis
   - `02_missing_value_check.sql` scans key columns for nulls and empty strings.
   - Missing values were tracked across all main tables.

4. ID relationship validation
   - `03_id_relationship_check.sql` checks whether customer, order, product, and seller IDs are properly linked.
   - This ensures referential integrity across tables.

5. Duplicate and standardization checks
   - `05_duplicates_standardization.sql` normalizes text values and checks for repeated city and category patterns.
   - This reduces inconsistencies in customer and product records.

6. Cleaned analytical views
   - `06_orders_cleaned_view.sql` creates a cleaned order view with fallback timestamps.
   - `07_reviews_cleaned_view.sql` replaces empty review titles and messages with placeholders.
   - These views simplify reporting and dashboard creation.

7. Comparison and validation
   - `09_compare_cleaned_data.sql` compares raw versus cleaned data to confirm the transformation logic.

8. Type adjustment for ordering logic
   - `10_Change_data_type_for_order.sql` changes the monthly order view so dates are more usable in Power BI and reporting tools.

## Data Analysis
The analysis focused on key business questions relevant to e-commerce operations:
- Are there missing values in core customer and order fields?
- Which entities have weak or broken relationships?
- How can customer city and state data be standardized?
- What is the order lifecycle from purchase to delivery?
- How do review comments and sentiment behave across order activity?
- Which fields need cleaning before reporting and dashboard design?

The SQL logic supports a practical analytical model where cleaned views become the base layer for BI. Instead of analyzing raw data directly, the project creates reusable views such as:
- `v_customers_standardized`
- `v_orders_cleaned`
- `v_order_reviews_cleaned`
- `v_cleaned_data_quality_summary`

These views help create a more complete and reliable picture of customer, operational, and service quality performance.

## Findings and Insights
The project reveals several recurring issues common in retail and marketplace data:
- missing or blank values in customer and order fields
- inconsistent formatting in location names and text values
- gaps in order dates such as approval and delivery timestamps
- empty customer review comments that need standard handling
- the need to normalize date-based calculations for business reporting

From an analytical point of view, the key benefit is that these issues are identified before dashboarding. This means the project reduces false conclusions caused by poor data quality and creates a cleaner foundation for reporting and forecasting.

## Recommendations
To improve future analytical reliability, the following steps are recommended:
- enforce required fields during source data ingestion
- standardize city and state values at the source system level
- build automated quality checks into the ETL pipeline
- validate foreign keys and order relationships before publishing to reporting layers
- maintain a documented data dictionary for business users and analysts
- continue using clean SQL views as the reporting layer for Power BI and downstream analytics

## Conclusion
This project demonstrates a strong end-to-end approach to e-commerce data quality management. It starts with raw dataset import and moves through validation, cleaning, standardization, and reporting preparation. The result is a cleaner data foundation that supports deeper business analysis and better decision-making.

The project’s value is not only in the final views, but in the quality methodology used to build them. This makes the dataset much more suitable for dashboards, KPIs, and operational analysis.

## Appendices

### Project Files
- `Import_DatatoSql.py` — loads CSV files into SQL Server
- `01_data_type_check.sql` — checks schema and data types
- `02_missing_value_check.sql` — validates missing values
- `03_id_relationship_check.sql` — validates entity relationships
- `04_data_quality_dashboard.sql` — summarizes quality status
- `05_duplicates_standardization.sql` — handles normalization and duplicate checks
- `06_orders_cleaned_view.sql` — creates cleaned order view
- `07_reviews_cleaned_view.sql` — cleans review text values
- `08_cleaned_data_summary.sql` — summarizes cleaned data quality
- `09_compare_cleaned_data.sql` — compares raw vs cleaned output
- `10_Change_data_type_for_order.sql` — adjusts date logic for reporting

### Dashboard Output
The project also includes a Power BI dashboard file:
- `Brazil Ecommerce Project Power BI.pbix`
- `Brazil Ecommerce Project Power BI.pdf`

### Dashboard Design
![Brazil Ecommerce Project Power BI Design](Brazil%20Ecommerce%20Project%20Power%20BI.jpg)

## References
- Olist Brazilian E-commerce Public Dataset
- Kaggle dataset source for Brazilian marketplace transactions and customer behavior
- SQL Server data quality and view-based reporting practices

---

This project provides a practical example of building a reliable analytical layer from raw e-commerce data using SQL, data validation, and BI-ready transformations.
