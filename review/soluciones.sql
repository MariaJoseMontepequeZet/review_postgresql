-- 1. Vista vw_ventas_destacadas
CREATE VIEW vw_ventas_destacadas AS
SELECT fecha, vendedor, monto
FROM ventas_vendedores
WHERE
    monto >= 300.00;

-- 2. Vista vw_resumen_vendedores
CREATE VIEW vw_resumen_vendedores AS
SELECT
    vendedor,
    COUNT(*) AS total_transacciones,
    ROUND(AVG(monto), 2) AS precio_promedio
FROM ventas_vendedores
GROUP BY
    vendedor;

-- 3. Procedimiento sp_ajustar_precios_bajo_stock
CREATE PROCEDURE sp_ajustar_precios_bajo_stock(p_limite_stock INT, p_porcentaje NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE productos
    SET precio = precio + (precio * p_porcentaje / 100)
    WHERE stock < p_limite_stock;
END;
$$;

-- Ejemplo de uso: CALL sp_ajustar_precios_bajo_stock(15, 10.00);

-- 4. Función fn_aplicar_descuento_producto
CREATE FUNCTION fn_aplicar_descuento_producto(p_producto_id INT, p_porcentaje_descuento NUMERIC)
RETURNS NUMERIC(8, 2)
LANGUAGE plpgsql AS $$
DECLARE
    v_precio_original NUMERIC(8, 2);
    v_precio_final NUMERIC(8, 2);
BEGIN
    SELECT precio INTO v_precio_original
    FROM productos
    WHERE id = p_producto_id;

    v_precio_final := v_precio_original - (v_precio_original * p_porcentaje_descuento / 100);

    RETURN v_precio_final;
END;
$$;

-- Ejemplo de uso: SELECT fn_aplicar_descuento_producto(1, 15.00);