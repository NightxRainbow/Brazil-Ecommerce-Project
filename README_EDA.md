# Exploratory Data Analysis (EDA) and Solution Overview

## Executive Summary
This project was designed to solve a common business problem in e-commerce analytics: raw transactional data is often incomplete, inconsistent, and difficult to trust for reporting. The Brazilian e-commerce data from Olist contains customer, order, payment, product, seller, and review information, but many fields needed cleaning before they could be used for analysis.

The EDA process focused on understanding the raw dataset, identifying data quality issues, and transforming the data into a reliable analytical layer. The final solution included SQL-based validation, standardization, and cleaned views, which were then used for reporting and dashboarding.

## Problem Statement
The challenge in this project was not only to import the e-commerce data, but also to make it suitable for business analysis. Several problems were identified in the raw data:
- missing or blank values in important columns
- inconsistent text formatting in city and state fields
- weak or unclear identity relationships across tables
- inconsistent timestamps and dates for order lifecycle events
- review comments that were missing or empty
- incorrect or unusable field types for reporting purposes

These problems could distort key metrics such as delivery performance, customer quality, seller performance, and product analysis if not corrected.

## Exploratory Data Analysis Approach
The EDA process followed a structured workflow:

1. Import and inspect raw CSV files
   - Data was imported from the `Brazil Ecommerce` folder into SQL Server.
   - The import step created the base tables needed for profiling and analysis.

2. Profile the schema and data types
   - We reviewed the fields to understand their structure and identify mismatches.
   - This helped determine which columns needed type conversion or cleaning.

3. Check missing values
   - Analysis focused on nulls and blank strings across important fields.
   - This helped identify which columns needed default values or filtering.

4. Check key relationships
   - The project validated relationships between customers, orders, products, and sellers.
   - Missing or broken links were flagged as part of the data quality review.

5. Standardize and normalize fields
   - Names, cities, and states were normalized for consistency.
   - Duplicate patterns and repeated values were identified.

6. Clean order and review data
   - Order lifecycle dates were optimized using fallback logic.
   - Empty review titles and messages were replaced with a standard placeholder.

7. Build cleaned reporting views
   - Clean output was organized into business-friendly views for downstream analysis and dashboarding.

## EDA Findings
From the project’s SQL-based analytical workflow, the following findings were confirmed:

- Customer records could have inconsistent city and state formatting.
- Some order date fields were missing or incomplete, which affects lifecycle analysis.
- Review comments were sometimes empty, reducing textual analysis quality.
- Product and seller records needed standardization for better segmentation analysis.
- Data-type issues were present in fields used for report filters and time-based calculations.

These findings highlight the importance of data-quality checks before any dashboard or KPI creation.

## Analytical Questions Addressed
This EDA and transformation workflow supports answers to important business questions such as:
- Which customer states and cities appear most often?
- How long does it take from purchase to delivery?
- Which orders are missing approval or delivery timestamps?
- Are order IDs and customer IDs properly linked?
- Which reviews are incomplete or missing text?
- Which fields require standardization before reporting?

## Solution to the Problem
The solution was built around a quality-first data preparation approach.

### 1. SQL quality checks
The project created separate SQL scripts for:
- data type validation
- missing value detection
- ID relationship quality checks
- quality dashboarding
- duplicate and standardization logic

These checks help isolate data issues early and provide visibility into areas requiring cleanup.

### 2. Data standardization
The project used text normalization logic to standardize fields like city and state names. This reduces errors caused by case differences, extra spaces, and inconsistent naming.

### 3. Cleaned business views
The project created reporting-ready views, including:
- `v_customers_standardized`
- `v_orders_cleaned`
- `v_order_reviews_cleaned`
- `v_cleaned_data_quality_summary`

These views make it easier to analyze the dataset without repeatedly revisiting raw inconsistencies.

### 4. Date and reporting optimization
The order views used `COALESCE` and date conversion logic so missing values could be handled gracefully. This allowed the project to create a more useful order lifecycle summary for Power BI and decision-making reports.

### 5. Power BI integration
The project also includes a Power BI dashboard file, which demonstrates how the cleaned data can be used for visual analysis and executive reporting.

## Final Outcome
The final solution transforms raw Olist data into a reliable analytics foundation that supports business intelligence and operational reporting. Instead of relying on inconsistent raw tables, the project creates a cleaned, validated, and standardized data layer that is ready for reporting.

This approach solves the core problem: poor-quality source data is cleaned and structured before analysis, enabling much better decision-making.

## Key Takeaways
- Data quality checks are essential before building dashboards.
- Standardization reduces noise and improves reporting accuracy.
- Cleaned SQL views are a practical way to prepare data for analytics.
- Power BI becomes far more useful when the source tables are well validated.
- EDA should not only describe data — it should also lead to a trusted solution.

## Appendix
Relevant project files for the EDA and solution include:
- `01_data_type_check.sql`
- `02_missing_value_check.sql`
- `03_id_relationship_check.sql`
- `04_data_quality_dashboard.sql`
- `05_duplicates_standardization.sql`
- `06_orders_cleaned_view.sql`
- `07_reviews_cleaned_view.sql`
- `08_cleaned_data_summary.sql`
- `09_compare_cleaned_data.sql`
- `10_Change_data_type_for_order.sql`
- `Import_DatatoSql.py`

This README provides a practical summary of the exploratory analysis and the solution that addresses the data-quality problem in the project.
