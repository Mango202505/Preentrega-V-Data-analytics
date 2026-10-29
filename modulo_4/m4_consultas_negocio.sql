USE Ventas_Tech_DB;
GO

-- Consulta 1: Resumen ejecutivo mensual
SELECT
    YEAR(fecha_venta) AS anio,
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    CAST(AVG(cantidad * precio_unitario) AS DECIMAL(18,2)) AS ticket_promedio
FROM dbo.ventas
GROUP BY YEAR(fecha_venta), MONTH(fecha_venta)
ORDER BY anio, mes;

-- Consulta 2: Ranking de productos (Top 5)
SELECT TOP (5)
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM dbo.ventas
GROUP BY id_producto
ORDER BY total_facturado DESC, id_producto;

-- Consulta 3: Clientes recurrentes
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM dbo.ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC, id_cliente;

-- Consulta 4: Productos por encima o debajo del promedio
WITH totales_por_producto AS (
    SELECT
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM dbo.ventas
    GROUP BY id_producto
)
SELECT
    id_producto,
    total_facturado,
    CASE
        WHEN total_facturado > (SELECT AVG(total_facturado) FROM totales_por_producto)
            THEN 'Por encima'
        WHEN total_facturado < (SELECT AVG(total_facturado) FROM totales_por_producto)
            THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS comparacion_promedio
FROM totales_por_producto
ORDER BY total_facturado DESC, id_producto;

-- Hallazgos
-- 1. En marzo de 2024 se facturaron 6444.00 en 10 pedidos, con un ticket
--    promedio de 644.40. No hay otros meses cargados para comparar la evolucion.
-- 2. El producto 1 facturo 3600.00, el 55.87% del total. Los productos 1 y 3
--    superaron el promedio de 1074.00 por producto. El producto 2 lidero en
--    unidades (13), pero su facturacion fue de 364.00.
-- 3. Los cinco clientes hicieron dos pedidos cada uno. El cliente 1 fue el
--    que mas gasto (2640.00), seguido del cliente 5 (2100.00).
