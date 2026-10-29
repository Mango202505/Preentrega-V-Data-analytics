# Preentrega 3 - TechStore

El archivo `modulo_3/ventas_tech_db.sql` crea la base `Ventas_Tech_DB`, sus cuatro tablas y los 25 registros de prueba de la consigna. No hace falta adjuntar una base de datos ni importar un CSV o un Excel.

## Ejecucion

1. Abrir el archivo en SQL Server Management Studio y conectarse a SQL Server 2016 o posterior.
2. Ejecutar el script completo con un usuario que tenga permisos para crear la base y las tablas.
3. Revisar los cuatro resultados finales: 4 categorias, 5 clientes, 6 productos y 10 ventas.
4. Ejecutar el script completo una segunda vez y comprobar que devuelve los mismos resultados sin errores.

**Atencion:** cada ejecucion elimina y vuelve a crear las tablas `ventas`, `productos`, `clientes` y `categorias` dentro de `Ventas_Tech_DB`. Usar esta base solo para la practica.

## Estructura

El script esta separado en DROP, CREATE, INSERT y VALIDACION. Cada producto referencia una categoria y cada venta referencia un cliente y un producto. Los precios usan `DECIMAL(10,2)` y las fechas usan `DATE`.

