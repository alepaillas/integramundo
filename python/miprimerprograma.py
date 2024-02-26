# para trabajar con excel en python usando pandas debemos instalar:
# openpyxl xlrd pandas

import pandas as pd

# Lee el archivo Excel
Excel1 = pd.read_excel(r"E:\work\integramundo\python\ordenes-compra2.xlsx", engine="openpyxl", header=None, skiprows=6)
#print(Excel1)

# borramos "[ y ]" de los datos de la columna 19
Excel1.iloc[:, 18] = Excel1.iloc[:, 18].str.replace(r'^\["|"\]$', '', regex=True)

# Convertimos las columnas 3 y 18 a objetos de fecha
Excel1.iloc[:, 3] = pd.to_datetime(Excel1.iloc[:, 3], format='%d-%m-%Y', errors='coerce')
Excel1.iloc[:, 18] = pd.to_datetime(Excel1.iloc[:, 18], format='%d-%m-%Y', errors='coerce')
Excel1.iloc[:, 9] = pd.to_datetime(Excel1.iloc[:, 9], format='%d-%m-%Y', errors='coerce')

# restamos las columnas y guardamos en una nueva
Excel1.iloc[:,9] = Excel1.iloc[:,18] - Excel1.iloc[:,3]

# Guarda el DataFrame modificado en un nuevo archivo Excel
Excel1.to_excel('compras1.xlsx', index=False)