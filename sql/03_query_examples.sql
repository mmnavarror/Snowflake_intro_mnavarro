-- ------------------------------------------------------------
-- 03_query_examples.sql
-- Consultas y vistas analíticas sobre la base MNR_DB.DEMO_SCHEMA.PRODUCTOS
-- ------------------------------------------------------------

-- 1) Contexto
USE DATABASE MNR_DB;
USE SCHEMA DEMO_SCHEMA;

-- 2) Verificación de datos base
SELECT COUNT(*) AS total_registros FROM PRODUCTOS;
SELECT * FROM PRODUCTOS LIMIT 10;

-- 3) Vista principal de productos en oferta
CREATE OR REPLACE VIEW VW_PRODUCTOS_EN_OFERTA AS
SELECT 
  NOMBRE, 
  MARCA, 
  MODELO, 
  GENERO, 
  TALLA,
  PRECIO_VENTA,
  PRECIO_OFERTA,
  (PRECIO_VENTA - PRECIO_OFERTA) AS DESCUENTO,
  ROUND((PRECIO_VENTA - PRECIO_OFERTA) / NULLIF(PRECIO_VENTA,0) * 100, 1) AS DESCUENTO_PCT,
  STOCK,
  CREADO_EN
FROM PRODUCTOS
WHERE PRECIO_OFERTA > 0;

-- 4) Consultas de análisis

-- 4.1 Productos con mayor descuento
SELECT *
FROM VW_PRODUCTOS_EN_OFERTA
ORDER BY DESCUENTO_PCT DESC
LIMIT 10;

-- 4.2 Promedio de descuento general
SELECT 
  ROUND(AVG(DESCUENTO_PCT), 2) AS promedio_descuento
FROM VW_PRODUCTOS_EN_OFERTA;

-- 4.3 Promedio de precios por marca
SELECT 
  MARCA,
  ROUND(AVG(PRECIO_VENTA), 0) AS promedio_venta,
  ROUND(AVG(PRECIO_OFERTA), 0) AS promedio_oferta
FROM PRODUCTOS
GROUP BY MARCA
ORDER BY promedio_venta DESC;

-- 4.4 Total valorizado del stock actual
SELECT 
  SUM(STOCK * PRECIO_VENTA) AS total_valor_inventario,
  SUM(STOCK * PRECIO_OFERTA) AS total_valor_ofertas
FROM PRODUCTOS;

-- 4.5 Conteo de productos por rango de precios
SELECT 
  CASE 
    WHEN PRECIO_VENTA < 10000 THEN 'Bajo (hasta 10 mil)'
    WHEN PRECIO_VENTA BETWEEN 10000 AND 25000 THEN 'Medio (10 a 25 mil)'
    WHEN PRECIO_VENTA BETWEEN 25001 AND 40000 THEN 'Alto (25 a 40 mil)'
    ELSE 'Premium (más de 40 mil)'
  END AS rango_precio,
  COUNT(*) AS cantidad
FROM PRODUCTOS
GROUP BY 1
ORDER BY cantidad DESC;

-- 4.6 Conteo por género (si aplica)
SELECT GENERO, COUNT(*) AS cantidad
FROM PRODUCTOS
GROUP BY GENERO;

-- 5) Reporte final combinado
SELECT 
  P.NOMBRE,
  P.MARCA,
  P.MODELO,
  P.TALLA,
  P.PRECIO_VENTA,
  P.PRECIO_OFERTA,
  ROUND((P.PRECIO_VENTA - P.PRECIO_OFERTA) / NULLIF(P.PRECIO_VENTA,0) * 100, 1) AS DESCUENTO_PCT,
  P.STOCK,
  CASE 
    WHEN P.PRECIO_OFERTA = 0 THEN 'Sin oferta'
    ELSE 'En promoción'
  END AS ESTADO
FROM PRODUCTOS P
ORDER BY DESCUENTO_PCT DESC, P.MARCA;
