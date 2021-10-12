USE [TSQL]

/* TIPOS DE DATOS:

- NÚMEROS: int, smallint, bigint, bit, decimal(10,2)
- Cadena de Caracteres: char. varchar, nchar, nvarchar
- TIEMPO: date, datetime, smalldatetime
*/

-- CREANDO MI PRIMERA TABLA:

create table MiPrimeraTabla
(	
	IdPersona int identity(1,1) primary key,
	Dni int,
	NombreCompleto varchar(80),
	MesCumpleaños char(3)
)

select *
from MiPrimeraTabla
go
-- Si no carga: Edit -> IntelliSense -> Refresh Local Cache

-- INSERTANDO DATOS: Forma 1

insert into MiPrimeraTabla
values(75391693,'Jamil Moreno','Abr','veinte'),
	  (25752434,'Elmer Moreno','Mar'),
	  (45628495, 'Eduardo Lara','Jun')

-- INSERTANDO DATOS: Forma 2

insert into MiPrimeraTabla (Dni,NombreCompleto,MesCumpleaños) -- SE PUEDE PONER EL NOMBRE DE LAS COLUMNAS A COMPLETAR
SELECT postalcode, contactname,'Oct'
from Sales.Customers
where custid<=4
go


--	EDITANDO DATOS:
update MiPrimeraTabla
set MesCumpleaños = 'Dic'
where IdPersona = 6
go


-- ELIMINAR DATO:

--->Eliminar un dato
delete from MiPrimeraTabla where IdPersona = 7

--->Eliminar varios datos
delete from MiPrimeraTabla where IdPersona in (7,8,9)

--->Eliminar un rango de datos
delete from	MiPrimeraTabla where IdPersona between(1,5)

--->Eliminar todos los datos de la tabla: reseteando el id
truncate table MiPrimeraTabla
go

-- AGREGAR COLUMNA A MI TABLA:

alter table  MiPrimeraTabla add Edad int
go

-- Modificar caracteristica del campo creado:
alter table MiPrimeraTabla alter column	Edad varchar(20)
go

--ELIMINAR UNA COLUMNA:
alter table MiPrimeraTabla drop column Edad

-- ELIMINAR TODA LA TABLA:
drop table MiPrimeraTabla


-------------- OJO ----------------
/* 
DELETE: Elimino registros y/datos.
DROP: Elimino objetos (columnas, tablas) */

-- CAMBIAR NOMBRE DE COLUMNA:
exec sp_rename 'MiPrimeraTabla.MesCumpleaaños', 'MesCumpleaños', 'Column'

-- min 1:37

-- CAMBIANDO DATO NULL PARA EJERCICIO:

update Sales.Customers
set region = ' '
where custid = 1


select *
from Sales.Customers

-- CONSULTA CON NULL

--> Registros que no tienen fax:
select*
from sales.Customers
where fax is null
go

--> Registros que tienen fax:
select*
from sales.Customers
where fax is not null
go


select
	companyname,
	phone,
	fax,
	coalesce(fax,phone,'No tiene') as Numero-- Funcion q si devuelve nulo un valor, busca de otra variable mencionada, si no deja texto.
from Sales.Customers
go

------- CONSULTAS CON ORDER BY ---------
--->	Caso 1
select*
from Production.Products
order by unitprice desc --(asc)
go

--->	Caso 2: Primero ordena por categoria y luego por precio.
select*
from Production.Products
order by categoryid,unitprice asc
go

--->	Caso 2: Con numeros como indice
select*
from Production.Products
order by 4,5 asc
go

------- CONSULTAS CON: GROUP BY ----------

select orderid,empid,custid 
from Sales.Orders

---> Conteo de ordenes por cada empleado:
select empid,count(orderid) as Conteo
from Sales.Orders
group by empid

---> FILTRANDO UN GROUP BY: HAVING
select empid,count(orderid) as Conteo
from Sales.Orders
group by empid
having COUNT(orderid) > 100


---> Ordenando con ORDER BY:
select empid,count(orderid) as Conteo
from Sales.Orders
group by empid
having count(orderid) > 100
order by count(orderid) asc

/* ORDEN DE UNA CONSULTA:

1. select
2. from
3. where
4. group by
5.having
6. order by 
*/


------- CONSULTAS CON CASE SIMPLE --------
select unitprice,
	case unitprice when 10
		then 'Tiene un premio' else 'Siga Intentando' end Categoria
from Production.Products


select unitprice,
	case unitprice when 10
		then 'Tiene un premio' end Categoria -- sin "else" se pone NULL por defecto
from Production.Products

/* Si precio es menor o igual a 8: Precio Bajo
   Si precio es mayor a 8 y menor o igual a 15: Precio Medio
   Si precio es mayor a 15 y menor o igual a 45: Precio Medio Alto
   Si precio es mayor a 45: Precio Alto 
   Si no hay precio: No tiene precio.
*/

select unitprice,
	case when unitprice <=8 then 'Precio Bajo'
			when unitprice > 8 and unitprice <= 15 then 'Precio Medio'
				when unitprice > 15 and unitprice <= 45 then 'Precio Medio Alto'
					when unitprice > 45 then 'Precio Alto' else 'No tiene Precio' end Categoria
from Production.Products
order by unitprice asc
go


------ CONSULTAS CON TOP -------

select top 9 unitprice, productname -- Muestra las primeras 9 filas (head)
from Production.Products
order by unitprice asc
go


select top 9 with ties unitprice, productname -- Muestra las primeras 9 filas y aumenta si hay empate
from Production.Products
order by unitprice asc
go

----- CONSULTAS CON JOIN -----
--> Replicar las tablas:
SELECT*
INTO Cliente
FROM Sales.Customers

SELECT*
INTO Ordenes
FROM Sales.Orders

-- INNER JOIN:
SELECT
	O.orderid,
	O.orderdate,
	O.custid,
	C.companyname,
	C.contactname,
	C.country
FROM Cliente as C
INNER JOIN Ordenes as O
ON C.custid = O.custid

-- LEFT JOIN:
SELECT 
	O.orderid,
	O.orderdate,
	O.custid,
	C.companyname,
	C.contactname,
	C.country
FROM Cliente as C
LEFT JOIN Ordenes as O
ON C.custid = O.custid

-- RIGHT JOIN:
SELECT
	O.orderid,
	O.orderdate,
	O.custid,
	C.companyname,
	C.contactname,
	C.country,
	C.contacttitle
FROM Ordenes as O
RIGHT JOIN Cliente as C
ON O.custid = C.custid
	
--- FULL JOIN
SELECT
	O.orderid,
	O.orderdate,
	O.custid,
	C.companyname,
	C.contactname,
	C.country,
	C.contacttitle
FROM Ordenes as O
FULL JOIN Cliente as C
ON O.custid = C.custid

-- SEFT JOIN
EXEC sp_changedbowner 'DESKTOP-11ML0GK\Jamil MG'

SELECT *
	--CONCAT(j.lastname,' ',j.firstname,' ',j.title) as Jefej
	--s.lastname+' '+s.firsname+' 's.title as Empleado
FROM hr.Employees as j
INNER JOIN hr.Employees as s
ON j.empid = s.mgrid