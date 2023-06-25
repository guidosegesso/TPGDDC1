-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 1--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- En esta sección se borrarán los objetos previamente creados

-- Borrado de vistas
IF OBJECT_ID('FUSECHUDA.MayorCantidadPedidos','V') IS NOT NULL
  DROP VIEW FUSECHUDA.MayorCantidadPedidos
IF OBJECT_ID('FUSECHUDA.CalificacionPromedio','V') IS NOT NULL
  DROP VIEW FUSECHUDA.CalificacionPromedio
IF OBJECT_ID('FUSECHUDA.MontoCuponesReclamos','V') IS NOT NULL
  DROP VIEW FUSECHUDA.MontoCuponesReclamos
IF OBJECT_ID('FUSECHUDA.ReclamosMensuales','V') IS NOT NULL
  DROP VIEW FUSECHUDA.ReclamosMensuales
IF OBJECT_ID('FUSECHUDA.MontoTotalCupones','V') IS NOT NULL
  DROP VIEW FUSECHUDA.MontoTotalCupones
IF OBJECT_ID('FUSECHUDA.PromedioMensualAsegurado','V') IS NOT NULL
  DROP VIEW FUSECHUDA.PromedioMensualAsegurado  

-- Borrado de tablas
IF OBJECT_ID('FUSECHUDA.BI_Tiempo','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Tiempo
IF OBJECT_ID('FUSECHUDA.BI_Dia','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Dia
IF OBJECT_ID('FUSECHUDA.BI_Rango_Horario','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Rango_Horario
IF OBJECT_ID('FUSECHUDA.BI_Provincia_Localidad','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Provincia_Localidad
IF OBJECT_ID('FUSECHUDA.BI_Rango_Etario','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Rango_Etario
IF OBJECT_ID('FUSECHUDA.BI_Tipo_Medio_de_Pago','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Tipo_Medio_de_Pago
IF OBJECT_ID('FUSECHUDA.BI_Local','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Local
IF OBJECT_ID('FUSECHUDA.BI_Medios_de_Pago','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Medios_de_Pago
IF OBJECT_ID('FUSECHUDA.BI_Categoria_Tipo','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Categoria_Tipo
IF OBJECT_ID('FUSECHUDA.BI_Movilidad','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Movilidad
IF OBJECT_ID('FUSECHUDA.BI_Tipo_Paquete','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Tipo_Paquete
IF OBJECT_ID('FUSECHUDA.BI_Estado_Pedido','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Estado_Pedido
IF OBJECT_ID('FUSECHUDA.BI_Estado_Mensajeria','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Estado_Mensajeria
IF OBJECT_ID('FUSECHUDA.BI_Estado_Reclamo','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Estado_Reclamo
IF OBJECT_ID('FUSECHUDA.BI_Usuario','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Usuario
IF OBJECT_ID('FUSECHUDA.BI_Pedidos','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Pedidos
IF OBJECT_ID('FUSECHUDA.BI_Mensajeria','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Mensajeria
IF OBJECT_ID('FUSECHUDA.BI_Reclamos','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Reclamos   
IF OBJECT_ID('FUSECHUDA.BI_CuponesReclamos','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_CuponesReclamos  
IF OBJECT_ID('FUSECHUDA.BI_CuponesPedidos','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_CuponesPedidos    
  
GO
-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 2--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en la creeación del Esquema, Tablas y Vistas

-- CREACION DEL ESQUEMA
IF not EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'FUSECHUDA')
  EXEC ('CREATE SCHEMA FUSECHUDA')
GO

GO

-- CREACION DE LAS DIMENSIONES
CREATE TABLE FUSECHUDA.BI_Tiempo
(
	[ID_TIEMPO] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	AÑO [decimal](4,0) NOT NULL,
	MES [decimal](2,0) NOT NULL
)

CREATE TABLE FUSECHUDA.BI_Dia
(
	ID_DIA [decimal](18, 0) NOT NULL,
	DIA NVARCHAR(50)
)
GO

CREATE TABLE FUSECHUDA.BI_Rango_Horario
(
	ID_RANGO_HORARIO [decimal](18, 0) IDENTITY(1,1) NOT NULL ,
	HORA_INICIAL time,
	HORA_FINAL time,
	DESCRIPCION NVARCHAR(50)
)
GO

CREATE TABLE FUSECHUDA.BI_Provincia_Localidad
(
	ID [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	ID_LOCALIDAD [decimal](18, 0),
	NOMBRE_LOCALIDAD NVARCHAR(255),
	ID_PROVINCIA [decimal](18, 0),
	NOMBRE_PROVINCIA NVARCHAR(255)
)
GO

CREATE TABLE FUSECHUDA.BI_Rango_Etario
(
	ID_RANGO_ETARIO [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	EDAD_INICIAL [decimal](18, 0),
	EDAD_FINAL [decimal](18, 0),
	DESCRIPCION NVARCHAR(25)
)
GO

CREATE TABLE FUSECHUDA.BI_Tipo_Medio_de_Pago
(
	ID_MEDIO_DE_PAGO [decimal](18, 0),
	TIPO NVARCHAR(255)	
)
GO

CREATE TABLE FUSECHUDA.BI_Local
(
	ID_LOCAL [decimal](18, 0) ,
	NOMBRE NVARCHAR(100),
	DESCRIPCION NVARCHAR(255),
	ID_CATEGORIA [decimal](18, 0),
	DIRECCION NVARCHAR(255),
	ID_LOCALIDAD [decimal](18, 0),
	ID_PROVINCIA [decimal](18, 0)
)
GO

CREATE TABLE FUSECHUDA.BI_Categoria_Tipo
(
	ID [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	ID_TIPO [decimal](18, 0),
	NOMBRE_TIPO NVARCHAR(255),
	ID_CATEGORIA [decimal](18, 0),
	NOMBRE_CATEGORIA NVARCHAR(255)
)
GO

CREATE TABLE FUSECHUDA.BI_Movilidad
(
	ID_MOVILIDAD [decimal](18, 0) ,
	MOVILIDAD NVARCHAR(50)
)
GO

CREATE TABLE FUSECHUDA.BI_Tipo_Paquete
(
	TIPO NVARCHAR(50),
	ALTO_MAX [decimal](18, 2),
	LARGO_MAX [decimal](18, 2),
	ANCHO_MAX [decimal](18, 2),
	PESO_MAX [decimal](18, 2),
	PRECIO [decimal](18, 2)
)
GO

CREATE TABLE FUSECHUDA.BI_Estado_Pedido
(
	ID_ESTADO [decimal](18, 0),
	DESCRIPCION NVARCHAR(50)
)
GO

CREATE TABLE FUSECHUDA.BI_Estado_Mensajeria
(
	ID_ESTADO [decimal](18, 0),
	DESCRIPCION NVARCHAR(50)
)
GO

CREATE TABLE FUSECHUDA.BI_Estado_Reclamo
(
	ID_ESTADO [decimal](18, 0),
	DESCRIPCION NVARCHAR(50)
)
GO

CREATE TABLE FUSECHUDA.BI_Usuario
(
	ID_USUARIO [decimal](18, 0),
	DNI [decimal](18, 0),
	NOMBRE NVARCHAR(255),
	APELLIDO  NVARCHAR(255),
	TELEFONO [decimal](18, 0),
	MAIL NVARCHAR(255),
	FECHA_NAC DATE,
	FECHA_REGISTRO DATETIME2(3)
)
GO

CREATE TABLE FUSECHUDA.BI_CuponesReclamos
(
	CUPON_NRO [decimal](18, 0),
	RECLAMO_NRO [decimal](18, 0),
	TIPO_CUPON [decimal](18, 0),
	MONTO [decimal](18, 2),
	FECHA_ALTA DATETIME,
	FECHA_VENCIMIENTO DATETIME
)
GO

CREATE TABLE FUSECHUDA.BI_CuponesPedidos
(
	CUPON_NRO [decimal](18, 0),
	PEDIDO_NRO [decimal](18, 0),
	TIPO_CUPON NVARCHAR(50),
	MONTO [decimal](18, 2),
	FECHA_ALTA DATETIME,
	FECHA_VENCIMIENTO DATETIME
)
GO

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 3--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en completar las tablas con sus respectivos datos

INSERT INTO FUSECHUDA.BI_Tiempo 
SELECT DISTINCT * FROM (
	SELECT DISTINCT DATEPART(YEAR,FECHA) Año, DATEPART(MONTH,FECHA) Mes FROM FUSECHUDA.PEDIDO								UNION ALL
	SELECT DISTINCT DATEPART(YEAR,FECHA_MENSAJERIA), DATEPART(MONTH,FECHA_MENSAJERIA) FROM FUSECHUDA.SERVICIO_MENSAJERIA	UNION ALL
	SELECT DISTINCT DATEPART(YEAR,FECHA), DATEPART(MONTH,FECHA) FROM FUSECHUDA.RECLAMO
	) T
ORDER BY Año, Mes
GO

INSERT INTO FUSECHUDA.BI_Dia (ID_DIA, DIA)
SELECT ID_DIA, DIA FROM FUSECHUDA.DIAS
GO

INSERT INTO FUSECHUDA.BI_Rango_Horario (HORA_INICIAL, HORA_FINAL, DESCRIPCION)
SELECT '00:00:00', '01:59:59', '00:00 - 01:59'  UNION ALL
SELECT '02:00:00', '03:59:59', '02:00 - 03:59' UNION ALL
SELECT '04:00:00', '05:59:59', '04:00 - 05:59' UNION ALL
SELECT '06:00:00', '07:59:59', '06:00 - 07:59' UNION ALL
SELECT '08:00:00', '09:59:59', '08:00 - 09:59' UNION ALL
SELECT '10:00:00', '11:59:59', '10:00 - 11:59' UNION ALL
SELECT '12:00:00', '13:59:59', '12:00 - 13:59' UNION ALL
SELECT '14:00:00', '15:59:59', '14:00 - 15:59' UNION ALL
SELECT '16:00:00', '17:59:59', '16:00 - 17:59' UNION ALL
SELECT '18:00:00', '19:59:59', '18:00 - 19:59' UNION ALL
SELECT '20:00:00', '21:59:59', '20:00 - 21:59' UNION ALL
SELECT '22:00:00', '23:59:59', '22:00 - 23:59' 
GO

INSERT INTO FUSECHUDA.BI_Provincia_Localidad (ID_PROVINCIA, NOMBRE_PROVINCIA, ID_LOCALIDAD, NOMBRE_LOCALIDAD)
SELECT  loc.ID_PROVINCIA, prov.PROVINCIA, loc.ID_LOCALIDAD, loc.LOCALIDAD
FROM FUSECHUDA.LOCALIDAD loc
LEFT JOIN FUSECHUDA.PROVINCIA prov ON prov.ID_PROVINCIA = loc.ID_PROVINCIA
GO

INSERT INTO FUSECHUDA.BI_Rango_Etario (EDAD_INICIAL, EDAD_FINAL, DESCRIPCION)
SELECT 0, 24 , '< 24' UNION ALL
SELECT 25, 34, '25 - 34'  UNION ALL
SELECT 35, 55, '35 - 55' UNION ALL
SELECT 56, 200, '> 55'
GO

INSERT INTO FUSECHUDA.BI_Tipo_Medio_de_Pago (ID_MEDIO_DE_PAGO, TIPO)
SELECT ID_MEDIO_DE_PAGO, TIPO 
FROM FUSECHUDA.MEDIOS_DE_PAGO
GO

INSERT INTO FUSECHUDA.BI_Local
SELECT * FROM FUSECHUDA.[LOCAL]
GO


INSERT INTO FUSECHUDA.BI_Categoria_Tipo (ID_CATEGORIA, NOMBRE_CATEGORIA, ID_TIPO, NOMBRE_TIPO)
SELECT DISTINCT CAT.ID_CATEGORIA, cat.NOMBRE_CATEGORIA, tipo.ID_TIPO, tipo.NOMBRE
FROM FUSECHUDA.CATEGORIA cat
LEFT JOIN FUSECHUDA.CATEGORIA_TIPO tipo ON tipo.ID_TIPO = cat.ID_TIPO
--WHERE cat.NOMBRE_CATEGORIA IS NOT NULL AND tipo.NOMBRE IS NOT NULL
GO

INSERT INTO FUSECHUDA.BI_Movilidad
SELECT * FROM FUSECHUDA.MOVILIDAD
GO

INSERT INTO FUSECHUDA.BI_Tipo_Paquete
SELECT * FROM FUSECHUDA.PAQUETE
GO

INSERT INTO FUSECHUDA.BI_Estado_Pedido
SELECT * FROM FUSECHUDA.PEDIDO_ESTADO
GO

INSERT INTO FUSECHUDA.BI_Estado_Mensajeria
SELECT * FROM FUSECHUDA.MENSAJERIA_ESTADO
GO

INSERT INTO FUSECHUDA.BI_Estado_Reclamo
SELECT * FROM FUSECHUDA.RECLAMO_ESTADO
GO

INSERT INTO FUSECHUDA.BI_Usuario (ID_USUARIO, DNI, NOMBRE, APELLIDO, TELEFONO, MAIL, FECHA_NAC, FECHA_REGISTRO)
SELECT ID_USUARIO, DNI, NOMBRE, APELLIDO, TELEFONO, MAIL, FECHA_NAC, FECHA_REGISTRO 
FROM FUSECHUDA.USUARIO
GO

INSERT INTO FUSECHUDA.BI_CuponesReclamos (CUPON_NRO, RECLAMO_NRO, TIPO_CUPON, MONTO, FECHA_ALTA, FECHA_VENCIMIENTO)
SELECT NUMERO_RECLAMO_CUPON, NUMERO_RECLAMO, ID_TIPO_CUPON_RECLAMO, MONTO_RECLAMO, FECHA_RECLAMO_ALTA, FECHA_RECLAMO_VENCIMIENTO
FROM FUSECHUDA.CUPON_DESC_RECLAMO
GO

INSERT INTO FUSECHUDA.BI_CuponesPedidos (CUPON_NRO, PEDIDO_NRO, TIPO_CUPON, MONTO, FECHA_ALTA, FECHA_VENCIMIENTO)
SELECT cupped.NUMERO_CUPON, cupped.NUMERO_PEDIDO, tipo.TIPO_CUPON, cupdesc.MONTO, cupdesc.FECHA_ALTA, cupdesc.FECHA_VENCIMIENTO
FROM FUSECHUDA.CUPON_PEDIDOS cupped
LEFT JOIN FUSECHUDA.CUPON_DESCUENTO cupdesc ON cupdesc.NUMERO_CUPON = cupped.NUMERO_CUPON
LEFT JOIN FUSECHUDA.TIPO_CUPON tipo ON tipo.ID_TIPO_CUPON = cupdesc.ID_TIPO
GO

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 4--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en crear las tablas de hechos

CREATE TABLE FUSECHUDA.BI_Pedidos(
Numero [decimal](18, 0),
Tiempo nvarchar(7),
Dia nvarchar(20),
RangoHorario [decimal](18,0),
Provincia [decimal](18,0),
Localidad [decimal](18,0),
RangoEtarioUsuario [decimal](18,0),
RangoEtarioRepartidor [decimal](18,0),
TipoMediodePago [decimal](18,0),
[Local] [decimal](18,0),
LocalCategoria [decimal](18,0),
LocalTipo [decimal](18,0),
TipoMovilidad [decimal](18,0),
EstadoPedido [decimal](18,0),
Calificacion [decimal](18,0)
)
GO

INSERT INTO FUSECHUDA.BI_Pedidos 
SELECT DISTINCT
	ped.NUMERO_PEDIDO,
	--(SELECT ID_TIEMPO FROM FUSECHUDA.BI_Tiempo WHERE AÑO = DATEPART(YEAR,ped.FECHA) AND MES = DATEPART(MONTH, ped.FECHA)) ID_Tiempo,
	CONVERT(VARCHAR,DATEPART(YEAR,ped.FECHA)) + '/' + RIGHT('00' + CONVERT(VARCHAR,DATEPART(MONTH, ped.FECHA)), 2) Tiempo,
	--(SELECT ID_DIA FROM FUSECHUDA.BI_Dia WHERE UPPER(DIA) = UPPER(REPLACE(REPLACE(DATENAME(DW, ped.FECHA),'á','a'),'é','e'))) ID_Dia,	
	REPLACE(REPLACE(DATENAME(DW, ped.FECHA),'á','a'),'é','e') Dia,
	(SELECT ID_RANGO_HORARIO FROM FUSECHUDA.BI_Rango_Horario WHERE CONVERT(time, ped.FECHA) BETWEEN HORA_INICIAL AND HORA_FINAL) RangoHorario,
	LOC.ID_PROVINCIA,
	loc.ID_LOCALIDAD,
	(SELECT ID_RANGO_ETARIO FROM FUSECHUDA.BI_Rango_Etario WHERE DATEDIFF(YEAR, usr.FECHA_NAC, GETDATE()) BETWEEN EDAD_INICIAL AND EDAD_FINAL) RangoEtarioUsuario,
	(SELECT ID_RANGO_ETARIO FROM FUSECHUDA.BI_Rango_Etario WHERE DATEDIFF(YEAR, rep.FECHA_NAC, GETDATE()) BETWEEN EDAD_INICIAL AND EDAD_FINAL) RangoEtarioRepartidor,
	med.ID_MEDIO_DE_PAGO,
	ped.ID_LOCAL,
	cat.ID_CATEGORIA,
	cat.ID_TIPO,
	rep.ID_MOVILIDAD, 
	ped.ID_ESTADO,
	ped.CALIFICACION
FROM FUSECHUDA.PEDIDO ped
LEFT JOIN FUSECHUDA.BI_Local loc ON loc.ID_LOCAL = ped.ID_LOCAL
LEFT JOIN FUSECHUDA.BI_Usuario usr ON usr.ID_USUARIO = ped.ID_USUARIO
LEFT JOIN FUSECHUDA.ENVIO_PEDIDO env ON env.ID_PEDIDO = ped.NUMERO_PEDIDO
LEFT JOIN FUSECHUDA.REPARTIDOR rep ON rep.ID_REPARTIDOR = env.ID_REPARTIDOR
LEFT JOIN FUSECHUDA.MdeP_USUARIO med ON med.ID = ped.ID_MdeP_USUARIO
LEFT JOIN FUSECHUDA.BI_Tipo_Medio_de_Pago mdp ON mdp.ID_MEDIO_DE_PAGO = med.ID_MEDIO_DE_PAGO
LEFT JOIN FUSECHUDA.BI_Categoria_Tipo cat ON cat.ID_CATEGORIA = loc.ID_CATEGORIA
GO

CREATE TABLE FUSECHUDA.BI_Mensajeria(
Tiempo nvarchar(7),
Dia nvarchar(20),
RangoHorario [decimal](18,0),
Provincia [decimal](18,0),
Localidad [decimal](18,0),
RangoEtarioUsuario [decimal](18,0),
RangoEtarioRepartidor [decimal](18,0),
TipoMediodePago [decimal](18,0),
Paquete NVARCHAR(50),
ValorAsegurado [decimal](18,2),
Distancia [decimal](18,2),
TipoMovilidad [decimal](18,0),
EstadoMensajeria [decimal](18,0)
)
GO

INSERT INTO FUSECHUDA.BI_Mensajeria 
SELECT
	--(SELECT ID_TIEMPO FROM FUSECHUDA.BI_Tiempo WHERE AÑO = DATEPART(YEAR,msj.FECHA_MENSAJERIA) AND MES = DATEPART(MONTH, msj.FECHA_MENSAJERIA)) ID_Tiempo,
	CONVERT(VARCHAR,DATEPART(YEAR,msj.FECHA_MENSAJERIA)) + '/' + RIGHT('00' + CONVERT(VARCHAR,DATEPART(MONTH, msj.FECHA_MENSAJERIA)), 2) Tiempo,
	REPLACE(REPLACE(DATENAME(DW, msj.FECHA_MENSAJERIA),'á','a'),'é','e') Dia,
	--(SELECT ID_DIA FROM FUSECHUDA.BI_Dia WHERE UPPER(DIA) = UPPER(REPLACE(REPLACE(DATENAME(DW, msj.FECHA_MENSAJERIA),'á','a'),'é','e'))) ID_Dia,	
	(SELECT ID_RANGO_HORARIO FROM FUSECHUDA.BI_Rango_Horario WHERE CONVERT(time, msj.FECHA_MENSAJERIA) BETWEEN HORA_INICIAL AND HORA_FINAL) RangoHorario,
	prov.ID_PROVINCIA,
	msj.ID_LOCALIDAD,
	(SELECT ID_RANGO_ETARIO FROM FUSECHUDA.BI_Rango_Etario WHERE DATEDIFF(YEAR, usr.FECHA_NAC, GETDATE()) BETWEEN EDAD_INICIAL AND EDAD_FINAL) RangoEtarioUsuario,
	(SELECT ID_RANGO_ETARIO FROM FUSECHUDA.BI_Rango_Etario WHERE DATEDIFF(YEAR, rep.FECHA_NAC, GETDATE()) BETWEEN EDAD_INICIAL AND EDAD_FINAL) RangoEtarioRepartidor,
	mdp.ID_MEDIO_DE_PAGO,
	msj.PAQUETE_TIPO,
	msj.VALOR_ASEGURADO,
	msj.DISTANCIA,
	rep.ID_MOVILIDAD,
	msj.ID_ESTADO
FROM FUSECHUDA.SERVICIO_MENSAJERIA msj
LEFT JOIN FUSECHUDA.BI_Provincia_Localidad prov ON prov.ID_LOCALIDAD = msj.ID_LOCALIDAD
LEFT JOIN FUSECHUDA.BI_Usuario usr ON usr.ID_USUARIO = msj.ID_USUARIO
LEFT JOIN FUSECHUDA.ENVIO_MENSAJERIA env ON env.ID_MENSAJERIA = msj.NUMERO_MENSAJERIA
LEFT JOIN FUSECHUDA.REPARTIDOR rep ON rep.ID_REPARTIDOR = env.ID_REPARTIDOR
LEFT JOIN FUSECHUDA.MdeP_USUARIO med ON med.ID = msj.ID_MdeP_USUARIO
LEFT JOIN FUSECHUDA.BI_Tipo_Medio_de_Pago mdp ON mdp.ID_MEDIO_DE_PAGO = med.ID_MEDIO_DE_PAGO
GO


CREATE TABLE FUSECHUDA.BI_Reclamos(
Numero [decimal](18,0),
Tiempo nvarchar(7),
Dia nvarchar(20),
RangoHorario [decimal](18,0),
RangoEtarioUsuario [decimal](18,0),
RangoEtarioOperario [decimal](18,0),
Pedido [decimal](18,0),
[Local] [decimal](18,0),
TipoReclamo NVARCHAR(50),
--ReclamoMonto [decimal](18,2),
EstadoReclamo [decimal](18,0)
)
GO

INSERT INTO FUSECHUDA.BI_Reclamos (Numero, Tiempo, Dia, RangoHorario, RangoEtarioUsuario, RangoEtarioOperario, Pedido, [Local], TipoReclamo, EstadoReclamo)
SELECT 
	rec.NUMERO_RECLAMO,
	CONVERT(VARCHAR,DATEPART(YEAR,rec.FECHA)) + '/' + RIGHT('00' + CONVERT(VARCHAR,DATEPART(MONTH, rec.FECHA)), 2) Tiempo,
	REPLACE(REPLACE(DATENAME(DW, rec.FECHA),'á','a'),'é','e') Dia,	
	--(SELECT ID_DIA FROM FUSECHUDA.BI_Dia WHERE UPPER(DIA) = UPPER(REPLACE(REPLACE(DATENAME(DW, rec.FECHA),'á','a'),'é','e'))) ID_Dia,	
	(SELECT ID_RANGO_HORARIO FROM FUSECHUDA.BI_Rango_Horario WHERE CONVERT(time, rec.FECHA) BETWEEN HORA_INICIAL AND HORA_FINAL) RangoHorario,
	(SELECT ID_RANGO_ETARIO FROM FUSECHUDA.BI_Rango_Etario WHERE DATEDIFF(YEAR, usr.FECHA_NAC, GETDATE()) BETWEEN EDAD_INICIAL AND EDAD_FINAL) RangoEtarioUsuario,
	(SELECT ID_RANGO_ETARIO FROM FUSECHUDA.BI_Rango_Etario WHERE DATEDIFF(YEAR, op.FECHA_NAC, GETDATE()) BETWEEN EDAD_INICIAL AND EDAD_FINAL) RangoEtarioRepartidor,
	rec.NUMERO_PEDIDO,
	loc.ID_LOCAL,
	rec.ID_TIPO_RECLAMO,
	rec.ID_ESTADO
FROM FUSECHUDA.RECLAMO rec
LEFT JOIN FUSECHUDA.BI_Usuario usr ON usr.ID_USUARIO = rec.ID_USUARIO
LEFT JOIN FUSECHUDA.OPERADOR_RECLAMO op ON op.ID_OPERADOR = rec.ID_OPERADOR
LEFT JOIN FUSECHUDA.PEDIDO ped ON ped.NUMERO_PEDIDO = rec.NUMERO_PEDIDO
LEFT JOIN FUSECHUDA.BI_Local loc ON loc.ID_LOCAL = ped.ID_LOCAL

GO

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 5--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en crear las vistas 

--Día de la semana y franja horaria con mayor cantidad de pedidos según la localidad y categoría del local, para cada mes de cada año.
--AYUDA POR FAVOR 
CREATE VIEW FUSECHUDA.MayorCantidadPedidos
AS
SELECT --* from FUSECHUDA.BI_Pedidos
	ped.Tiempo, 
	ped.dia,
	rh.DESCRIPCION RangoHorario,
	loc.NOMBRE_LOCALIDAD Localidad, 
	LocalCategoria,
	COUNT(*) CANTIDAD
	
FROM FUSECHUDA.BI_Pedidos ped
LEFT JOIN FUSECHUDA.BI_Rango_Horario rh ON rh.ID_RANGO_HORARIO = ped.RangoHorario
LEFT JOIN FUSECHUDA.BI_Provincia_Localidad loc ON loc.ID_LOCALIDAD = ped.Localidad
GROUP BY ped.Tiempo, ped.dia, rh.DESCRIPCION, loc.NOMBRE_LOCALIDAD, LocalCategoria
--ORDER BY ped.Tiempo, loc.NOMBRE_LOCALIDAD, LocalCategoria

GO

-- Monto total de los cupones utilizados por mes en función del rango etario de los usuarios
-- LISTO
CREATE VIEW FUSECHUDA.MontoTotalCupones
AS
SELECT 
	ped.Tiempo,
	re.DESCRIPCION RangoEtario,
	SUM(cup.MONTO) Monto
FROM FUSECHUDA.BI_CuponesPedidos cup
LEFT JOIN FUSECHUDA.BI_Pedidos ped ON ped.Numero = cup.PEDIDO_NRO
LEFT JOIN FUSECHUDA.BI_Rango_Etario re ON re.ID_RANGO_ETARIO = ped.RangoEtarioUsuario
GROUP BY ped.Tiempo, re.DESCRIPCION
--order by 1, 2
GO

-- Promedio de calificación mensual por local
-- LISTO
CREATE VIEW FUSECHUDA.CalificacionPromedio
AS
SELECT
	ped.Tiempo,
	loc.NOMBRE [Local],
	AVG(ped.Calificacion) CalificacionPromedio
FROM FUSECHUDA.BI_Pedidos ped
LEFT JOIN FUSECHUDA.BI_Local loc ON loc.ID_LOCAL = ped.[Local]
WHERE ped.Calificacion IS NOT NULL
GROUP BY ped.Tiempo, loc.NOMBRE
GO

--Promedio mensual del valor asegurado (valor declarado por el usuario) de los paquetes enviados a través del servicio de mensajería en función del tipo de paquete
-- LISTO
CREATE VIEW FUSECHUDA.PromedioMensualAsegurado
AS
SELECT
	Tiempo,
	Paquete, 
	AVG(ValorAsegurado) ValorAsegurado
FROM FUSECHUDA.BI_Mensajeria
GROUP BY Tiempo, Paquete
--order by 1, 2
GO

-- Cantidad de reclamos mensuales recibidos por cada local en función del día de la semana y rango horario
-- LISTO
CREATE VIEW FUSECHUDA.ReclamosMensuales
AS
SELECT
	rec.Tiempo,
	loc.NOMBRE [Local],
	rec.Dia,
	rh.DESCRIPCION RangoHorario,
	COUNT(*) Cantidad
FROM FUSECHUDA.BI_Reclamos rec
LEFT JOIN FUSECHUDA.BI_Local loc ON loc.ID_LOCAL = rec.[Local]
LEFT JOIN FUSECHUDA.BI_Rango_Horario rh ON rh.ID_RANGO_HORARIO = rec.RangoHorario
GROUP BY rec.Tiempo, rec.Dia, rh.DESCRIPCION, loc.NOMBRE
--order by 1, loc.NOMBRE, dia.DIA, rh.HORA_INICIAL , rh.HORA_FINAL
GO

-- Monto mensual generado en cupones a partir de reclamos
-- LISTO
CREATE VIEW FUSECHUDA.MontoCuponesReclamos
AS
SELECT
	rec.Tiempo,
	SUM(cuprec.MONTO) MontoMensual
FROM FUSECHUDA.BI_Reclamos rec
LEFT JOIN FUSECHUDA.BI_CuponesReclamos cuprec ON cuprec.RECLAMO_NRO = rec.Numero
GROUP BY rec.Tiempo
GO

