import pandas as pd
import numpy as np

# Read the data from Excel
df = pd.read_excel("datos-cliengo-ventas.xlsx", header=None)

# Initialize lists to store separate columns
nombre_list = []
whatsapp_list = []
mensaje_list = []

# Iterate through each row in the dataframe
for index, row in df.iterrows():
    # Check if the row contains a valid string value
    if isinstance(row[0], str):
        # Check if the row contains information for all three columns
        if "Nombre:" in row[0]:
            nombre_list.append(row[0].split("Nombre:")[1].strip())
        elif "Whatsapp:" in row[0]:
            whatsapp_list.append(row[0].split("Whatsapp:")[1].strip())
        elif "Mensaje:" in row[0]:
            mensaje_list.append(row[0].split("Mensaje:")[1].strip())

# Create a new dataframe with separate columns
new_df = pd.DataFrame({
    "Nombre": nombre_list,
    "Whatsapp": whatsapp_list,
    "Mensaje": mensaje_list
})

# Save the dataframe to a new Excel file
new_df.to_excel("output2.xlsx", index=False)
