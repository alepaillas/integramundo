import pandas as pd

# Cargar los archivos Excel en dataframes
df_clientes = pd.read_excel(
    "/mnt/e/work/nuevas-asignaciones-de-clientes/v2/v3/clientes-totales.xlsx",
    sheet_name="DATOS",
    engine="openpyxl",
    header=None,
    skiprows=1,
)
df_comerciales = pd.read_excel(
    "/mnt/e/work/nuevas-asignaciones-de-clientes/v2/v3/clientes-nicolas.xlsx",
    sheet_name="DATOS",
    engine="openpyxl",
    header=None,
    skiprows=2,
)

# Obtener los nombres de cliente de cada dataframe
nombres_clientes_clientes = df_clientes.iloc[:, 0].tolist()
nombres_clientes_comerciales = df_comerciales.iloc[:, 1].tolist()

# Buscar la posición de los nombres de cliente en el dataframe de clientes en el dataframe de comerciales
posiciones = [
    nombres_clientes_comerciales.index(nombre) for nombre in nombres_clientes_clientes
]

# Seleccionar las filas correspondientes en el dataframe de comerciales
filas_seleccionadas = df_comerciales.iloc[posiciones, :]

# Concatenar los dataframes seleccionados con el dataframe de clientes
df_combinado = pd.concat(
    [df_clientes.reset_index(drop=True), filas_seleccionadas.reset_index(drop=True)],
    axis=1,
)

# Guardar el dataframe combinado en un nuevo archivo Excel
df_combinado.to_excel(
    "/mnt/e/work/nuevas-asignaciones-de-clientes/v2/v3/clientes-totales+nicolas.xlsx",
    index=False,
)
