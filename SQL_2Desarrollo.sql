USE BANCO

---- CLAUSULAS BÁSICAS

--1. Listar todos los campos de la tabla cliente perfil.

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]


--2. Mostrar solo los campos código, sexo y fecha de nacimiento.

SELECT CODIGO,SEXO,FH_NACIMIENTO FROM [dbo].[TB_CLIENTE_PERFIL]

--3. Mostrar solo los clientes del sexo masculino.

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE SEXO = 'M'

--4. Cuántos clientes tienen teléfono.

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE TIENE_TELEFONO = 'S'

--5. Listar a los 10 clientes con mayores ingresos.

SELECT top 10 * FROM [dbo].[TB_CLIENTE_PERFIL]
order by INGRESO DESC

--6. Listar al 20% de clientes con mayor rentabilidad.

SELECT TOP 20 PERCENT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
ORDER BY RENTABILIDAD DESC


---- OPERADORES LÓGICOS

--1. Clientes que tienen teléfono y email.

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE TIENE_TELEFONO = 'S' AND TIENE_CORREO = 'S'

--2. Clientes sin ingreso especificado o valor 0. 

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE INGRESO = 0 OR INGRESO =  NULL

--3. Clientes que hayan usado banca por internet o cajero.

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE USO_AGENCIA = 'S' OR USO_INTERNET =  'S'

--4. Listado de todos los préstamos. No considerar los préstamos vehiculares, 
--comerciales y empresariales.

SELECT * FROM [dbo].[TB_TIPO_PRESTAMO]
--('V001','C002','C001')
SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]
WHERE COD_PRODUCTO NOT IN ('V001','C002','C001')


SELECT * FROM [dbo].[TB_TIPO_PRESTAMO]
--('V001','C002','C001')
SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]
WHERE COD_PRODUCTO IN ('V001','C002','C001')


---- OPERADORES DE COMPARACION

--1. Clientes con saldo pasivo menor a 10,000 soles.

SELECT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
WHERE SALDO_PASIVO < 10000

--2. Clientes con rentabilidad mayor igual a 250 soles/mes.

SELECT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
WHERE RENTABILIDAD >= 250

--3. Clientes con ingreso igual 5000 soles. 

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE INGRESO = '5000'

--4. Clientes con saldos activos entre 1500 y 3500 soles

SELECT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
WHERE SALDO_ACTIVO BETWEEN 1500 AND 3500

SELECT * FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
WHERE SALDO_ACTIVO >= 1500 AND SALDO_ACTIVO <= 3500

--5. Clientes que tengan préstamos hipotecarios.
SELECT * FROM [dbo].[TB_TIPO_PRESTAMO]

SELECT * FROM [dbo].[TB_CLIENTE_PRESTAMOS]
WHERE COD_PRODUCTO LIKE 'H%'

--6. Clientes que solo sean del segmento Premium.

SELECT * FROM [dbo].[TB_SEGMENTO]

SELECT * FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE COD_SEGMENTO IN ('288011','9288022')


---- FUINCIONES DE AGREGADO

--1. Determinar el número de clientes que tienen un préstamo.

SELECT COUNT (*) Numero_Clientes FROM [dbo].[TB_CLIENTE_PRESTAMOS]

--2. Determinar la suma total del saldo pasivo de todos los clientes.

SELECT SUM(SALDO_PASIVO)  FROM [dbo].[TB_CLIENTE_RENTABILIDAD]

--3. Determinar el promedio de saldo activo de todos los clientes.

SELECT AVG(SALDO_ACTIVO) FROM [dbo].[TB_CLIENTE_RENTABILIDAD]

--4. Determinar el desembolso máximo de préstamo.

SELECT MAX(DESEMBOLSO) FROM [dbo].[TB_CLIENTE_PRESTAMOS]

--5. Determinar el desembolso mínimo de préstamo.

SELECT MIN(DESEMBOLSO) FROM [dbo].[TB_CLIENTE_PRESTAMOS]


--6. Determinar el desembolso promedio de préstamo.

SELECT AVG(DESEMBOLSO) FROM [dbo].[TB_CLIENTE_PRESTAMOS]


--7. Determinar el número de clientes por agencia, detallando el total de la 
--masa salarial y el promedio de ingreso

SELECT COD_AGENCIA, COUNT(CODIGO) AS CLIENTES, SUM(INGRESO) AS TOTAL_INGRESOS, AVG(INGRESO) AS PROMEDIO_INGRESOS
FROM [dbo].[TB_CLIENTE_PERFIL]
GROUP BY COD_AGENCIA