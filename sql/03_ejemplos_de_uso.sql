USE TP_BBDD_G10
GO
--4. Escribir sentencias SQL que permitan resolver los siguientes casos de negocio:

--a. Mostrar la cuadrilla que más tareas realizó en el mes de Octubre de 2025, y la cantidad de tareas realizadas.
SELECT TOP 1 Cu.Codigo AS CodigoCuadrilla, COUNT(idTarea) AS CantTareasRealizadas
FROM Cuadrilla Cu
JOIN Tarea T ON Cu.idCuadrilla=T.idCuadrilla
WHERE FechaRealizado<'2025-11-01' AND FechaRealizado>='2025-10-01'
GROUP BY Cu.Codigo
ORDER BY CantTareasRealizadas DESC;
GO
--b. Mostrar los Motivos de Reclamos que tengan más de 3 reclamos en estado no asignado (sin tarea).
SELECT TOP 3 M.Descripcion, COUNT(R.idReclamo) AS CantReclamos
FROM Reclamos R
JOIN MotivoReclamo M ON M.idMotivoReclamo=R.idMotivo
WHERE R.FechaAsignacionTarea IS NULL
GROUP BY M.Descripcion
HAVING COUNT(R.idReclamo)>3
ORDER BY CantReclamos DESC
GO
--c. Mostrar los Árboles (código, especie y ubicación) que no tengan ningún reclamo.
SELECT A.Codigo, E.NombreComun, U.Plaza, C.Nombre, U.Altura
FROM Arbol A
JOIN Especie E ON E.idEspecie=A.idEspecie
JOIN Ubicacion U ON U.idUbicacion=A.idUbicacion
LEFT JOIN Calles C ON U.idCalle=C.idCalle
LEFT JOIN Reclamos R ON R.idArbol=A.idArbol
WHERE R.idReclamo IS NULL
GO
--d. Mostrar los tres árboles (código y altura) más altos de cada especie. Mostrar los resultados ordenados por especie y luego altura decreciente.
SELECT RA.Codigo, RA.NombreComun, RA.Altura
FROM( SELECT A.Codigo, E.NombreComun, M.Altura,
	ROW_NUMBER() OVER(partition by E.NombreComun ORDER by  E.NombreComun, M.Altura DESC) AS Ranking
	FROM Arbol A
	JOIN Especie E ON A.idEspecie=E.idEspecie
	JOIN Mediciones M ON M.idMedicion=A.idMedicion) AS RA
WHERE RA.Ranking <=3
GO

--Ejemplos de uso Ejercicio 5a vistas
SELECT * FROM v_InfoReclamos;
SELECT * FROM v_InfoReclamos WHERE [Tiempo de Asignacion] > 10;
GO
--Ejemplos de uso Ejercicio 5b vistas
SELECT * FROM v_TareasRealizadas;
SELECT * FROM v_TareasRealizadas WHERE [Cantidad Tareas] > 2;
GO

--Ejemplos de uso Ejercicio 6 Procedure
--Caso 1 encontrando tareas
DECLARE @FechaSalida DATE;      -- Variable para atrapar el OUTPUT
DECLARE @CantidadTareas INT;   -- Variable para atrapar el RETURN

EXEC @CantidadTareas = sp_AnalizarTareasArbol 
    @idArbol = 19,                
    @idTipoTarea = 3,             
    @FechaProxima = @FechaSalida OUTPUT;

-- Mostrar resultados
SELECT 
    'Caso Encontrado' AS Escenario,
    @FechaSalida AS [Fecha Próxima Tarea],
    @CantidadTareas AS [Tareas Pendientes];
GO

--Caso 2 No encontradoDECLARE @FechaSalida2 DATE;
DECLARE @CantidadRetorno2 INT;

-- Ejecución
EXEC @CantidadRetorno2 = sp_AnalizarTareasArbol 
    @idArbol = 1,                -- ID de un árbol sin tareas o inexistente
    @idTipoTarea = 1,
    @FechaProxima = @FechaSalida2 OUTPUT;

-- Mostrar resultados
SELECT 
    'Caso NO Encontrado' AS Escenario,
    @FechaSalida2 AS [Fecha Próxima Tarea], -- Debería ser NULL
    @CantidadRetorno2 AS [Cantidad Pendientes]; -- Debería ser 0
GO