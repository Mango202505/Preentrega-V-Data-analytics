# RetailPro - Data Analytics

Proyecto de Elian Callejas para analizar ventas de tecnología y preparar un reporte comercial en Power BI. Incluye el esquema SQL, consultas de negocio, limpieza con Power Query y un modelo con relaciones y medidas DAX. El dashboard final sigue en desarrollo.

## Herramientas

- SQL Server 2016 o posterior y SQL Server Management Studio (SSMS).
- Power BI Desktop, Power Query (lenguaje M) y DAX.

## Archivos del repositorio

| Módulo | Archivo | Contenido |
| --- | --- | --- |
| 3 | [ventas_tech_db.sql](modulo_3/ventas_tech_db.sql) | Crea `Ventas_Tech_DB`, sus tablas y los datos de prueba. |
| 4 | [m4_consultas_negocio.sql](modulo_4/m4_consultas_negocio.sql) | Resumen mensual, Top 5, clientes recurrentes y comparación de productos. |
| 5 | [m5_consultas_joins.sql](modulo_5/m5_consultas_joins.sql) | Vista de ventas con nombres, clientes y productos sin ventas, y consolidado por períodos. |
| 6 | [Pipeline_ETL_Callejas_Elian.pbix](modulo_6/Pipeline_ETL_Callejas_Elian.pbix) | Pipeline de limpieza del Excel provisto por el curso. |
| 8 | [Callejas_Elian_Checkpoint2.pbix](modulo_8/Callejas_Elian_Checkpoint2.pbix) | Relaciones activas, calendario, cinco medidas DAX y matriz de validación. |

## Cómo ejecutar los scripts SQL

Necesitás una instancia de SQL Server y una conexión desde SSMS. El usuario debe tener permisos para crear la base y las tablas. No hace falta importar CSV, Excel ni adjuntar una base de datos para estos tres módulos.

**Cada ejecución del script de M3 elimina y vuelve a crear las cuatro tablas de `Ventas_Tech_DB`. Usalo únicamente en la base de práctica.**

1. Abrí `modulo_3/ventas_tech_db.sql` en SSMS y ejecutá el archivo completo con F5, sin dejar un fragmento seleccionado. El script crea la base si no existe y selecciona `Ventas_Tech_DB`.
2. Revisá las cuatro consultas finales: deben devolver 4 categorías, 5 clientes, 6 productos y 10 ventas. Son 25 registros entre todas las tablas.
3. Abrí y ejecutá `modulo_4/m4_consultas_negocio.sql` para obtener las métricas comerciales.
4. Abrí y ejecutá `modulo_5/m5_consultas_joins.sql` para consultar el detalle enriquecido y las ventas por períodos.

Para reiniciar la práctica se puede volver a ejecutar M3; se reemplazan los datos anteriores. Después, volvé a ejecutar M4 y M5.

### Valores de control de SQL

Las 10 ventas corresponden a marzo de 2024: total facturado de **6.444,00** y promedio por registro de **644,40**. La vista con INNER JOIN de M5 devuelve 10 filas y el mismo importe. El producto 1 factura 3.600,00. El Top 5 suma 6.084,00; los 360,00 restantes corresponden al producto 4.

## Power BI y origen de los datos

**M6 y M8 usan `Pipeline_ETL_Dataset.xlsx`, provisto por el curso. Es un conjunto distinto de las 10 ventas del ejercicio SQL.** El Excel no está incluido en este repositorio.

Después de limpiar el Excel quedan 11 clientes, 12 productos, 4 categorías y 50 ventas. El total de ese conjunto es 47.578,00, con fechas de venta entre enero de 2023 y julio de 2024. Por eso no corresponde compararlo directamente con los 6.444,00 de M3-M5.

Descargá el `.pbix` desde GitHub y abrilo en Power BI Desktop. Para continuar el modelo, usá el archivo de M8. Contiene `Dim_Clientes`, `Dim_Productos`, `Dim_Categorias`, `Fact_Ventas`, el calendario `Dim_Fechas` y la tabla `_Medidas` con cinco medidas DAX. La página `Validación` permite revisar YTD, ventas del año anterior y crecimiento anual.

Los datos importados están guardados en el archivo de Power BI. Si querés actualizarlos en otra computadora, necesitás el Excel original del curso y ajustar su ruta desde **Archivo > Opciones y configuración > Configuración de origen de datos > Cambiar origen**. La ruta guardada corresponde al equipo donde se preparó el trabajo.

## Criterios de interpretación

- En M4, `cantidad_pedidos` usa `COUNT(*)`: cuenta registros de venta. El esquema no tiene una cabecera que agrupe varias líneas de un pedido.
- M3-M5 incluyen un solo mes; no alcanzan para evaluar tendencias o estacionalidad. No se especifica una moneda y no hay costos para calcular rentabilidad.
- En M5, la columna `canal` del `UNION ALL` es una etiqueta creada para separar dos períodos de marzo. No representa canales Online y Presencial reales.
- En M8, el calendario cubre 2023 y 2024 completos, pero los datos de 2024 llegan a julio. Los meses posteriores sin ventas no demuestran por sí solos una caída real del negocio.

## Uso de IA

Se utilizó asistencia de IA para revisar la consulta base y preparar un borrador de esta documentación. Las sugerencias se contrastaron con el esquema y los registros del proyecto. La preentrega 9 documenta los prompts, las respuestas, la evaluación crítica y los cambios del README.
