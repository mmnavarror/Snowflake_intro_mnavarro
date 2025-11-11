USE DATABASE mnr_db;
CREATE SCHEMA IF NOT EXISTS demo_schema;
USE SCHEMA demo_schema;

CREATE OR REPLACE TABLE productos (
  id INT,
  nombre STRING,
  marca STRING,
  modelo STRING,
  genero STRING,
  talla STRING,
  caracteristicas STRING,
  historia STRING,
  stock float,
  precio_venta FLOAT,
  precio_oferta FLOAT
);

-- VISTA
CREATE OR REPLACE VIEW vw_productos_en_oferta AS
SELECT nombre, marca, modelo, talla,
       precio_venta, precio_oferta,
       (precio_venta - precio_oferta) AS descuento,
       ROUND((precio_venta - precio_oferta) / precio_venta * 100, 1) AS descuento_pct
FROM productos
WHERE precio_oferta > 0;

