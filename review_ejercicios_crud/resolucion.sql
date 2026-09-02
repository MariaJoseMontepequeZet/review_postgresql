-- =========================================================
-- SELECT
-- =========================================================

-- 1. Nombre, edad y promedio de los estudiantes activos.
SELECT nombre, edad, promedio FROM estudiantes WHERE activo = true;

-- 2. Estudiantes de género femenino con promedio >= 4.5.
SELECT * FROM estudiantes WHERE genero = 'F' AND promedio >= 4.5;

-- 3. Estudiantes ingresados en 2024, orden descendente por fecha_ingreso.
SELECT *
FROM estudiantes
WHERE
    EXTRACT(
        YEAR
        FROM fecha_ingreso
    ) = 2024
ORDER BY fecha_ingreso DESC;

-- 4. Promedio de edad y promedio general de calificaciones.
SELECT
    AVG(edad) AS promedio_edad,
    AVG(promedio) AS promedio_general
FROM estudiantes;

-- 5. Cantidad de estudiantes por género.
SELECT genero, COUNT(*) AS total FROM estudiantes GROUP BY genero;

-- 6. Los 5 estudiantes con los promedios más altos.
SELECT * FROM estudiantes ORDER BY promedio DESC LIMIT 5;

-- 7. Estudiantes cuya duración de tests haya sido mayor a 2 horas y media.
SELECT *
FROM estudiantes
WHERE
    duracion_tests > INTERVAL '2 hours 30 minutes';

-- 8. Estudiantes cuyo análisis de perfil contenga "bases de datos" o "algoritmos".
SELECT *
FROM estudiantes
WHERE
    analisis_perfil ILIKE '%bases de datos%'
    OR analisis_perfil ILIKE '%algoritmos%';

-- 9. Altura máxima y mínima entre los estudiantes hombres.
SELECT
    MAX(altura) AS altura_maxima,
    MIN(altura) AS altura_minima
FROM estudiantes
WHERE
    genero = 'M';

-- 10. Nombre, fecha y hora exacta de registro de quienes ingresaron antes de las 09:00:00 AM.
SELECT nombre, fecha_hora_registro
FROM estudiantes
WHERE
    hora_ingreso < TIME '09:00:00';

-- =========================================================
-- UPDATE
-- =========================================================

-- 1. Cambiar el estado a inactivo para el estudiante con id 6.
UPDATE estudiantes SET activo = false WHERE id = 6;

-- 2. Incrementar en 0.2 el promedio de los estudiantes con promedio < 3.0.
UPDATE estudiantes
SET
    promedio = promedio + 0.2
WHERE
    promedio < 3.0;

-- 3. Actualizar hora_ingreso a 08:00:00 para quienes ingresaron el 2024-02-01.
UPDATE estudiantes
SET
    hora_ingreso = TIME '08:00:00'
WHERE
    fecha_ingreso = DATE '2024-02-01';

-- 4. Agregar anotación al análisis de perfil del estudiante con id 15.
UPDATE estudiantes
SET
    analisis_perfil = analisis_perfil || ' Graduado con honores académicos.'
WHERE
    id = 15;

-- 5. Cambiar género a F y altura a 1.65 para el estudiante con id 20.
UPDATE estudiantes SET genero = 'F', altura = 1.65 WHERE id = 20;

-- 6. Desactivar estudiantes registrados antes de 2022 con promedio < 3.5.
UPDATE estudiantes
SET
    activo = false
WHERE
    EXTRACT(
        YEAR
        FROM fecha_ingreso
    ) < 2022
    AND promedio < 3.5;

-- 7. Ajustar duracion_tests a 2 horas para quienes tengan duración < 1 hora.
UPDATE estudiantes
SET
    duracion_tests = INTERVAL '2 hours'
WHERE
    duracion_tests < INTERVAL '1 hour';

-- 8. Aumentar la edad en 1 año a quienes ingresaron en 2021.
UPDATE estudiantes
SET
    edad = edad + 1
WHERE
    EXTRACT(
        YEAR
        FROM fecha_ingreso
    ) = 2021;

-- 9. Establecer analisis_perfil como NULL para los estudiantes inactivos.
UPDATE estudiantes SET analisis_perfil = NULL WHERE activo = false;

-- 10. Actualizar promedio a 5.0 para el estudiante con la fecha de registro más antigua.
UPDATE estudiantes
SET
    promedio = 5.0
WHERE
    fecha_hora_registro = (
        SELECT MIN(fecha_hora_registro)
        FROM estudiantes
    );

-- =========================================================
-- DELETE
-- =========================================================

-- 1. Eliminar el registro del estudiante con id 34.
DELETE FROM estudiantes WHERE id = 34;

-- 2. Borrar todos los estudiantes inactivos.
DELETE FROM estudiantes WHERE activo = false;

-- 3. Eliminar estudiantes con promedio estrictamente menor a 2.5.
DELETE FROM estudiantes WHERE promedio < 2.5;

-- 4. Borrar estudiantes con fecha_ingreso anterior a '2021-01-01'.
DELETE FROM estudiantes WHERE fecha_ingreso < DATE '2021-01-01';

-- 5. Eliminar hombres con altura inferior a 1.60 m.
DELETE FROM estudiantes WHERE genero = 'M' AND altura < 1.60;

-- 6. Borrar estudiantes ingresados en 2024 que estén inactivos.
DELETE FROM estudiantes
WHERE
    EXTRACT(
        YEAR
        FROM fecha_ingreso
    ) = 2024
    AND activo = false;

-- 7. Eliminar estudiantes cuya duración de tests sea menor a 45 minutos.
DELETE FROM estudiantes WHERE duracion_tests < INTERVAL '45 minutes';

-- 8. Borrar estudiantes cuyo nombre comience con 'E'.
DELETE FROM estudiantes WHERE nombre LIKE 'E%';

-- 9. Eliminar activos que ingresaron antes de 2023 y promedio < 3.5.
DELETE FROM estudiantes
WHERE
    activo = true
    AND EXTRACT(
        YEAR
        FROM fecha_ingreso
    ) < 2023
    AND promedio < 3.5;

-- 10. Vaciar completamente la tabla estudiantes.
TRUNCATE TABLE estudiantes;