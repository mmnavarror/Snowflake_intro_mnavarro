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

