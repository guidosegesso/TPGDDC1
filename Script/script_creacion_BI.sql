-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 1--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- En esta sección se borrarán los objetos previamente creados

-- Borrado de vistas
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.CUPON_PEDIDOS

-- Borrado de tablas
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Tiempo
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Dia
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Rango_Horario
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Provincia_Localidad
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Rango_Etario
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Tipo_Medio_de_Pago
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Local
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Medios_de_Pago
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Categoria_Tipo
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Movilidad
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Tipo_Paquete
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Estado_Pedido
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Estado_Mensajeria
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.BI_Estado_Reclamo

GO
-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 2--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en la creeación del Esquema, Tablas y Vistas

-- CREACION DEL ESQUEMA
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'FUSECHUDA')
BEGIN 
	CREATE SCHEMA FUSECHUDA
END

GO

-- CREACION DE LAS DIMENSIONES
CREATE TABLE FUSECHUDA.BI_Tiempo
(
	[ID_TIEMPO] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	AÑO [decimal](4,0) NOT NULL,
	MES [decimal](2,0) NOT NULL
)GO

CREATE TABLE FUSECHUDA.BI_Dia
(
	ID_DIA [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	DIA NVARCHAR(50)
)GO

CREATE TABLE FUSECHUDA.BI_Rango_Horario
(
	ID_RANGO_HORARIO [decimal](18, 0) IDENTITY(1,1) NOT NULL ,
	HORA_INICIAL time,
	HORA_FINAL time
)GO

CREATE TABLE FUSECHUDA.BI_Provincia_Localidad
(
	ID [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	ID_LOCALIDAD [decimal](18, 0),
	ID_PROVINCIA [decimal](18, 0)
)GO

CREATE TABLE FUSECHUDA.BI_Rango_Etario
(
	ID_RANGO_ETARIO [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	EDAD_INICIAL [decimal](18, 0),
	EDAD_FINAL [decimal](18, 0)
)GO

CREATE TABLE FUSECHUDA.BI_Tipo_Medio_de_Pago
(
	ID_MEDIO_DE_PAGO [decimal](18, 0),
	TIPO NVARCHAR(255)	
)GO

CREATE TABLE FUSECHUDA.BI_Local
(
	ID_LOCAL [decimal](18, 0) ,
	NOMBRE NVARCHAR(100),
	DESCRIPCION NVARCHAR(255),
	ID_CATEGORIA [decimal](18, 0),
	DIRECCION NVARCHAR(255),
	ID_LOCALIDAD [decimal](18, 0),
	ID_PROVINCIA [decimal](18, 0)
)GO

CREATE TABLE FUSECHUDA.BI_Medios_de_Pago
(
	ID_MEDIO_DE_PAGO [decimal](18, 0),
	TIPO NVARCHAR(255)
)GO

CREATE TABLE FUSECHUDA.BI_Categoria_Tipo
(
	ID [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	ID_TIPO [decimal](18, 0),
	ID_CATEGORIA [decimal](18, 0)
)GO

CREATE TABLE FUSECHUDA.BI_Movilidad
(
	ID_MOVILIDAD [decimal](18, 0) ,
	MOVILIDAD NVARCHAR(50)
)GO

CREATE TABLE FUSECHUDA.BI_Tipo_Paquete
(
	TIPO NVARCHAR(50),
	ALTO_MAX [decimal](18, 2),
	LARGO_MAX [decimal](18, 2),
	ANCHO_MAX [decimal](18, 2),
	PESO_MAX [decimal](18, 2),
	PRECIO [decimal](18, 2)
)GO

CREATE TABLE FUSECHUDA.BI_Estado_Pedido
(
	ID_ESTADO [decimal](18, 0),
	DESCRIPCION NVARCHAR(50)
)GO

CREATE TABLE FUSECHUDA.BI_Estado_Mensajeria
(
	ID_ESTADO [decimal](18, 0),
	DESCRIPCION NVARCHAR(50)
)GO

CREATE TABLE FUSECHUDA.BI_Estado_Reclamo
(
	ID_ESTADO [decimal](18, 0),
	DESCRIPCION NVARCHAR(50)
)GO

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 3--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en completar las tablas con sus respectivos datos

INSERT INTO FUSECHUDA.BI_Tiempo
SELECT ENVIO_MENSAJERIA_FECHA, PEDIDO_FECHA, RECLAMO_FECHA FROM gd_esquema.Maestra

INSERT INTO FUSECHUDA.BI_Dia (ID_DIA, DIA)
SELECT ID_DIA, DIA FROM FUSECHUDA.DIAS

INSERT INTO FUSECHUDA.BI_Rango_Horario (HORA_INICIAL, HORA_FINAL)
SELECT '00:00:00', '01:59:59' UNION ALL
SELECT '02:00:00', '03:59:59' UNION ALL
SELECT '04:00:00', '05:59:59' UNION ALL
SELECT '06:00:00', '07:59:59' UNION ALL
SELECT '08:00:00', '09:59:59' UNION ALL
SELECT '10:00:00', '11:59:59' UNION ALL
SELECT '12:00:00', '13:59:59' UNION ALL
SELECT '14:00:00', '15:59:59' UNION ALL
SELECT '16:00:00', '17:59:59' UNION ALL
SELECT '18:00:00', '19:59:59' UNION ALL
SELECT '20:00:00', '21:59:59' UNION ALL
SELECT '22:00:00', '23:59:59' 

INSERT INTO FUSECHUDA.BI_Provincia_Localidad (ID_PROVINCIA, ID_LOCALIDAD)
SELECT  loc.ID_PROVINCIA, loc.ID_LOCALIDAD
FROM FUSECHUDA.LOCALIDAD loc

INSERT INTO FUSECHUDA.BI_Rango_Etario (EDAD_INICIAL, EDAD_FINAL)
SELECT 0, 24  UNION ALL
SELECT 25, 34 UNION ALL
SELECT 35, 55 UNION ALL
SELECT 56, 200

INSERT INTO FUSECHUDA.BI_Tipo_Medio_de_Pago (ID_MEDIO_DE_PAGO, TIPO)
SELECT ID_MEDIO_DE_PAGO, TIPO 
FROM FUSECHUDA.MEDIOS_DE_PAGO

INSERT INTO FUSECHUDA.BI_Local
SELECT * FROM FUSECHUDA.LOCAL

INSERT INTO FUSECHUDA.BI_Medios_de_Pago
SELECT * FROM FUSECHUDA.MEDIOS_DE_PAGO

INSERT INTO FUSECHUDA.BI_Categoria_Tipo
SELECT DISTINCT ID_CATEGORIA, ID_TIPO FROM FUSECHUDA.CATEGORIA WHERE NOMBRE_CATEGORIA IS NOT NULL

INSERT INTO FUSECHUDA.BI_Movilidad
SELECT * FROM FUSECHUDA.MOVILIDAD

INSERT INTO FUSECHUDA.BI_Tipo_Paquete
SELECT * FROM FUSECHUDA.PAQUETE

INSERT INTO FUSECHUDA.BI_Estado_Pedido
SELECT * FROM FUSECHUDA.PEDIDO_ESTADO

INSERT INTO FUSECHUDA.BI_Estado_Mensajeria
SELECT * FROM FUSECHUDA.MENSAJERIA_ESTADO

INSERT INTO FUSECHUDA.BI_Estado_Reclamo
SELECT * FROM FUSECHUDA.RECLAMO_ESTADO

GO

-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 4--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- Esta sección consiste en crear las vistas de hechos

--Día de la semana y franja horaria con mayor cantidad de pedidos según la localidad y categoría del local, para cada mes de cada año.
CREATE VIEW FUSECHUDA.MayorCantidadPedidos
AS
SELECT DATEPART(YEAR, FECHA), DATEPART(MONTH, FECHA), loc.ID_LOCALIDAD, loc.ID_CATEGORIA, COUNT(*), dia.ID_DIA
FROM FUSECHUDA.PEDIDO ped
LEFT JOIN FUSECHUDA.[LOCAL] loc ON loc.ID_LOCAL = ped.ID_LOCAL
LEFT JOIN FUSECHUDA.DIAS dia ON UPPER(dia.DIA) = UPPER(REPLACE(REPLACE(DATENAME(dw, ped.FECHA), 'é', 'e'), 'á', 'a'))
LEFT JOIN FUSECHUDA.BI_Rango_Horario rh ON CONVERT(TIME,ped.FECHA) BETWEEN rh.HORA_INICIAL and rh.HORA_FINAL
GROUP BY DATEPART(YEAR, FECHA), DATEPART(MONTH, FECHA), loc.ID_LOCALIDAD, loc.ID_CATEGORIA, dia.ID_DIA
ORDER BY DATEPART(YEAR, FECHA), DATEPART(MONTH, FECHA), loc.ID_LOCALIDAD, loc.ID_CATEGORIA, dia.ID_DIA

GO