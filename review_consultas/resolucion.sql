-- 1. Título, fecha de publicación y precio de libros publicados después del año 2000, ordenados del más reciente al más antiguo.
SELECT
    titulo,
    fecha_publicacion,
    precio
FROM libros
WHERE
    fecha_publicacion > '2000-12-31'
ORDER BY fecha_publicacion DESC;

-- 2. Nombres completos (nombre y apellido en una sola columna) y nacionalidad de autores 'Española' o 'Argentina'.
SELECT
    nombre || ' ' || apellido AS nombre_completo,
    nacionalidad
FROM autores
WHERE
    nacionalidad IN ('Española', 'Argentina');

-- 3. Libros cuyo precio esté entre $15.00 y $20.00 inclusive.
SELECT * FROM libros WHERE precio BETWEEN 15.00 AND 20.00;

-- 4. Libros cuyo título contenga la palabra "amor" (sin importar mayúsculas/minúsculas).
SELECT * FROM libros WHERE titulo ILIKE '%amor%';

-- 5. Los 5 libros más costosos, con título y precio.
SELECT titulo, precio FROM libros ORDER BY precio DESC LIMIT 5;

-- 6. Título del libro, precio y nombre completo del autor de cada libro.
SELECT l.titulo, l.precio, a.nombre || ' ' || a.apellido AS autor
FROM libros l
    JOIN autores a ON l.autor_id = a.autor_id;

-- 7. Cantidad total de libros por autor, con nombre completo y total, ordenados de mayor a menor.
SELECT a.nombre || ' ' || a.apellido AS autor, COUNT(l.libro_id) AS total_libros
FROM autores a
    JOIN libros l ON a.autor_id = l.autor_id
GROUP BY
    a.autor_id,
    a.nombre,
    a.apellido
ORDER BY total_libros DESC;

-- 8. Precio promedio, mínimo y máximo de los libros de cada autor.
SELECT
    a.nombre || ' ' || a.apellido AS autor,
    ROUND(AVG(l.precio), 2) AS precio_promedio,
    MIN(l.precio) AS precio_minimo,
    MAX(l.precio) AS precio_maximo
FROM autores a
    JOIN libros l ON a.autor_id = l.autor_id
GROUP BY
    a.autor_id,
    a.nombre,
    a.apellido;

-- 9. Autores con un promedio de precio en sus libros superior a $20.00.
SELECT a.nombre || ' ' || a.apellido AS autor, ROUND(AVG(l.precio), 2) AS precio_promedio
FROM autores a
    JOIN libros l ON a.autor_id = l.autor_id
GROUP BY
    a.autor_id,
    a.nombre,
    a.apellido
HAVING
    AVG(l.precio) > 20.00;

-- 10. Cantidad de libros publicados por cada nacionalidad de los autores.
SELECT a.nacionalidad, COUNT(l.libro_id) AS total_libros
FROM autores a
    JOIN libros l ON a.autor_id = l.autor_id
GROUP BY
    a.nacionalidad
ORDER BY total_libros DESC;