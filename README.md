# review_postgresql

Repositorio de ejercicios y trabajos prácticos del curso de PostgreSQL. Reúne las resoluciones individuales de "review" entregados durante el curso, además del proyecto colaborativo integrador desarrollado en conjunto por Evelyn Barrios y María José.

## Estructura del repositorio

```
review_postgresql/
├── review/
│   └── soluciones.sql
├── review_consultas/
│   └── resolucion.sql
├── review_ejercicios_crud/
│   └── resolucion.sql
├── review_funciones_ventana/
│   └── solucion.sql
└── review_evelyn_maria_jose/
    ├── data/
    │   ├── categorias.json
    │   ├── imagen.jpg
    │   └── juegos.xml
    ├── docs/
    │   ├── evidencias/
    │   └── notas.md
    └── sql/
        ├── 01_setup_tablas.sql
        ├── 02_import_json.sql
        ├── 03_import_xml.sql
        ├── 04_consultas_comparacion.sql
        ├── 05_auditoria_joins.sql
        ├── 06_arrays.sql
        └── 07_bytea.sql
```

## Contenido por módulo

### `review/`
Consultas SELECT sobre las tablas `libros` y `autores`: filtrado por fecha y rango de precios, búsqueda de texto (`ILIKE`), TOP N, JOIN autor-libro, agregaciones (`COUNT`, `AVG`, `MIN`, `MAX`) agrupadas por autor y por nacionalidad, y filtrado de grupos con `HAVING`.

### `review_consultas/`
Vistas, procedimientos y funciones sobre las tablas `ventas_vendedores` y `productos`:
- `vw_ventas_destacadas` — vista de ventas con monto ≥ $300.00.
- `vw_resumen_vendedores` — vista con total de transacciones y precio promedio por vendedor.
- `sp_ajustar_precios_bajo_stock` — procedimiento que incrementa el precio de productos con stock bajo un límite dado.
- `fn_aplicar_descuento_producto` — función que calcula el precio final aplicando un porcentaje de descuento.

### `review_ejercicios_crud/`
Ejercicios CRUD completos (30 consultas) sobre la tabla `estudiantes`: 10 SELECT (filtros, agregaciones, ordenamientos, búsquedas de texto), 10 UPDATE (modificación condicional de estado, promedios, fechas y campos de texto) y 10 DELETE (eliminación condicional y vaciado total de la tabla).

### `review_funciones_ventana/`
Funciones de ventana y CTE sobre `ventas_vendedores`:
- Ranking general de ventas por monto con `ROW_NUMBER() OVER (ORDER BY monto DESC)`.
- Porcentaje de cada venta respecto al total del mes con `SUM() OVER (PARTITION BY ...)`.
- Reporte de total acumulado y promedio por transacción por vendedor mediante CTE, filtrando vendedores con promedio superior a $200.00.

### `review_evelyn_maria_jose/`
Proyecto colaborativo integrador, organizado bajo GitFlow (`main`, `dev`, ramas `feature/*`):
- **`sql/01_setup_tablas.sql`** — creación de las tablas base del proyecto.
- **`sql/02_import_json.sql`** — importación de datos semiestructurados desde `data/categorias.json` usando JSONB y `jsonb_array_elements()`.
- **`sql/03_import_xml.sql`** — importación de datos desde `data/juegos.xml` usando `xpath()`/`unnest()` y `XMLTABLE()`.
- **`sql/04_consultas_comparacion.sql`** — consultas de comparación empleando funciones de ventana.
- **`sql/05_auditoria_joins.sql`** — consultas de auditoría con distintos tipos de JOIN.
- **`sql/06_arrays.sql`** — trabajo con columnas de tipo arreglo (`INT[]`).
- **`sql/07_bytea.sql`** — almacenamiento de archivos binarios (`data/imagen.jpg`) con `BYTEA` y `pg_read_binary_file()`.
- **`docs/notas.md`** — documentación del proyecto.
- **`docs/evidencias/`** — capturas de pantalla que respaldan la ejecución de los ejercicios.

## Tecnologías

- PostgreSQL 18 (entorno nativo de Windows)
- psql (línea de comandos)
- Git / GitHub con flujo de trabajo GitFlow

## Flujo de trabajo (GitFlow)

- `main` — versión estable del repositorio.
- `dev` — rama de integración de features.
- `feature/documentation` — documentación del proyecto colaborativo (a cargo de María José).
- `feature/codigo-clase` — código del proyecto colaborativo (a cargo de Evelyn).
- Los cambios se integran a `dev` mediante Pull Requests.

## Autoras

Evelyn Barrios y María José