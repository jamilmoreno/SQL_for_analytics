-- SESION 1 SQL

USE [TSQL]
GO

-- Consultas con SELECT:
/*
--  * (asterisco) en BD significa todo.
Seleccionando la tabla Sales.OrderDetails
*/

select * from sales.OrderDetails
go

-- Seleccionando la tabla Sales.Customers
select * from sales.Customers
go

-- Seleccionando la tabla Nums
select * from Nums
go

-- ** SELECCIONANDO COLUMNAS ESPECIFICAS DE UNA BD ** --

select 
    companyname,
	contactname,
	contacttitle,
	[address] -- (entre corchetes porque sale en azul)
	from sales.Customers
	go

--> Seleccionando Columnas con un ALIAS:

select 
    companyname as [Nombre de Compañia],
	contactname as [Nombre de Contacto] ,
	contacttitle as [Cargo de Empleado],
	[address] as [Direccion]
	from sales.Customers
	go

-- ** CONSULTAS CON WHERE ** --
select 
    custid,
    companyname,
	contactname,
	contacttitle,
	[address]
	from sales.Customers
	where custid = 8 -- Solo cuando quieres una obs
	
select 
    custid,
    companyname,
	contactname,
	contacttitle,
	[address]
	from sales.Customers
	where custid in (8,9,10) -- in-- Para seleccionar varias obs
	go


	select 
		custid,
		companyname,
		contactname,
		contacttitle,
		[address]
	from sales.Customers
	where custid > 15 -- custid mayores a 15
	go

-- EXCLUYENDO REGISTROS

	select 
		custid,
		companyname,
		contactname,
		contacttitle,
		[address]
	from sales.Customers
	where custid <> 8 -- custid -- Diferente a 8
	go


	select 
		custid,
		companyname,
		contactname,
		contacttitle,
		[address]
	from sales.Customers
	where custid != 8 -- custid -- Diferente a 8
	go

-- Excluir varios registros:
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address]
from Sales.Customers
where custid not in (8,9,10,11)
go

-- FILTRANDO un RANGO DE REGISTROS: BETWEEN
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address]
from Sales.Customers
where custid between 5 and 70
go

-- EXCLUYENDO un RANGO DE REGISTROS: BETWEEN
----> Funcion BETWEEN: Agrupar datos
----> Not: Negacion de la funcion en mencion
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address]
from Sales.Customers
where custid NOT between 5 and 70
go

--** Trabajando con mas Filtros **--
--------- OR  //  AND --------------
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address]
from Sales.Customers
where custid = 0 or custid = 9
go


select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address]
from Sales.Customers
where custid = 9 and postalcode = 10105
go


select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address]
	country
from Sales.Customers
where country = 'spain' -- Testo en comillas simples
go


--Filtrando por paises: Opcion 1
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address],
	country
from Sales.Customers
where country = 'spain' or country = 'france' or country = 'mexico'
go

--Filtrando por paises: Opcion 2
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address],
	country
from Sales.Customers
where country in ('spain','mexico','france')
go

-- Filtro	Multiple
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address],
	country
from Sales.Customers
where country in ('mexico','france') and contacttitle in ('sales manager','owner')
go

-- Filtrar Texto Incompleto: LIKE 'NN%'
select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address],
	country,
	city
from Sales.Customers
where city like 'ma%'
go


select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address],
	country,
	city
from Sales.Customers
where city like '%on'
go

select
	custid,
	companyname,
	contactname,
	contacttitle,
	[address],
	country,
	city
from Sales.Customers
where city like '%la%'
go
