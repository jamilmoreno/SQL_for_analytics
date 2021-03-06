CREATE DATABASE BD_PRUEBA

USE BD_PRUEBA
SELECT * FROM [dbo].[TB_CLIENTES]

-- CREANDO TABLA CON CODIGO:
CREATE TABLE TB_CLIENTES_2 (CODIGO CHAR(4), 
							NOMBRE VARCHAR(25),
							SEXO CHAR (1),
							EDAD NUMERIC(2,0))

-- INGRESAR DATOS A UNA TABLA:
INSERT INTO [dbo].[TB_CLIENTES] VALUES ('C003','PEDRO','M',18)
INSERT INTO [dbo].[TB_CLIENTES] VALUES ('C004','ANA','F',45)
INSERT INTO [dbo].[TB_CLIENTES] VALUES ('C005','JUAN','M',65)


SELECT * FROM [dbo].[TB_CLIENTES]

-- AGREGAR COLUMNA A NUESTRA TABLA:
ALTER TABLE [dbo].[TB_CLIENTES] ADD INGRESO FLOAT

-- ELIMINAR COLUMNA DE NUESTRA TABLA:
ALTER TABLE [dbo].[TB_CLIENTES] DROP COLUMN EMAIL

-- CAMBIAR TIPO DE DATO A UNA COLUMNA:
ALTER TABLE [dbo].[TB_CLIENTES] ALTER COLUMN SEXO VARCHAR(15)

-- COPIA DE SEGURIDAD A LA BD: BACKUP
--> BD_PRUEBA  -> CLICK DERECHO -> TAREAS (TASK) -> BACK UP

BACKUP DATABASE [BD_PRUEBA] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BD_PRUEBA.bak',  DISK = N'D:\Fundamentos SQL - DMC\Modulo 1\BACKUP_BDPRUEBA_22/09/2021' WITH NOFORMAT, NOINIT,  NAME = N'BD_PRUEBA-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- RESTABLECER COPIA DE SEGURIDAD:
--> DATABASES -> CLICK DERECHO -> RESTAURAR ARCHIVOS O GRUPOS DE ARCHIVO -> DESDE UN DISPOSITIVO -> AGREGAMOS LA RUTA -> TODOS LOS ARCHIVOS

-- IMPORTAR ARCHIVOS A SQL:
/*
1) TEXTO: BD_PRUEBA -> CLICK DERECHO -> TAREAS -> IMPORTAR DATOS -> TIPO DE DATO: FLAT FILE SOURCES -> NEXT...
*/

SELECT * FROM [dbo].[TB_VENTAS_TXT]

-- IMPORTAR ARCHIVOS DE EXCEL XLS:
--2) EXCEL: BD_PRUEBA -> CLICK DERECHO -> TAREAS -> IMPORTAR DATOS -> TIPO DE DATO: MICROSOFT EXCEL -> NEXT...

SELECT * FROM [dbo].[TB_DISTRIBUIDORES]
SELECT * FROM [dbo].[TB_PEDIDOS]

-- IMPORTAR ARCHIVO ACCESS
--3) ACCESS: BD_PRUEBA -> CLICK DERECHO -> TAREAS -> IMPORTAR DATOS -> TIPO DE DATO: MICROSOFT ACCESS -> NEXT...

SELECT * FROM [dbo].[TB_CLIENTES_ADICIONALES]
SELECT * FROM [dbo].[CLIENTES_PERU]

-- EXPORTAR A UN EXCEL:
--> BD_PRUEBA -> CLICK DERECHO -> TAREAS -> EXPORTAR -> ORIGEN DE LOS DATOS: SERVIDOS SQL NATIVO CLIENTE -> DESTINO: EXCEL....
