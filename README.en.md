# Rosario public trees database (SQL Server)

Group project by two team members. Databases I, University Technical Degree in Artificial Intelligence (FCEIA, UNR, Argentina), 2025. Group G10.

[Versión en español](README.md)

We designed and implemented in SQL Server the database for the Parks and Green Spaces Department of Rosario, Argentina. We modeled 13 tables in 3NF and wrote the creation and sample-data scripts. On top of that model we built two views, a stored procedure and four business queries.

## Team

This is a group project by two people:

- Maximiliano Frank
- Federico Winter

Original group repository: [winttita/TP-Final-BDDI](https://github.com/winttita/TP-Final-BDDI).

This repository is a copy under Maximiliano Frank's account, reorganized to show as a portfolio piece. The group owns the work.

## Scenario

The Parks and Green Spaces Department needs to computerize the management of its public trees. The database handles:

- **Tree inventory:** species, location, health status, height and planting date.
- **Crews and employees:** work crews and their members, with contact details and hire date.
- **Tasks:** pruning, removal, planting and others, assigned to a crew, with an estimated date, a completion date and a comment.
- **Citizen complaints:** complaints received by email, their reason, the task that resolves them and the assignment and resolution times.

## Data model

![Entity-relationship diagram of the public trees database](assets/der_arbolado_publico.png)

The model is in third normal form. You can also view and edit it in [drawdb](https://www.drawdb.app/editor?shareId=136ac6a3d8b99b33fd0cafe26ec6e197).

The diagram, table names and column names are in Spanish.

### Design decisions

- **Unique attributes.** `Cuadrilla.Codigo`, `Arbol.Codigo` and `Empleados.CUIL` are unique because the assignment required it. We added the same constraint to `Especie.NombreCientifico`, `TipoTarea.Descripcion`, `Salud.Estado`, `MotivoReclamo.Descripcion` and `Calles.Nombre` so the catalogs hold no duplicates.
- **Mediciones is 1:1 with Árbol.** The table stores only the tree's current state (height and health), with no history. A tree can have no measurement (`idMedicion` allows `NULL`), which saves space for old trees that were never measured.
- **`TareaArbol` junction table.** One task can apply to many trees, and one tree can receive many tasks.
- **Employee and crew.** Each employee belongs to a single crew, and we do not keep a history of changes.
- **Complaints and tasks.** One task can resolve several complaints, but each complaint is resolved by a single task. A complaint with no task is unassigned.
- **Location.** A tree is in a plaza or park, or on a street with a street number. In rare cases it can have both. The database does not force a choice.

## Contents

| File | What it does |
|---|---|
| `sql/01_crear_tablas_vistas_procedimiento.sql` | Creates the `TP_BBDD_G10` database, the 13 tables with their keys and constraints, the views and the procedure. |
| `sql/02_insertar_datos.sql` | Loads sample data. |
| `sql/03_ejemplos_de_uso.sql` | Business queries and usage examples for the views and the procedure. |

**Sample data:** 3 crews, 10 employees, 50 trees of 5 species, 40 measurements, 20 tasks (October to December 2025) and 19 complaints.

**Views:**

- `v_InfoReclamos`: assignment and resolution time of each complaint.
- `v_TareasRealizadas`: first and last date and count of completed tasks by type.

**Stored procedure:** `sp_AnalizarTareasArbol(@idArbol, @idTipoTarea, @FechaProxima OUTPUT)`. It returns the date of the next pending task of the given type in the output parameter. It returns the number of pending tasks as its return value.

**Business queries:**

1. Crew that completed the most tasks in October 2025.
2. Complaint reasons with more than 3 complaints without an assigned task.
3. Trees with no complaints.
4. The three tallest trees of each species.

## Technologies

- Microsoft SQL Server (T-SQL). The procedure uses `CREATE OR ALTER`, which needs SQL Server 2016 SP1 or later.
- SQL Server Management Studio (SSMS).
- [drawdb](https://www.drawdb.app/) for the diagram.

## Repository structure

```
sql/                                          database scripts
  01_crear_tablas_vistas_procedimiento.sql
  02_insertar_datos.sql
  03_ejemplos_de_uso.sql
assets/der_arbolado_publico.png               entity-relationship diagram
README.md                                     Spanish README
README.en.md                                  this file
```

## How to run it

1. Open SSMS and connect to a SQL Server instance.
2. Run `sql/01_crear_tablas_vistas_procedimiento.sql`. It creates the `TP_BBDD_G10` database and all its objects.
3. Run `sql/02_insertar_datos.sql`. It loads the sample data.
4. Run `sql/03_ejemplos_de_uso.sql`. It runs the queries, the views and the procedure.

Keep that order. The scripts are saved as UTF-8 with BOM so SSMS shows accents correctly. Script 01 does not drop the database if it already exists, so to reinstall you must drop `TP_BBDD_G10` first.

The comments in the scripts are in Spanish.

## Limitations

- The sample task dates are in 2025 and the procedure compares against `GETDATE()`. With a later current date, the example for case 1 returns `NULL` as the next date, even though the return value counts pending tasks.
- In the procedure, the next date only looks at tasks with a future estimated date. The pending count also includes overdue tasks.
- The `Mediciones` table keeps no history, so you cannot see how a tree grew.
- No `CHECK` constraint forces `Ubicacion` to have a plaza or a street.
- The sample data is small. It validates the logic but does not measure performance.
