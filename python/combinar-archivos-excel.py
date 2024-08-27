import pandas as pd

# Cargar los datos del archivo de compras y asignaciones
archivo_clientes = pd.read_excel(
    "/mnt/e/work/nuevas-asignaciones-de-clientes/v2/v3/clientes-totales.xlsx",
    sheet_name="DATOS",
    engine="openpyxl",
    header=None,
    skiprows=1,
)
archivo_asignaciones = pd.read_excel(
    "/mnt/e/work/nuevas-asignaciones-de-clientes/v2/v3/clientes-larissa.xlsx",
    sheet_name="DATOS",
    engine="openpyxl",
    header=None,
    skiprows=2,
)

# Fusionar los datos basados en las columnas A y B
archivo_clientes_con_asignaciones = pd.merge(
    archivo_clientes,
    archivo_asignaciones,
    how="left",
    left_on=archivo_clientes.columns[0],
    right_on=archivo_asignaciones.columns[1],
)

# Obtener la ubicación de la columna 19
columna_19_index = 2

# Insertar las columnas de asignaciones después de la columna 19
archivo_clientes_con_asignaciones = pd.concat(
    [
        archivo_clientes_con_asignaciones.iloc[:, : columna_19_index + 1],
        archivo_clientes_con_asignaciones.iloc[:, -archivo_asignaciones.shape[1] :],
        archivo_clientes_con_asignaciones.iloc[
            :, columna_19_index + 1 : -archivo_asignaciones.shape[1]
        ],
    ],
    axis=1,
)

# Guardar el archivo de compras con las asignaciones agregadas
archivo_clientes_con_asignaciones.to_excel(
    "/mnt/e/work/nuevas-asignaciones-de-clientes/v2/v3/clientes-totales+larissa.xlsx",
    index=False,
)
