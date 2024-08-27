# Para trabajar con excel en python debemos instalar:
# - pandas
# - openpyxl

import pandas as pd

# Lee el archivo Excel
ExcelFile = pd.read_excel(
    r"/mnt/e/work/nuevas-asignaciones-de-clientes/v2/clients-table.xlsx",
    engine="openpyxl",
    header=None,
    skiprows=1,
)
# print(ExcelFile)

# Access the third sheet (0-based indexing)
sheet_data = ExcelFile.iloc[2:]  # Get all rows from the third sheet onwards

# Convert the column to date
sheet_data.iloc[:, 7] = pd.to_datetime(
    sheet_data.iloc[:, 7], format="%d-%m-%Y", errors="coerce"
)

# Guarda el DataFrame modificado en un nuevo archivo Excel
sheet_data.to_excel(
    "/mnt/e/work/nuevas-asignaciones-de-clientes/v2/clients-table-python.xlsx",
    index=False,
)
