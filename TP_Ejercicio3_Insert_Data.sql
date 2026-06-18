-- 1. CARGA DE TABLAS CATÁLOGO / REFERENCIA

USE TP_BDDI_FRANK_WINTER
GO

-- Especies (5 distintas)
INSERT INTO Especie (NombreComun, NombreCientifico) VALUES 
('Jacarandá', 'Jacaranda mimosifolia'),
('Tilo', 'Tilia platyphyllos'),
('Plátano', 'Platanus x hispanica'),
('Ceibo', 'Erythrina crista-galli'),
('Fresno Americano', 'Fraxinus pennsylvanica');
GO
-- Salud (Estados generales)
INSERT INTO Salud (Estado) VALUES 
('Sano'),
('Enfermo - Leve'),
('Enfermo - Grave'),
('Seco / Muerto'),
('En Riesgo de Caída');
GO
-- Tipos de Tarea
INSERT INTO TipoTarea (Descripcion) VALUES 
('Poda Correctiva'),
('Poda de Despeje'),
('Extracción'),
('Plantado'),
('Censado / Relevamiento');
GO
-- Motivos de Reclamo
INSERT INTO MotivoReclamo (Descripcion) VALUES 
('Rama caída obstruyendo paso'),
('Árbol seco'),
('Raíces levantando vereda'),
('Obstrucción de luminaria'),
('Árbol inclinado / Riesgo caída');
GO
-- Ubicaciones (10 distintas)
INSERT INTO Ubicacion (Plaza, Calle, Altura, Coordenadas) VALUES 
('Plaza San Martín', NULL, NULL, '-32.947, -60.643'),
('Parque España', NULL, NULL, '-32.936, -60.636'),
(NULL, 'Bv. Oroño', '1200', '-32.952, -60.655'),
(NULL, 'Av. Pellegrini', '1500', '-32.956, -60.645'),
(NULL, 'Calle Córdoba', '850', '-32.946, -60.638'),
('Parque Independencia', NULL, NULL, '-32.960, -60.660'),
(NULL, 'Calle Rioja', '2000', '-32.948, -60.650'),
(NULL, 'Calle Santa Fe', '1100', '-32.945, -60.640'),
(NULL, 'Bv. 27 de Febrero', '500', '-32.970, -60.630'),
('Plaza López', NULL, NULL, '-32.958, -60.639');
GO

-- 2. CARGA DE ENTIDADES PRINCIPALES
-- a. 3 Cuadrillas
INSERT INTO Cuadrilla (Codigo) VALUES 
('CUA-NORTE-01'),
('CUA-CENTRO-01'),
('CUA-SUR-01');
GO
-- a. 10 Empleados asignados a las cuadrillas
INSERT INTO Empleados (Nombre, Apellido, CUIL, Telefono, FechaIngreso, idCuadrilla) VALUES 
('Juan', 'Perez', '20-30111111-2', '3411111111', '2020-01-15', 1),
('Maria', 'Gomez', '27-30222222-3', '3412222222', '2020-02-20', 1),
('Carlos', 'Lopez', '20-30333333-4', '3413333333', '2021-05-10', 1),
('Ana', 'Diaz', '27-30444444-5', '3414444444', '2019-11-01', 2),
('Luis', 'Martinez', '20-30555555-6', '3415555555', '2022-03-15', 2),
('Sofia', 'Rodriguez', '27-30666666-7', '3416666666', '2023-01-10', 2),
('Miguel', 'Fernandez', '20-30777777-8', '3417777777', '2018-08-25', 2),
('Lucia', 'Sanchez', '27-30888888-9', '3418888888', '2021-12-05', 3),
('David', 'Ruiz', '20-30999999-0', '3419999999', '2020-07-20', 3),
('Elena', 'Torres', '27-31000000-1', '3410000000', '2022-09-30', 3);
GO
-- b. 50 Árboles
-- Se generan en bloques para variar especies, ubicaciones y datos nulos.
-- Bloque 1: Con Fecha Plantado
INSERT INTO Arbol (Codigo, FechaPlantado, idEspecie, idUbicacion) VALUES
('ARB-001', '2010-05-15', 1, 1), 
('ARB-002', '2011-06-20', 1, 1), 
('ARB-003', '2012-07-25', 2, 2),
('ARB-004', '2013-08-30', 2, 2), 
('ARB-005', '2014-09-05', 3, 3), 
('ARB-006', '2015-10-10', 3, 3),
('ARB-007', '2016-11-15', 4, 4), 
('ARB-008', '2017-12-20', 4, 4), 
('ARB-009', '2018-01-25', 5, 5),
('ARB-010', '2019-02-28', 5, 5), 
('ARB-011', '2005-03-15', 1, 6), 
('ARB-012', '2006-04-20', 1, 6),
('ARB-013', '2007-05-25', 2, 7), 
('ARB-014', '2008-06-30', 2, 7), 
('ARB-015', '2009-07-05', 3, 8),
('ARB-016', '2010-08-10', 3, 8), 
('ARB-017', '2011-09-15', 4, 9), 
('ARB-018', '2012-10-20', 4, 9),
('ARB-019', '2013-11-25', 5, 10),
('ARB-020', '2014-12-30', 5, 10);
GO
-- Bloque 2: Sin Fecha Plantado (Datos antiguos o desconocidos)
INSERT INTO Arbol (Codigo, FechaPlantado, idEspecie, idUbicacion) VALUES
('ARB-021', NULL, 1, 1), 
('ARB-022', NULL, 2, 2), 
('ARB-023', NULL, 3, 3), 
('ARB-024', NULL, 4, 4),
('ARB-025', NULL, 5, 5), 
('ARB-026', NULL, 1, 6), 
('ARB-027', NULL, 2, 7), 
('ARB-028', NULL, 3, 8),
('ARB-029', NULL, 4, 9), 
('ARB-030', NULL, 5, 10), 
('ARB-031', NULL, 1, 2), 
('ARB-032', NULL, 2, 3),
('ARB-033', NULL, 3, 4), 
('ARB-034', NULL, 4, 5), 
('ARB-035', NULL, 5, 6), 
('ARB-036', NULL, 1, 7),
('ARB-037', NULL, 2, 8), 
('ARB-038', NULL, 3, 9), 
('ARB-039', NULL, 4, 10),
('ARB-040', NULL, 5, 1);
GO
-- Bloque 3: Árboles recientes
INSERT INTO Arbol (Codigo, FechaPlantado, idEspecie, idUbicacion) VALUES
('ARB-041', '2024-01-10', 1, 3), 
('ARB-042', '2024-02-15', 2, 4), 
('ARB-043', '2024-03-20', 3, 5),
('ARB-044', '2024-04-25', 4, 6), 
('ARB-045', '2024-05-30', 5, 7), 
('ARB-046', '2024-06-05', 1, 8),
('ARB-047', '2024-07-10', 2, 9), 
('ARB-048', '2024-08-15', 3, 10),
('ARB-049', '2024-09-20', 4, 1),
('ARB-050', '2024-10-25', 5, 2);
GO

-- 3. CARGA DE MEDICIONES (Salud y Altura)
-- Requisito: "Con y sin altura registrada" y "Distintos estados de salud".
-- Insertaremos mediciones para los primeros 40 árboles. Los árboles 41-50 no tendrán medición (Sin altura registrada).

-- Sanos y alturas variadas
INSERT INTO Mediciones (FechaMedicion, Altura, idArbol, idSalud) VALUES
('2024-01-10', 12.5, 1, 1), 
('2024-01-12', 10.0, 2, 1), 
('2024-01-15', 8.5, 3, 1), 
('2024-01-18', 15.2, 4, 1),
('2024-02-01', 9.0, 5, 1),  
('2024-02-05', 11.5, 6, 1), 
('2024-02-10', 13.0, 7, 1), 
('2024-02-15', 7.5, 8, 1),
('2024-03-01', 14.0, 9, 1), 
('2024-03-05', 16.5, 10, 1);
GO
-- Enfermos leves y graves
INSERT INTO Mediciones (FechaMedicion, Altura, idArbol, idSalud) VALUES
('2024-03-10', 10.5, 11, 2), ('2024-03-15', 9.8, 12, 2), ('2024-03-20', 12.0, 13, 2), ('2024-03-25', 11.2, 14, 2),
('2024-04-01', 8.0, 15, 3),  ('2024-04-05', 7.5, 16, 3), ('2024-04-10', 13.5, 17, 3);
GO
-- En riesgo y secos
INSERT INTO Mediciones (FechaMedicion, Altura, idArbol, idSalud) VALUES
('2024-04-15', 18.0, 18, 5), ('2024-04-20', 19.5, 19, 5), ('2024-04-25', 5.5, 20, 4), -- Seco
('2024-05-01', 4.0, 21, 4),  ('2024-05-05', 10.0, 22, 5); -- Riesgo
GO
-- Resto sanos o variados para completar 40
INSERT INTO Mediciones (FechaMedicion, Altura, idArbol, idSalud)
SELECT DATEADD(day, idArbol, '2024-06-01'), (idArbol * 0.5) + 3, idArbol, 1
FROM Arbol WHERE idArbol BETWEEN 23 AND 40;
GO
-- NOTA: Los árboles con idArbol del 41 al 50 NO tienen registros en Mediciones (Sin altura/salud registrada).

-- 4. CARGA DE TAREAS (Transaccional)
-- Requisito c: 20 tareas distribuidas en 3 meses o más (Oct 2025, Nov 2025, Dic 2025).
GO
-- Octubre 2025 (Tareas Realizadas)
INSERT INTO Tarea (FechaEstimada, FechaRealizado, Comentario, idTipoTarea, idCuadrilla) VALUES
('2025-10-05', '2025-10-05', 'Poda realizada con éxito', 1, 2), -- Tarea 1
('2025-10-10', '2025-10-11', 'Extracción de ejemplar seco', 3, 2), -- Tarea 2
('2025-10-15', '2025-10-15', 'Despeje de luminaria', 2, 1), -- Tarea 3
('2025-10-20', '2025-10-20', 'Plantado de reposición', 4, 3), -- Tarea 4
('2025-10-25', '2025-10-26', 'Censado de la cuadra', 5, 2); -- Tarea 5
GO
-- Noviembre 2025 (Algunas realizadas, otras no)
INSERT INTO Tarea (FechaEstimada, FechaRealizado, Comentario, idTipoTarea, idCuadrilla) VALUES
('2025-11-05', '2025-11-05', 'Poda de altura', 1, 1), -- Tarea 6
('2025-11-10', NULL, 'Pendiente por lluvia', 2, 2), -- Tarea 7 (Pendiente)
('2025-11-15', '2025-11-15', 'Extracción programada', 3, 3), -- Tarea 8
('2025-11-20', NULL, 'Falta insumos', 4, 1), -- Tarea 9 (Pendiente)
('2025-11-25', '2025-11-25', 'Relevamiento estado salud', 5, 2), -- Tarea 10
('2025-11-28', '2025-11-29', 'Poda correctiva', 1, 3); -- Tarea 11
GO
-- Diciembre 2025 (Futuras / Pendientes)
INSERT INTO Tarea (FechaEstimada, FechaRealizado, Comentario, idTipoTarea, idCuadrilla) VALUES
('2025-12-01', NULL, 'Planificado', 1, 1), -- Tarea 12
('2025-12-05', NULL, 'Planificado', 2, 2), -- Tarea 13
('2025-12-10', NULL, 'Planificado', 3, 3), -- Tarea 14
('2025-12-15', NULL, 'Planificado', 4, 1), -- Tarea 15
('2025-12-20', NULL, 'Planificado', 1, 2), -- Tarea 16
('2025-12-22', NULL, 'Planificado', 2, 3), -- Tarea 17
('2025-12-26', NULL, 'Planificado', 5, 1), -- Tarea 18
('2025-12-28', NULL, 'Planificado', 1, 2), -- Tarea 19
('2025-12-30', NULL, 'Planificado', 3, 3); -- Tarea 20
GO
-- Asignación Tarea - Arbol (Muchos a Muchos)
-- Requisito: Tareas asociadas a uno o más árboles.
INSERT INTO TareaArbol (idTarea, idArbol) VALUES
(1, 1), -- Tarea 1 -> Arbol 1
(2, 20), -- Tarea 2 -> Arbol 20 (Seco)
(3, 2), (3, 3), -- Tarea 3 -> Arbol 2 y 3 (Varios árboles en una tarea)
(4, 41),
(5, 4), (5, 5), (5, 6), -- Censado masivo
(6, 7),
(7, 8),
(8, 18),
(9, 42),
(10, 9),
(11, 10),
(12, 11),
(13, 12),
(14, 19),
(15, 43),
(16, 13),
(17, 14),
(18, 15),
(19, 16),
(20, 21);
GO

-- 5. CARGA DE RECLAMOS
-- Requisito d: 20 reclamos, 3 meses distintos, estados variados.
-- Estados:
-- 1. No asignados: idTarea NULL.
-- 2. Asignados (Pendientes): idTarea NOT NULL pero Tarea.FechaRealizado IS NULL.
-- 3. Resueltos: idTarea NOT NULL y Tarea.FechaRealizado IS NOT NULL.

-- Octubre (Resueltos y Asignados)
INSERT INTO Reclamos (mail, Fecha, FechaAsignacionTarea, idArbol, idMotivo, idTarea) VALUES
('vecino1@mail.com', '2025-10-01', '2025-10-02', 1, 1, 1), -- Resuelto (Tarea 1 hecha)
('vecino2@mail.com', '2025-10-08', '2025-10-09', 20, 2, 2), -- Resuelto (Tarea 2 hecha)
('vecino3@mail.com', '2025-10-12', '2025-10-13', 2, 4, 3), -- Resuelto (Tarea 3 hecha)
('vecino3@mail.com', '2025-10-12', '2025-10-13', 3, 4, 3); -- Resuelto (Misma tarea 3)
GO
-- Noviembre (Mezcla)
INSERT INTO Reclamos (mail, Fecha, FechaAsignacionTarea, idArbol, idMotivo, idTarea) VALUES
('juan@mail.com', '2025-11-01', '2025-11-02', 7, 1, 6), -- Resuelto
('pedro@mail.com', '2025-11-08', '2025-11-09', 8, 4, 7), -- Asignado pero Pendiente (Tarea 7 es NULL en FechaRealizado)
('ana@mail.com', '2025-11-12', '2025-11-13', 18, 5, 8) -- Resuelto
('admin@plaza.com', '2025-10-18', NULL, 41, 2, 4) -- No Asignado
('luz@mail.com', '2025-11-18', NULL, 42, 2, 9), -- No Asignado
('admin@club.com', '2025-11-20', NULL, 9, 3, 10), -- No Asignado
('admin@club.com', '2025-11-26', NULL, 10, 1, 11), -- No Asignado
('vecinoX@mail.com', '2025-11-01', NULL, 11, 1, 12), -- No Asignado
('vecinoY@mail.com', '2025-11-02', NULL, 12, 1, 13), -- No Asignado
('vecinoZ@mail.com', '2025-11-05', NULL, 19, 3, 14), -- No Asignado
('queja@barrio.com', '2025-11-10', NULL, 25, 3, NULL), -- No Asignado
('queja@barrio.com', '2025-11-12', NULL, 26, 3, NULL), -- No Asignado
('alerta@ciudad.com', '2025-11-15', NULL, 27, 2, NULL), -- No Asignado
('alerta@ciudad.com', '2025-11-20', NULL, 28, 2, NULL), -- No Asignado
('info@vecinos.com', '2025-11-22', NULL, 29, 1, NULL); -- No Asignado; 
GO