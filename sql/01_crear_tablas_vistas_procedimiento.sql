CREATE DATABASE TP_BBDD_G10
GO
USE TP_BBDD_G10
GO
--CREACION DE TODAS LAS TABLAS
-- 1. Tablas Catálogo / Referencia
CREATE TABLE Especie (
    idEspecie INT IDENTITY(1,1) NOT NULL,
    NombreComun VARCHAR(100) NOT NULL,
    NombreCientifico VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Especie PRIMARY KEY (idEspecie)
);
GO

CREATE TABLE Salud (
    idSalud INT IDENTITY(1,1) NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Salud PRIMARY KEY (idSalud)
);
GO

CREATE TABLE TipoTarea (
    idTipoTarea INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TipoTarea PRIMARY KEY (idTipoTarea)
);
GO

CREATE TABLE MotivoReclamo (
    idMotivoReclamo INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(80) NOT NULL,
    CONSTRAINT PK_MotivoReclamo PRIMARY KEY (idMotivoReclamo)
);
GO
CREATE TABLE Calles (
    idCalle INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Calles PRIMARY KEY (idCalle)
);
GO

CREATE TABLE Cuadrilla (
    idCuadrilla INT IDENTITY(1,1) NOT NULL,
    Codigo VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Cuadrilla PRIMARY KEY (idCuadrilla)
);
GO

-- 2. Entidades con dependencia de tablas Catálogos
CREATE TABLE Mediciones (
    idMedicion INT IDENTITY(1,1) NOT NULL,
    FechaMedicion DATE NULL, 
    Altura DECIMAL(10,2) NULL,
    idSalud INT NOT NULL,
    CONSTRAINT PK_Mediciones PRIMARY KEY (idMedicion),
    CONSTRAINT FK_Mediciones_Salud FOREIGN KEY (idSalud) REFERENCES Salud(idSalud)
);
GO

CREATE TABLE Ubicacion (
    idUbicacion INT IDENTITY(1,1) NOT NULL,
    Plaza VARCHAR(100) NULL,
    idCalle INT NULL,
    Altura VARCHAR(20) NULL,
    Coordenadas VARCHAR(100) NOT NULL, 
    CONSTRAINT PK_Ubicacion PRIMARY KEY (idUbicacion),
    CONSTRAINT FK_Ubicacion_Calles FOREIGN KEY (idCalle) REFERENCES Calles(idCalle)
);
GO

CREATE TABLE Empleados (
    idEmpleado INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    CUIL VARCHAR(20) NOT NULL,
    Telefono VARCHAR(50) NULL,
    FechaIngreso DATE NOT NULL,
    idCuadrilla INT NULL, 
    CONSTRAINT PK_Empleados PRIMARY KEY (idEmpleado),
    CONSTRAINT FK_Empleados_Cuadrilla FOREIGN KEY (idCuadrilla) REFERENCES Cuadrilla(idCuadrilla)
);
GO

CREATE TABLE Arbol (
    idArbol INT IDENTITY(1,1) NOT NULL,
    Codigo VARCHAR(50) NOT NULL,
    idEspecie INT NOT NULL,
    idUbicacion INT NOT NULL,
    FechaPlantado DATE NULL,
    idMedicion INT NULL, -- modificacion relevante luego de defensa TP
    CONSTRAINT PK_Arbol PRIMARY KEY (idArbol),
    -- Relaciones
    CONSTRAINT FK_Arbol_Especie FOREIGN KEY (idEspecie) REFERENCES Especie(idEspecie),
    CONSTRAINT FK_Arbol_Ubicacion FOREIGN KEY (idUbicacion) REFERENCES Ubicacion(idUbicacion),
    CONSTRAINT FK_Arbol_Medicion FOREIGN KEY (idMedicion) REFERENCES Mediciones(idMedicion) 
);
GO
-- 3. Tablas Transaccionales
CREATE TABLE Tarea (
    idTarea INT IDENTITY(1,1) NOT NULL,
    idTipoTarea INT NOT NULL,
    idCuadrilla INT NOT NULL,
    FechaEstimada DATE NOT NULL,
    FechaRealizado DATE NULL,
    Comentario VARCHAR(255) NULL,
    CONSTRAINT PK_Tarea PRIMARY KEY (idTarea),
    CONSTRAINT FK_Tarea_Tipo FOREIGN KEY (idTipoTarea) REFERENCES TipoTarea(idTipoTarea),
    CONSTRAINT FK_Tarea_Cuadrilla FOREIGN KEY (idCuadrilla) REFERENCES Cuadrilla(idCuadrilla)
);
GO

CREATE TABLE TareaArbol (
    idTarea INT NOT NULL,
    idArbol INT NOT NULL,
    CONSTRAINT PK_TareaArbol PRIMARY KEY (idTarea, idArbol),
    CONSTRAINT FK_TareaArbol_Tarea FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea),
    CONSTRAINT FK_TareaArbol_Arbol FOREIGN KEY (idArbol) REFERENCES Arbol(idArbol)
);
GO

CREATE TABLE Reclamos (
    idReclamo INT IDENTITY(1,1) NOT NULL,
    idArbol INT NOT NULL,
    idMotivo INT NOT NULL,
    mail VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL,
    idTarea INT NULL,
    FechaAsignacionTarea DATE NULL,
    CONSTRAINT PK_Reclamos PRIMARY KEY (idReclamo),
    CONSTRAINT FK_Reclamos_Arbol FOREIGN KEY (idArbol) REFERENCES Arbol(idArbol),
    CONSTRAINT FK_Reclamos_Motivo FOREIGN KEY (idMotivo) REFERENCES MotivoReclamo(idMotivoReclamo),
    CONSTRAINT FK_Reclamos_Tarea FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea)
);
GO

-- RESTRICCIONES UNIQUE (Para evitar datos duplicados lógicamente)
ALTER TABLE Cuadrilla ADD CONSTRAINT UQ_Cuadrilla_Codigo UNIQUE (Codigo);
ALTER TABLE Arbol ADD CONSTRAINT UQ_Arbol_Codigo UNIQUE (Codigo);
ALTER TABLE Empleados ADD CONSTRAINT UQ_Empleados_CUIL UNIQUE (CUIL);
ALTER TABLE Especie ADD CONSTRAINT UQ_Especie_Cientifico UNIQUE (NombreCientifico);
ALTER TABLE TipoTarea ADD CONSTRAINT UQ_TipoTarea_Descripcion UNIQUE (Descripcion);
ALTER TABLE Salud ADD CONSTRAINT UQ_Salud_Estado UNIQUE (Estado);
ALTER TABLE MotivoReclamo ADD CONSTRAINT UQ_Motivo_Descripcion UNIQUE (Descripcion);
ALTER TABLE Calles ADD CONSTRAINT UQ_Calles_Nombre UNIQUE (Nombre);
GO

/*5. Escriba las siguientes vistas. Proporcione dos ejemplos de ejecución usando cada una de ellas:
a. Mostrar información de los reclamos. Se desea saber la fecha de cada uno,
el código del árbol asociado al reclamo, la cantidad de días que se tardó en
asignar la tarea y la cantidad de días que se tardó en resolver el mismo. Sino tiene tarea asignada o no fue resuelto calcular los días hasta la fechaactual.*/
CREATE VIEW v_InfoReclamos AS
	SELECT R.Fecha, A.Codigo, 
		DATEDIFF(DAY, R.Fecha, ISNULL(T.FechaRealizado, GETDATE())) AS [Tiempo de Resolucion], 
		DATEDIFF(DAY, R.Fecha, ISNULL(R.FechaAsignacionTarea, GETDATE())) AS [Tiempo de Asignacion]
	FROM Reclamos R
	JOIN Arbol A ON A.idArbol=R.idArbol
	LEFT JOIN Tarea T ON T.idtarea=R.idTarea
GO
/*b. Resumen de tareas ya realizadas según su tipo. Se desea saber la fecha de
la primer y última tarea de cada tipo y la cantidad de tareas realizadas*/
CREATE VIEW v_TareasRealizadas AS
	SELECT TT.Descripcion, 
		MIN(T.FechaRealizado) AS [Primera Fecha Realizada], 
		MAX(T.FechaRealizado) AS [Ultima Fecha Realizada], 
		COUNT(*) AS [Cantidad Tareas]
	FROM Tarea T
	JOIN TipoTarea TT ON T.idTipoTarea=TT.idTipoTarea
	WHERE T.FechaRealizado<=GETDATE()
	GROUP BY TT.Descripcion
GO

/*6. Escriba un procedimiento almacenado para identificar si existen tareas no realizadas
dado un árbol en particular y un tipo de tareas. El procedimiento debe devolver:
a. Como parámetro de salida, la fecha de la próxima tarea del tipo indicado a
realizarse sobre el árbol, si existiera.
b. Debe retornar (como valor de retorno) la cantidad de tareas pendientes de
realizar para el tipo de tarea y árbol proporcionados.
Incluya dos ejemplos de ejecución del procedimiento (encontrando y no encontrandotareas) y muestre los valores devueltos en cada caso.*/

CREATE OR ALTER PROCEDURE sp_AnalizarTareasArbol
	@idArbol INT,
	@idTipoTarea INT,
	@FechaProxima DATE OUTPUT
AS
BEGIN
	--punto a
	SELECT TOP 1 @FechaProxima=T.FechaEstimada
	FROM TareaArbol TA
	JOIN Tarea T ON T.idTarea=TA.idTarea
	WHERE TA.idArbol=@idArbol 
		  AND T.idTipoTarea=@idTipoTarea 
		  AND T.FechaRealizado IS NULL 
		  AND T.FechaEstimada>=GETDATE()
	ORDER BY T.FechaEstimada ASC;
	--punto b
	DECLARE @CantidadPendientes INT;
	SELECT @CantidadPendientes = COUNT(T.idTarea)
    FROM TareaArbol TA
    JOIN Tarea T ON TA.idTarea = T.idTarea
    WHERE TA.idArbol = @idArbol 
      AND T.idTipoTarea = @idTipoTarea
      AND T.FechaRealizado IS NULL;
	RETURN @CantidadPendientes;
END
GO