-- Productos en oferta
SELECT nombre, precio_venta, precio_oferta,
       ROUND((precio_venta - precio_oferta) / precio_venta * 100, 2) AS descuento_pct
FROM productos
WHERE precio_oferta > 0
ORDER BY descuento_pct DESC;

-- Productos sin oferta
SELECT nombre, precio_venta
FROM productos
WHERE precio_oferta = 0;

-- Promedio de descuento
SELECT AVG(precio_venta - precio_oferta) AS descuento_promedio
FROM productos
WHERE precio_oferta > 0;



