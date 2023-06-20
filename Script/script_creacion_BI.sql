-------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Sección 1--------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

-- En esta sección se borrarán los objetos previamente creados

-- Borrado de vistas
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.CUPON_PEDIDOS

-- Borrado de tablas
IF OBJECT_ID('FUSECHUDA.CUPON_PEDIDOS','U') IS NOT NULL
  DROP TABLE FUSECHUDA.CUPON_PEDIDOS

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
	[ID_TIEMPO] [decimal](18, 0) NOT NULL,
	AÑO [decimal](4,0) NOT NULL,
	MES [decimal](2,0) NOT NULL
)

CREATE TABLE FUSECHUDA.BI_Dia
(
	ID_DIA [decimal](18, 0),
	DIA NVARCHAR(50)
)

CREATE TABLE FUSECHUDA.BI_Rango_Horario
(
	ID_RANGO_HORARIO [decimal](18, 0),
	HORA_INICIAL [decimal](18, 0),
	HORA_FINAL [decimal](18, 0)
)

CREATE TABLE FUSECHUDA.BI_PROVINCIA_LOCALIDAD
(
	ID [decimal](18, 0),
	ID_LOCALIDAD [decimal](18, 0),
	ID_PROVINCIA [decimal](18, 0)
)

CREATE TABLE FUSECHUDA.BI_Rango_Etario
(
	ID_RANGO_ETARIO [decimal](18, 0),
	EDAD_INICIAL [decimal](18, 0),
	EDAD_FINAL [decimal](18, 0)
)

