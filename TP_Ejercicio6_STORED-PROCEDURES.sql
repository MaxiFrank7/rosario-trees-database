USE TP_BDDI_FRANK_WINTER
GO

/*Escriba un procedimiento almacenado para identificar si existen tareas no realizadas 
dado un árbol en particular y un tipo de tareas. El procedimiento debe devolver: 

a. Como parámetro de salida, la fecha de la próxima tarea del tipo indicado a 
realizarse sobre el árbol, si existiera.*/

CREATE PROCEDURE SP_VERIFICA_TAREA
	@ARBOL INT,
	@TIPOTAREA INT,
	@FECHA_PROX_TAREA DATE OUTPUT
AS
BEGIN
	BEGIN TRY
		DECLARE @FechaActual DATE;
		SET @FechaActual = GETDATE();
		SELECT TOP 1 @FECHA_PROX_TAREA = T.FechaEstimada
		FROM TareaArbol AS TA
		JOIN Tarea AS T ON T.idtarea = TA.idtarea
		WHERE TA.idarbol = @ARBOL AND T.idTipoTarea = @TIPOTAREA AND T.FechaEstimada >= @FechaActual
		ORDER BY T.FechaEstimada ASC;
		RETURN 0;
	END TRY
	BEGIN CATCH
		RETURN -1;
	END CATCH
END;
GO
		
--Ejemplo de uso

DECLARE @RETURN_CODE INT
DECLARE @FECHA DATE

EXEC @RETURN_CODE = SP_VERIFICA_TAREA @ARBOL = 11, @TIPOTAREA = 1, @FECHA_PROX_TAREA = @FECHA OUTPUT

SELECT @RETURN_CODE AS [CODIGO DE RETORNO]
SELECT @FECHA AS [FECHA PROXIMA]

/*b. Debe retornar (como valor de retorno) la cantidad de tareas pendientes de 
realizar para el tipo de tarea y árbol proporcionados.*/