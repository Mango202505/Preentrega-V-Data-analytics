USE Ventas_Tech_DB;
GO

-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Proposito: reunir el detalle de ventas con cliente, producto, categoria y ciudad para Power BI.
SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM dbo.ventas AS v
INNER JOIN dbo.clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos AS p ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias AS cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;

-- Hallazgo: las 10 ventas suman 6444.00. Computacion aporta 4950.00,
-- el 76.82% del total, y es la categoria con mayor facturacion.

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Proposito: identificar clientes que nunca compraron para que CRM pueda contactarlos.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM dbo.clientes AS c
LEFT JOIN dbo.ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL
ORDER BY c.fecha_registro, c.id_cliente;

-- Hallazgo: aparecen 0 clientes sin compras; los 5 registrados ya compraron.
-- CRM no tiene clientes pendientes de primera compra en esta muestra.

-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Proposito: detectar articulos sin movimiento para que el area de producto revise su oferta.
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM dbo.productos AS p
LEFT JOIN dbo.ventas AS v ON p.id_producto = v.id_producto
LEFT JOIN dbo.categorias AS cat ON p.id_categoria = cat.id_categoria
WHERE v.id_producto IS NULL
ORDER BY p.id_producto;

-- Hallazgo: aparecen 0 productos sin ventas; los 6 del catalogo tuvieron movimiento.
-- El area de producto no tiene articulos sin ventas para revisar en esta muestra.

-- Consulta 4: Consolidado por canal (UNION ALL)
-- Proposito: comparar lo facturado en dos periodos de marzo de 2024.
SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        '01 al 10 de marzo de 2024' AS canal
    FROM dbo.ventas
    WHERE fecha_venta >= '2024-03-01' AND fecha_venta < '2024-03-11'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        '11 al 31 de marzo de 2024' AS canal
    FROM dbo.ventas
    WHERE fecha_venta >= '2024-03-11' AND fecha_venta < '2024-04-01'
) AS consolidado
GROUP BY canal
ORDER BY canal;

-- Hallazgo: del 1 al 10 de marzo se facturaron 3620.00 y del 11 al 31, 2824.00.
-- El primer periodo concentro el 56.18% del total de marzo.
