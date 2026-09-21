import glob
import os

import pandas as pd
from sqlalchemy import create_engine

# 1. Connect to your SQL Server database
engine = create_engine(
    'mssql+pyodbc://@localhost/EcommerceProject_BrazilDataset?driver=ODBC Driver 17 for SQL Server&Trusted_Connection=yes'
)

# 2. Point to the Kaggle CSV files
folder_path = r'D:\geta jobs\Brazil Ecommerce Project\Brazil Ecommerce\*.csv'
files = sorted(glob.glob(folder_path))

# 3. Load all CSV files into SQL Server using APPEND instead of REPLACE
for file in files:
    table_name = os.path.splitext(os.path.basename(file))[0]
    table_name = table_name.replace('-', '_')

    df = pd.read_csv(file)

    # if_exists='append' adds rows to an existing table.
    # If the table doesn't exist yet, SQLAlchemy will create it automatically.
    df.to_sql(table_name, con=engine, if_exists='append', index=False, chunksize=500)

    print(f"Imported: {table_name} ({len(df)} rows)")

print("All CSV files were imported successfully.")