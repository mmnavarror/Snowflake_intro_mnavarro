import snowflake.connector

# 🔐 Configura tus credenciales aquí
conn = snowflake.connector.connect(
    user='MARGARITA',
    password='TU_PASSWORD',
    account='xy12345.us-east-1',  # reemplaza con el tuyo
    warehouse='COMPUTE_WH',
    database='MNR_DB',
    schema='DEMO_SCHEMA'
)

cur = conn.cursor()
cur.execute("SELECT CURRENT_VERSION()")
print("Conexión exitosa a Snowflake. Versión:", cur.fetchone())

cur.close()
conn.close()
