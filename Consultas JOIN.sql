---- CREAMOS NUESTRA BD Y TABLAS ----

CREATE DATABASE TestJoin
GO

USE TestJoin
GO

CREATE TABLE Departamentos
(
    Id int,
    Nombre varchar(20)
);

CREATE TABLE Empleados
(
    Nombre varchar(20),
    DepartamentoId int
);

INSERT INTO Departamentos VALUES(31, 'Sales');
INSERT INTO Departamentos VALUES(33, 'Engineering');
INSERT INTO Departamentos VALUES(34, 'Clerical');
INSERT INTO Departamentos VALUES(35, 'Marketing');

INSERT INTO Empleados VALUES('Rafferty', 31);
INSERT INTO Empleados VALUES('Jones', 33);
INSERT INTO Empleados VALUES('Heisenberg', 33);
INSERT INTO Empleados VALUES('Robinson', 34);
INSERT INTO Empleados VALUES('Smith', 34);
INSERT INTO Empleados VALUES('Williams', NULL);

--- CONFIRMAMOS LAS TABLAS: ----

SELECT * FROM Empleados;
SELECT * FROM Departamentos;

--- CLAUSULA INNER JOIN ---

--> Solo se muestra la interseccion:
SELECT *
FROM Empleados E
INNER JOIN Departamentos D
ON E.DepartamentoId = D.Id

--> Solo trayendo columnas especificas:
SELECT 
	E.Nombre as 'Empleado',
	D.Nombre as 'Departamento'
FROM Empleados E
JOIN Departamentos D
ON E.DepartamentoId = D.Id

--- CONSULTAS LEFT JOIN ---
--> Todos los resultados de la primera tabla se muestran:
SELECT *
	--E.Nombre as 'Empleado',
	--D.Nombre as 'Departamento'
FROM Empleados E
LEFT JOIN Departamentos D
ON E.DepartamentoId = D.Id

--- CLAUSULAS RIGHT JOIN ---
SELECT 
	E.Nombre as 'Empleado',
	D.Nombre as 'Departamento'
FROM Empleados E
RIGHT JOIN Departamentos D
ON E.DepartamentoId = D.Id 

---- CLAUSULA FULL JOIN ----
--> Muestra todas las filas de ambas tablas.
SELECT *
FROM Empleados E
FULL JOIN Departamentos D
ON E.DepartamentoId = D.Id


