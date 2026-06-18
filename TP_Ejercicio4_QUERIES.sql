--4. Escribir sentencias SQL que permitan resolver los siguientes casos de negocio:
/*
b. Mostrar los Motivos de Reclamos que tengan más de 3 reclamos en estado
no asignado (sin tarea).
c. Mostrar los Árboles (código, especie y ubicación) que no tengan ningún
reclamo.
d. Mostrar los tres árboles (código y altura) más altos de cada especie. Mostrar
los resultados ordenados por especie y luego altura decreciente.*/

--a. Mostrar la cuadrilla que más tareas realizó en el mes de Octubre de 2025, y la cantidad de tareas realizadas.
SELECT TOP 1 Cu.Codigo AS CodigoCuadrilla, COUNT(idTarea) AS CantTareasRealizadas
FROM Cuadrilla Cu
JOIN Tarea T ON Cu.idCuadrilla=T.idCuadrilla
WHERE FechaRealizado<'2025-11-01' AND FechaRealizado>='2025-10-01'
GROUP BY Cu.Codigo
ORDER BY CantTareasRealizadas DESC;

--b. Mostrar los Motivos de Reclamos que tengan más de 3 reclamos en estado no asignado (sin tarea).
SELECT TOP 3 M.Descripcion, COUNT(R.idReclamo) AS CantReclamos
FROM Reclamos R
JOIN MotivoReclamo M ON M.idMotivoReclamo=R.idMotivo
WHERE R.FechaAsignacionTarea IS NULL
GROUP BY M.Descripcion
HAVING COUNT(R.idReclamo)>3
ORDER BY CantReclamos DESC

--c. Mostrar los Árboles (código, especie y ubicación) que no tengan ningún reclamo.
SELECT A.Codigo, E.NombreComun, U.Plaza, U.Calle, U.Altura
FROM Arbol A
JOIN Especie E ON E.idEspecie=A.idEspecie
JOIN Ubicacion U ON U.idUbicacion=A.idUbicacion
LEFT JOIN Reclamos R ON R.idArbol=A.idArbol
WHERE R.idReclamo IS NULL

--d. Mostrar los tres árboles (código y altura) más altos de cada especie. Mostrar los resultados ordenados por especie y luego altura decreciente.

SELECT RA.Codigo, RA.NombreComun, RA.Altura
FROM( SELECT A.Codigo, E.NombreComun, M.Altura,
	ROW_NUMBER() OVER(partition by E.NombreComun ORDER by  E.NombreComun, M.Altura DESC) AS Ranking
	FROM Arbol A
	JOIN Especie E ON A.idEspecie=E.idEspecie
	JOIN Mediciones M ON M.idArbol=A.idArbol) AS RA
WHERE RA.Ranking <=3