-- MODULO 3
-- FUNCIONES DE FECHA:

--Mostrar los clientes mayores de 35 años

SELECT CODIGO, FH_NACIMIENTO, (2022-YEAR(FH_NACIMIENTO)) AS EDAD FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE 2022-YEAR(FH_NACIMIENTO) > 35

SELECT CODIGO, FH_NACIMIENTO, DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) AS EDAD
FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) > 35

--Generar una variable de envió de kit de bienvenida 15 días posteriores a la fecha de alta del cliente.

SELECT CODIGO, FH_ALTA, DATEADD(DAY,15,FH_ALTA) AS FECHA_BIENVENIDA FROM [dbo].[TB_CLIENTE_PERFIL]

--Generar la tabla que contenga el código cliente, fecha desembolso préstamo, fecha_vencimiento, 
--un campo Fecha_CampañaRenovacion 20 días antes de la fecha de vencimiento del contrato. 

SELECT CODIGO, 
	   FECHA_ALTA,
	   FECHA_VENCIMIENTO,
	   DATEADD(DAY,-20,FECHA_VENCIMIENTO) AS FECHA_RENOVACION 
	   INTO TB_CAMPAÑA_RENOVACION_PRESTAMOS -- CON INTO CREAMOS UNA TABLA CON LA CONSULTA
FROM [dbo].[TB_CLIENTE_PRESTAMOS]


SELECT * FROM [dbo].[TB_CAMPAÑA_RENOVACION_PRESTAMOS]

--Crear una tabla que contenga el código del cliente, fecha de nacimiento, el día, mes, año
--y el descriptivo del mes de cumpleaños y guardarlo en una tabla de nombre TB_MesCumpleañosClientes.

SELECT CODIGO,
	   FH_NACIMIENTO,
	   DAY(FH_NACIMIENTO) AS DIA,
	   MONTH(FH_NACIMIENTO) AS MES,
	   YEAR(FH_NACIMIENTO) AS AÑO,
	   DATENAME(MONTH,FH_NACIMIENTO) AS MES_NACIMIENTO
from [dbo].[TB_CLIENTE_PERFIL]


-- FUNCIONES DE TEXTO:

--Hacer la sintaxis de que remplace en la variable sexo el detalle del carácter descriptivo ‘M’ por ‘Masculino’.

SELECT CODIGO,
	   SEXO,
	   REPLACE(SEXO,'M','Masculino') AS SEXO_DETALLE
	   -- REPLACE(SEXO,'F','Femenino') AS SEXO_DETALLE
FROM [dbo].[TB_CLIENTE_PERFIL]

--Hacer la sintaxis para extraer el primer carácter del tipo de préstamo.

SELECT CODIGO,
	  LEFT(COD_PRODUCTO,1) AS LETRA_PRODUCTO
FROM [dbo].[TB_CLIENTE_PRESTAMOS]

--Extraer del código de clientes  los 4 caracteres a partir de la posición 2, en la tabla de clientes perfil

SELECT SUBSTRING(CODIGO,2,4) FROM [dbo].[TB_CLIENTE_PERFIL]

--Determinar el numero máximo de caracteres del detalle de los distritos en la tabla ubigeo.  

SELECT DISTRITO, LEN(DISTRITO) AS LETRAS FROM [dbo].[TB_UBIGEO]
ORDER BY 2 DESC -- 2 HACE MENCION A LA SEGUNDA COLUMNA

--Extraer los 3 últimos dígitos del tipo de prestamos.

SELECT RIGHT(COD_PRODUCTO,3) FROM [dbo].[TB_TIPO_PRESTAMO]


-- FUNCIONES MATEMATICAS:

--Crear una tabla con los campos código, saldo activo, saldo pasivo y volumen de negocio (saldo activo + saldo pasivo)

SELECT CODIGO, SALDO_ACTIVO,SALDO_PASIVO, (SALDO_ACTIVO+SALDO_PASIVO) AS [VOLUMEN DE NEGOCIO] FROM [dbo].[TB_CLIENTE_RENTABILIDAD]

--Hacer el calculo del nivel aproximado de nivel de endeudamiento del cliente que representa el 30% de su ingreso.

SELECT INGRESO, (INGRESO*0.3) AS [NIVEL DE ENDEUDAMIENTO] FROM [dbo].[TB_CLIENTE_PERFIL]
WHERE (INGRESO*0.3) >0

--Detallar el código del cliente, ingreso, su ingreso elevado al cuadrado y la raíz cuadrada de su ingreso. 
SELECT CODIGO, INGRESO, POWER(INGRESO,2) AS CUADRADO_INGRESO, SQRT(INGRESO) AS RAIZ_INGRESO  FROM [dbo].[TB_CLIENTE_PERFIL]

-- FUNCIONES DE CONVERSION:

--Crear una tabla código y un campo que especifique el siguiente texto: “El ingreso del cliente es: @ingreso soles” , usando la función CAST.

SELECT CODIGO, INGRESO, 'El ingreso es de '+ CAST(INGRESO AS varchar(30))+' soles' as Ingreso_texto 
FROM [dbo].[TB_CLIENTE_PERFIL]

--Crear una tabla código y un campo que especifique el siguiente texto: “El ingreso del cliente es: @ingreso soles” , usando la función CONVERT.

SELECT CODIGO, INGRESO, 'El ingreso es de '+ CONVERT(varchar(30),INGRESO)+' soles' as Ingreso_texto 
FROM [dbo].[TB_CLIENTE_PERFIL]

-- FUNCIONES CONDICIONALES:

--Crear una vista  con los siguientes campos: código, fecha nacimiento, 
-- edad y rango de edad (<18,18-25,26-35, 36-40, 41-50,51-65, +65 años)

CREATE VIEW VW_CLIENTE_RANGO_EDAD
AS
SELECT CODIGO,FH_NACIMIENTO,DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) AS EDAD,
CASE 
	WHEN DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE())<18                THEN '1.MENOR DE 18'
	WHEN DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) BETWEEN 18 AND 25 THEN '2.DE 18 A 25'
	WHEN DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) BETWEEN 26 AND 35 THEN '3.DE 26 A 35'
	WHEN DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) BETWEEN 36 AND 40 THEN '4.DE 36 A 40'
	WHEN DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) BETWEEN 41 AND 50 THEN '5.DE 41 A 50'
	WHEN DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) BETWEEN 51 AND 65 THEN '6.DE 51 A 65'
ELSE '7.MAYOR A 65'
END AS RANGO_EDAD
	--WHEN DATEDIFF(YEAR,FH_NACIMIENTO,GETDATE()) > 65			  THEN '7.MAYOR A 65'
FROM [dbo].[TB_CLIENTE_PERFIL]

SELECT * FROM [dbo].[VW_CLIENTE_RANGO_EDAD]


--Crear una tabla código, saldo activo, saldo pasivo, rentabilidad, volumen de negocio (saldo activo + saldo pasivo), ratio de rentabilidad rentabilidad / (volumen de negocio)

-- FILTRANDO OBS
SELECT *, SALDO_ACTIVO+SALDO_PASIVO AS VOLUMEN, RENTABILIDAD/(SALDO_ACTIVO+SALDO_PASIVO) AS RATIO
FROM [dbo].[TB_CLIENTE_RENTABILIDAD]
WHERE SALDO_ACTIVO+SALDO_PASIVO>0

-- SIN FILTRAR:
SELECT *, SALDO_ACTIVO+SALDO_PASIVO AS VOLUMEN, 
CASE WHEN SALDO_ACTIVO+SALDO_PASIVO>0 THEN RENTABILIDAD/(SALDO_ACTIVO+SALDO_PASIVO)
ELSE 0
END AS RATIO
FROM [dbo].[TB_CLIENTE_RENTABILIDAD]

--Crear un campo que detalle si el cliente tiene ingreso superior a 3500 soles 

SELECT CODIGO,INGRESO,
CASE WHEN INGRESO>3500 THEN 'Cliente Ingreso > 3500 Soles'
ELSE 'Ingreso < 3500 Soles'
END AS DETALLE_CLIENTE
FROM [dbo].[TB_CLIENTE_PERFIL]