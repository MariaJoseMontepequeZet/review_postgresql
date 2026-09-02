-- Funciones de ventana

-- Ranking de mayores ventas
SELECT
    fecha,
    vendedor,
    monto,
    ROW_NUMBER() OVER (
        ORDER BY monto DESC
    ) AS ranking
FROM ventas_vendedores;

-- Porcentaje sobre el total del mes
SELECT
    fecha,
    vendedor,
    monto,
    ROUND(
        monto * 100.0 / SUM(monto) OVER (
            PARTITION BY
                EXTRACT(
                    YEAR
                    FROM fecha
                ),
                EXTRACT(
                    MONTH
                    FROM fecha
                )
        ),
        2
    ) AS porcentaje_del_mes
FROM ventas_vendedores;

-- CTE

WITH
    resumen_vendedores AS (
        SELECT
            vendedor,
            SUM(monto) AS total_vendido,
            ROUND(AVG(monto), 2) AS promedio_transaccion
        FROM ventas_vendedores
        GROUP BY
            vendedor
    )
SELECT
    vendedor,
    total_vendido,
    promedio_transaccion
FROM resumen_vendedores
WHERE
    promedio_transaccion > 200.00
ORDER BY total_vendido DESC;