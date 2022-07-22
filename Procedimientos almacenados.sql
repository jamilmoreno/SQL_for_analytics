
USE ANUNCIOS

select * from [dbo].[carros_corregido]
SELECT max(a.ano) FROM [dbo].[carros_corregido] as a
where Marca='ford'


-- PROCEDIMIENTOS ALMACENADOS
CREATE PROCEDURE reporte1 @marca varchar(30) as
select * from [dbo].[carros_corregido]
where Marca=@marca and registration = 'yes' and ano = (SELECT max(a.ano) FROM [dbo].[carros_corregido] as a
where Marca=@marca)

exec reporte1 'maserati'
exec reporte1 'nissan'

-- Borrar procedimiento:
-- drop procedure reporte1


-- Procedimiento Almacenado con varios parámetros.

CREATE PROCEDURE reporte2 @precio_min int, @precio_max int, @ano_min int
as
select * from [dbo].[carros_corregido]
where Precio>= @precio_min and Precio<= @precio_max and ano >= @ano_min and registration='yes';


exec reporte2 1500, 4000, 2014

-- Ejemplo 3: Reporte con los bodys mas caros por cada marca:

-- Consulta:
select * from [dbo].[carros_corregido] 
where Marca = 'ford' and body = (
select top 1 body from [dbo].[carros_corregido] as a  where a.Marca='ford' order by Precio desc)

-- Procedimiento almacenado:
drop procedure reporte3_body_top_marca

CREATE PROCEDURE reporte3_body_top_marca @marca varchar(30)
as
select * from [dbo].[carros_corregido] 
where Marca = @marca and body = (
select top 1 body from [dbo].[carros_corregido] as a  where a.Marca=@marca order by Precio desc)


exec reporte3_body_top_marca 'ford'
exec reporte3_body_top_marca 'nissan'


/* Ejercicio: Crear un procedure con dos parámetros: marca y modelo
Devolver el minimo, maximo, y promedio precio para cada año */
select * from [dbo].[carros_corregido]
where Marca = 'toyota'

CREATE PROCEDURE reporte3 @marca varchar (30), @modelo varchar (30)
as
select ano as Año, min(precio)as precio_min, MAX(precio) as precio_max from [dbo].[carros_corregido]
where Marca =@marca and model = @modelo
group by ano

exec reporte3 'Toyota','Camry'
