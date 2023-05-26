--SELECT TOP 1000 * FROM gd_esquema.Maestra

CREATE SCHEMA FUSECHUDA
GO

CREATE TABLE FUSECHUDA.PROVINCIA(
	ID_PROVINCIA [decimal](18, 0) NOT NULL,
	PROVINCIA	NVARCHAR(255) NOT NULL
)
ALTER TABLE FUSECHUDA.PROVINCIA
	ADD CONSTRAINT PK_PROVINCIA PRIMARY KEY (ID_PROVINCIA)

CREATE TABLE FUSECHUDA.LOCALIDAD(
	ID_LOCALIDAD [decimal](18, 0) NOT NULL,
	ID_PROVINCIA [decimal](18, 0) NOT NULL,
	LOCALIDAD	NVARCHAR(255) NOT NULL
)
ALTER TABLE FUSECHUDA.LOCALIDAD
	ADD CONSTRAINT PK_LOCALIDAD PRIMARY KEY (ID_LOCALIDAD),
		CONSTRAINT FK_PROVINCIA FOREIGN KEY (ID_PROVINCIA) REFERENCES FUSECHUDA.[PROVINCIA](ID_PROVINCIA)

CREATE TABLE FUSECHUDA.USUARIO(
	ID_USUARIO [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	DNI [decimal](18, 0) NOT NULL,
	NOMBRE NVARCHAR(255) NOT NULL,
	APELLIDO NVARCHAR(255) NOT NULL,
	TELEFONO [decimal](18, 0) NULL,
	MAIL NVARCHAR(255) NOT NULL,
	FECHA_NAC [date] NOT NULL,
	FECHA_REGISTRO [datetime2](3) NOT NULL
)	
ALTER TABLE FUSECHUDA.USUARIO
	ADD CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO)
--SELECT * FROM FUSECHUDA.USUARIO
--INSERT INTO FUSECHUDA.USUARIO (NOMBRE, APELLIDO, DNI, MAIL, TELEFONO, FECHA_NAC, FECHA_REGISTRO)
--	SELECT DISTINCT USUARIO_NOMBRE, USUARIO_APELLIDO, USUARIO_DNI, USUARIO_MAIL, USUARIO_TELEFONO, USUARIO_FECHA_NAC, USUARIO_FECHA_REGISTRO 
--	FROM gd_esquema.Maestra
--	WHERE USUARIO_DNI IS NOT NULL

CREATE TABLE FUSECHUDA.DIRECCION_USUARIO(
	ID_DIRECCION [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	ID_USUARIO [decimal](18, 0) NOT NULL,
	NOMBRE NVARCHAR(50) NOT NULL,
	DIRECCION NVARCHAR(255) NOT NULL,
	ID_LOCALIDAD [decimal](18, 0) NOT NULL,
	ID_PROVINCIA [decimal](18, 0) NOT NULL
)	
ALTER TABLE FUSECHUDA.DIRECCION_USUARIO
	ADD CONSTRAINT PK_ID_DIRECCION_USUARIO PRIMARY KEY (ID_DIRECCION),
		CONSTRAINT FK_DIRECCION_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES FUSECHUDA.[USUARIO](ID_USUARIO)

CREATE TABLE FUSECHUDA.MEDIOS_DE_PAGO(
	ID_MEDIO_DE_PAGO [decimal](18, 0) NOT NULL,
	TIPO NVARCHAR(255) NOT NULL
)
ALTER TABLE FUSECHUDA.MEDIOS_DE_PAGO
	ADD CONSTRAINT PK_MEDIO_DE_PAGO PRIMARY KEY (ID_MEDIO_DE_PAGO)

CREATE TABLE FUSECHUDA.EMISOR_TARJETA(
	ID_EMISOR_TARJETA [decimal](18, 0) NOT NULL,
	NOMBRE	NVARCHAR(255) NOT NULL
)
ALTER TABLE FUSECHUDA.EMISOR_TARJETA
	ADD CONSTRAINT PK_EMISOR_TARJETA PRIMARY KEY (ID_EMISOR_TARJETA)

CREATE TABLE FUSECHUDA.MdeP_USUARIO(
	ID [decimal](18, 0) NOT NULL,
	ID_USUARIO [decimal](18, 0) NOT NULL,
	ID_MEDIO_DE_PAGO [decimal](18, 0) NOT NULL,
	ID_EMISOR_TARJETA [decimal](18, 0) NOT NULL,
	NUMERO_TARJETA [decimal](18, 0) NULL
)
ALTER TABLE FUSECHUDA.MdeP_USUARIO
	ADD CONSTRAINT PK_MdeP_USUARIO PRIMARY KEY (ID),
		CONSTRAINT FK_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES FUSECHUDA.[USUARIO](ID_USUARIO),
		CONSTRAINT FK_MEDIO_DE_PAGO FOREIGN KEY (ID_MEDIO_DE_PAGO) REFERENCES FUSECHUDA.[MEDIOS_DE_PAGO](ID_MEDIO_DE_PAGO),
		CONSTRAINT FK_EMISOR_TARJETA FOREIGN KEY (ID_EMISOR_TARJETA) REFERENCES FUSECHUDA.[EMISOR_TARJETA](ID_EMISOR_TARJETA)

CREATE TABLE FUSECHUDA.CATEGORIA_TIPO(
	ID_TIPO [decimal](18, 0) NOT NULL,
	NOMBRE	NVARCHAR(255) NOT NULL
)
ALTER TABLE FUSECHUDA.CATEGORIA_TIPO
	ADD CONSTRAINT PK_CATEGORIA_TIPO PRIMARY KEY (ID_TIPO)

CREATE TABLE FUSECHUDA.CATEGORIA(
	ID_CATEGORIA [decimal](18, 0) NOT NULL,
	ID_TIPO [decimal](18, 0) NOT NULL,
	NOMBRE_CATEGORIA NVARCHAR(255) NOT NULL
)
ALTER TABLE FUSECHUDA.CATEGORIA
	ADD CONSTRAINT PK_CATEGORIA PRIMARY KEY (ID_CATEGORIA),
		CONSTRAINT FK_CATEGORIA_TIPO FOREIGN KEY (ID_TIPO) REFERENCES FUSECHUDA.[CATEGORIA_TIPO](ID_TIPO)

CREATE TABLE FUSECHUDA.[LOCAL](
	ID_LOCAL [decimal](18, 0) IDENTITY(1,1),
	NOMBRE [nvarchar](100) NOT NULL,
	DESCRIPCION [nvarchar](255) NOT NULL,
	CATEGORIA [decimal](18, 0) NOT NULL,
	DIRECCION [nvarchar](255) NOT NULL,
	ID_LOCALIDAD [decimal](18, 0) NOT NULL,
	ID_PROVINCIA [decimal](18, 0) NOT NULL
)
ALTER TABLE FUSECHUDA.[LOCAL]
	ADD	CONSTRAINT PK_LOCAL PRIMARY KEY (ID_LOCAL),
		CONSTRAINT FK_LOCAL_CATEGORIA FOREIGN KEY (CATEGORIA) REFERENCES FUSECHUDA.[CATEGORIA](ID_CATEGORIA),
		CONSTRAINT FK_LOCAL_LOCALIDAD FOREIGN KEY (ID_LOCALIDAD) REFERENCES FUSECHUDA.[LOCALIDAD](ID_LOCALIDAD),
		CONSTRAINT FK_LOCAL_PROVINCIA FOREIGN KEY (ID_PROVINCIA) REFERENCES FUSECHUDA.[PROVINCIA](ID_PROVINCIA)

CREATE TABLE FUSECHUDA.DIAS(
	ID_DIA [decimal](18, 0) NOT NULL,
	DIA NVARCHAR(50) NOT NULL
)
ALTER TABLE FUSECHUDA.DIAS
	ADD CONSTRAINT PK_DIAS PRIMARY KEY (ID_DIA)

CREATE TABLE FUSECHUDA.HORARIO_LOCAL(
	ID_LOCAL [decimal](18, 0) NOT NULL,
	ID_DIA [decimal](18, 0) NOT NULL,
	HORA_APERTURA [decimal](18, 0) NOT NULL,
	HORA_CIERRE [decimal](18, 0) NOT NULL
)
ALTER TABLE FUSECHUDA.HORARIO_LOCAL
	ADD	CONSTRAINT PK_HORARIO_LOCAL PRIMARY KEY (ID_LOCAL, ID_DIA),
		CONSTRAINT FK_ID_LOCAL FOREIGN KEY (ID_LOCAL) REFERENCES FUSECHUDA.[LOCAL](ID_LOCAL),
		CONSTRAINT FK_ID_DIA FOREIGN KEY (ID_DIA) REFERENCES FUSECHUDA.[DIAS](ID_DIA)

CREATE TABLE FUSECHUDA.PRODUCTOS(
	CODIGO [nvarchar](50) NOT NULL,
	NOMBRE [nvarchar](50) NOT NULL,
	DESCRIPCION [nvarchar](255) NULL,
)
ALTER TABLE FUSECHUDA.PRODUCTOS
	ADD	CONSTRAINT PK_PROD_CODIGO PRIMARY KEY (CODIGO)

CREATE TABLE FUSECHUDA.PRODUCTO_LOCAL(
	ID_LOCAL [decimal](18, 0) NOT NULL,
	CODIGO [nvarchar](50) NOT NULL,
	PRECIO [decimal](18, 2) NOT NULL
)
ALTER TABLE FUSECHUDA.PRODUCTO_LOCAL
	ADD	CONSTRAINT PK_PRODUCTO_LOCAL PRIMARY KEY (ID_LOCAL, CODIGO),
		CONSTRAINT FK_PRODUCTO_LOCAL_LOCAL FOREIGN KEY (ID_LOCAL) REFERENCES FUSECHUDA.[LOCAL](ID_LOCAL)
		--CONSTRAINT FK_PRODUCTO_LOCAL_PROD_CODIGO FOREIGN KEY (CODIGO) REFERENCES FUSECHUDA.[PRODUCTOS](CODIGO)

CREATE TABLE FUSECHUDA.MOVILIDAD(
	ID_MOVILIDAD [decimal](18, 0) NOT NULL,
	MOVILIDAD [nvarchar](50) NOT NULL
)
ALTER TABLE FUSECHUDA.MOVILIDAD
	ADD	CONSTRAINT PK_MOVILIDAD PRIMARY KEY (ID_MOVILIDAD)

CREATE TABLE FUSECHUDA.REPARTIDOR(
	ID_REPARTIDOR [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	DNI [decimal](18, 0) NOT NULL,
	NOMBRE  [nvarchar](255) NOT NULL,
	APELLIDO [nvarchar](255) NOT NULL,
	TELEFONO [decimal](18, 0) NOT NULL,
	DIRECCION [nvarchar](255) NOT NULL,
	EMAIL [nvarchar](255) NOT NULL,
	FECHA_NAC [date] NOT NULL,
	ID_MOVILIDAD [decimal](18, 0) NOT NULL,
	--ID_LOCALIDAD [decimal](18, 0) NOT NULL
)
ALTER TABLE FUSECHUDA.REPARTIDOR
	ADD CONSTRAINT PK_REPARTIDOR PRIMARY KEY (ID_REPARTIDOR),
		CONSTRAINT FK_REPARTIDOR_MOVILIDAD FOREIGN KEY (ID_MOVILIDAD) REFERENCES FUSECHUDA.[MOVILIDAD](ID_MOVILIDAD)
		--CONSTRAINT FK_REPARTIDOR_LOCALIDAD FOREIGN KEY (ID_LOCALIDAD) REFERENCES FUSECHUDA.[LOCALIDAD](ID_LOCALIDAD)

CREATE TABLE FUSECHUDA.LOCALIDAD_REPARTIDOR(
	ID_REPARTIDOR [decimal](18, 0) NOT NULL,
	ID_LOCALIDAD [decimal](18, 0) NOT NULL
)
ALTER TABLE FUSECHUDA.LOCALIDAD_REPARTIDOR
	ADD	CONSTRAINT FK_REPARTIDOR_ID FOREIGN KEY (ID_REPARTIDOR) REFERENCES FUSECHUDA.[REPARTIDOR](ID_REPARTIDOR),
		CONSTRAINT FK_LOCALIDAD_ID FOREIGN KEY (ID_LOCALIDAD) REFERENCES FUSECHUDA.[LOCALIDAD](ID_LOCALIDAD)

CREATE TABLE FUSECHUDA.PEDIDO(
	NUMERO_PEDIDO [decimal](18, 0) NOT NULL,
	ID_USUARIO [decimal](18, 0) NOT NULL,
	ID_LOCAL [decimal](18, 0) NOT NULL,
	ESTADO [nvarchar](50) NOT NULL,
	ID_MdeP_USUARIO [decimal](18, 0) NOT NULL,
	TARIFA_SERVICIO [decimal](18, 2) NULL,
	TOTAL_PRODUCTOS [decimal](18, 2) NULL,
	TOTAL_CUPONES [decimal](18, 2) NULL,
	TOTAL_SERVICIO [decimal](18, 2) NULL,
	TOTAL [decimal](18, 2) NOT NULL,
	OBSERVACIONES [nvarchar](255) NULL,
	FECHA [datetime] NOT NULL,
	CALIFICACION [decimal](18, 0) NULL	
)
ALTER TABLE FUSECHUDA.PEDIDO
	ADD CONSTRAINT PK_NUMERO_PEDIDO PRIMARY KEY (NUMERO_PEDIDO),
		CONSTRAINT FK_PEDIDO_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES FUSECHUDA.USUARIO(ID_USUARIO),
		CONSTRAINT FK_PEDIDO_LOCAL FOREIGN KEY (ID_LOCAL) REFERENCES FUSECHUDA.[LOCAL](ID_LOCAL),
		CONSTRAINT FK_PEDIDO_MEDIO_PAGO FOREIGN KEY (ID_MdeP_USUARIO) REFERENCES FUSECHUDA.MdeP_USUARIO(ID)

CREATE TABLE FUSECHUDA.ENVIO_PEDIDO(
	ID_ENVIO [decimal](18, 0) NOT NULL,
	ID_PEDIDO [decimal](18, 0) NOT NULL,
	ID_REPARTIDOR [decimal](18, 0) NOT NULL,
	ID_DIRECCION [decimal](18, 0) NOT NULL,
	PRECIO_ENVIO [decimal](18, 2) NOT NULL,
	PROPINA [decimal](18, 2) NULL,
	FECHA_ENTREGA [datetime] NULL,
	TIEMPO_ESTIMADO_ENTREGA [datetime] NULL
)
ALTER TABLE FUSECHUDA.ENVIO_PEDIDO
	ADD CONSTRAINT PK_ID_ENVIO_PEDIDO PRIMARY KEY (ID_ENVIO),
		CONSTRAINT FK_ENVIO_PEDIDO_ID_PEDIDO FOREIGN KEY (ID_PEDIDO) REFERENCES FUSECHUDA.PEDIDO(NUMERO_PEDIDO),
		CONSTRAINT FK_ENVIO_PEDIDO_REPARTIDOR FOREIGN KEY (ID_REPARTIDOR) REFERENCES FUSECHUDA.[REPARTIDOR](ID_REPARTIDOR),
		CONSTRAINT FK_ENVIO_PEDIDO_DIRECCION FOREIGN KEY (ID_DIRECCION) REFERENCES FUSECHUDA.DIRECCION_USUARIO(ID_DIRECCION)
	   
CREATE TABLE FUSECHUDA.PRODUCTOS_PEDIDO(
	NUMERO_PEDIDO [decimal](18, 0) NOT NULL,
	CODIGO [nvarchar](50) NOT NULL,
	PRECIO [decimal](18, 2) NOT NULL,
	CANTIDAD [decimal](18, 0) NOT NULL,
	TOTAL_X_PRODUCTO [decimal](18, 2) NOT NULL
)
ALTER TABLE FUSECHUDA.PRODUCTOS_PEDIDO
	ADD	CONSTRAINT PK_PRODUCTOS_PEDIDO PRIMARY KEY (NUMERO_PEDIDO, CODIGO),
		CONSTRAINT FK_NUMERO_PEDIDO FOREIGN KEY (NUMERO_PEDIDO) REFERENCES FUSECHUDA.[PEDIDO](NUMERO_PEDIDO),
		CONSTRAINT FK_CODIGO FOREIGN KEY (CODIGO) REFERENCES FUSECHUDA.[PRODUCTOS](CODIGO)

CREATE TABLE FUSECHUDA.PAQUETE(
	TIPO [nvarchar](50) NOT NULL,
	ALTO_MAX [decimal](18, 2) NOT NULL,
	LARGO_MAX [decimal](18, 2) NOT NULL,
	ANCHO_MAX [decimal](18, 2) NOT NULL,
	PESO_MAX [decimal](18, 2) NOT NULL,
	PRECIO [decimal](18, 2) NOT NULL
)
ALTER TABLE FUSECHUDA.PAQUETE
	ADD	CONSTRAINT PK_PAQUETE PRIMARY KEY (TIPO)

CREATE TABLE FUSECHUDA.OPERADOR_RECLAMO(
	ID_OPERADOR [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	NOMBRE [nvarchar](255) NOT NULL,
	APELLIDO [nvarchar](255) NOT NULL,
	DNI [decimal](18, 0) NOT NULL,
	TELEFONO [decimal](18, 0) NOT NULL,
	DIRECCION [nvarchar](255) NOT NULL,
	MAIL [nvarchar](255) NOT NULL,
	FECHA_NAC [date] NOT NULL
)
ALTER TABLE FUSECHUDA.OPERADOR_RECLAMO
	ADD	CONSTRAINT PK_OPERADOR_RECLAMO PRIMARY KEY (ID_OPERADOR)

CREATE TABLE FUSECHUDA.TIPO_RECLAMO(
	ID_TIPO_RECLAMO [decimal](18, 0) NOT NULL,
	TIPO_RECLAMO [nvarchar](50) NOT NULL
)
ALTER TABLE FUSECHUDA.TIPO_RECLAMO
	ADD	CONSTRAINT PK_TIPO_RECLAMO PRIMARY KEY (ID_TIPO_RECLAMO)

CREATE TABLE FUSECHUDA.RECLAMO(
	NUMERO_RECLAMO [decimal](18, 0) NOT NULL,
	ID_USUARIO [decimal](18, 0) NOT NULL,
	NUMERO_PEDIDO [decimal](18, 0) NOT NULL,
	FECHA [datetime] NOT NULL,
	ID_TIPO_RECLAMO [decimal](18, 0) NOT NULL,
	DESCRIPCION [nvarchar](255) NULL,
	ID_OPERADOR [decimal](18, 0) NOT NULL,
	ESTADO [nvarchar](50) NOT NULL,
	SOLUCION [nvarchar](255) NULL,
	FECHA_SOLUCION [datetime] NULL,
	CALIFICACION [decimal](18, 0) NULL
)
ALTER TABLE FUSECHUDA.RECLAMO
	ADD	CONSTRAINT PK_RECLAMO PRIMARY KEY (NUMERO_RECLAMO),
		CONSTRAINT FK_RECLAMO_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES FUSECHUDA.[USUARIO](ID_USUARIO),
		CONSTRAINT FK_RECLAMO_NUMERO_PEDIDO FOREIGN KEY (NUMERO_PEDIDO) REFERENCES FUSECHUDA.[PEDIDO](NUMERO_PEDIDO),
		CONSTRAINT FK_RECLAMO_TIPO_RECLAMO FOREIGN KEY (ID_TIPO_RECLAMO) REFERENCES FUSECHUDA.[TIPO_RECLAMO](ID_TIPO_RECLAMO),
		CONSTRAINT FK_RECLAMO_OPERADOR FOREIGN KEY (ID_OPERADOR) REFERENCES FUSECHUDA.[OPERADOR_RECLAMO](ID_OPERADOR)

CREATE TABLE FUSECHUDA.TIPO_CUPON(
	ID_TIPO_CUPON [decimal](18, 0) NOT NULL,
	TIPO_CUPON [nvarchar](50) NOT NULL
)
ALTER TABLE FUSECHUDA.TIPO_CUPON
	ADD	CONSTRAINT PK_TIPO_CUPON PRIMARY KEY (ID_TIPO_CUPON)

CREATE TABLE FUSECHUDA.CUPON_DESCUENTO(
	NUMERO_CUPON [decimal](18, 0) NOT NULL,
	ID_USUARIO [decimal](18, 0) NOT NULL,
	ID_TIPO [decimal](18, 0) NOT NULL,
	MONTO [decimal](18, 2) NOT NULL,
	FECHA_ALTA [datetime] NOT NULL,
	FECHA_VENCIMIENTO [datetime] NULL
)
ALTER TABLE FUSECHUDA.CUPON_DESCUENTO
	ADD	CONSTRAINT PK_CUPON_DESCUENTO PRIMARY KEY (NUMERO_CUPON),
		CONSTRAINT FK_CUPON_DESCUENTO_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES FUSECHUDA.[USUARIO](ID_USUARIO),
		CONSTRAINT FK_CUPON_DESCUENTO_TIPO FOREIGN KEY (ID_TIPO) REFERENCES FUSECHUDA.[TIPO_CUPON](ID_TIPO_CUPON)

CREATE TABLE FUSECHUDA.CUPON_PEDIDOS(
	NUMERO_CUPON [decimal](18, 0) NOT NULL,
	NUMERO_PEDIDO [decimal](18, 0) NOT NULL
)
ALTER TABLE FUSECHUDA.CUPON_PEDIDOS
	ADD	CONSTRAINT FK_CUPON_PEDIDOS_NUMERO FOREIGN KEY (NUMERO_CUPON) REFERENCES FUSECHUDA.[CUPON_DESCUENTO](NUMERO_CUPON),
		CONSTRAINT FK_CUPON_PEDIDOS_PEDIDO FOREIGN KEY (NUMERO_PEDIDO) REFERENCES FUSECHUDA.[PEDIDO](NUMERO_PEDIDO)

CREATE TABLE FUSECHUDA.CUPON_RECLAMO(
	NUMERO_RECLAMO [decimal](18, 0) NOT NULL,
	NUMERO_CUPON [decimal](18, 0) NOT NULL
)
ALTER TABLE FUSECHUDA.CUPON_RECLAMO
	ADD	CONSTRAINT FK_NUMERO_RECLAMO FOREIGN KEY (NUMERO_RECLAMO) REFERENCES FUSECHUDA.[RECLAMO](NUMERO_RECLAMO),
		CONSTRAINT FK_NUMERO_CUPON FOREIGN KEY (NUMERO_CUPON) REFERENCES FUSECHUDA.[CUPON_DESCUENTO](NUMERO_CUPON)

CREATE TABLE FUSECHUDA.SERVICIO_MENSAJERIA(
	NUMERO_MENSAJERIA [decimal](18, 0) NOT NULL,
	ID_USUARIO [decimal](18, 0) NOT NULL,
	ID_MdeP_USUARIO [decimal](18, 0) NOT NULL,
	PAQUETE_TIPO [nvarchar](50) NOT NULL,
	DIREC_ORIGEN [nvarchar](255) NOT NULL,
	DIREC_DESTINO [nvarchar](255) NOT NULL,
	DISTANCIA [decimal](18, 2) NOT NULL,
	FECHA_MENSAJERIA [datetime] NOT NULL,
	VALOR_ASEGURADO [decimal](18, 2) NOT NULL,
	PRECIO_SEGURO [decimal](18, 2) NOT NULL,
	TOTAL [decimal](18, 2) NOT NULL,
	ESTADO [nvarchar](50) NOT NULL,
	OBSERV [nvarchar](255) NULL,
	CALIFICACION [decimal](18, 0) NULL,
	ID_LOCALIDAD [decimal](18, 0) NOT NULL,
	ID_PROVINCIA [decimal](18, 0) NOT NULL
)
ALTER TABLE FUSECHUDA.SERVICIO_MENSAJERIA
	ADD CONSTRAINT PK_SERVICIO_MENSAJERIA PRIMARY KEY (NUMERO_MENSAJERIA),
		CONSTRAINT FK_SERVICIO_MENSAJERIA_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES FUSECHUDA.[USUARIO](ID_USUARIO),
		CONSTRAINT FK_SERVICIO_MENSAJERIA_MdeP FOREIGN KEY (ID_MdeP_USUARIO) REFERENCES FUSECHUDA.[MdeP_USUARIO](ID),
		CONSTRAINT FK_SERVICIO_MENSAJERIA_PAQUETE FOREIGN KEY (PAQUETE_TIPO) REFERENCES FUSECHUDA.[PAQUETE](TIPO),
		CONSTRAINT FK_SERVICIO_MENSAJERIA_LOCALIDAD FOREIGN KEY (ID_LOCALIDAD) REFERENCES FUSECHUDA.[LOCALIDAD](ID_LOCALIDAD),
		CONSTRAINT FK_SERVICIO_MENSAJERIA_PROVINCIA FOREIGN KEY (ID_PROVINCIA) REFERENCES FUSECHUDA.[PROVINCIA](ID_PROVINCIA)

CREATE TABLE FUSECHUDA.ENVIO_MENSAJERIA(
	ID_ENVIO [decimal](18, 0) NOT NULL,
	ID_MENSAJERIA [decimal](18, 0) NOT NULL,
	ID_REPARTIDOR [decimal](18, 0) NOT NULL,
	PRECIO_ENVIO [decimal](18, 2) NOT NULL,
	PROPINA [decimal](18, 2) NOT NULL,
	FECHA_ENTREGA [datetime] NOT NULL,
	TIEMPO_ESTIMADO_ENTREGA [datetime] NULL
)
ALTER TABLE FUSECHUDA.ENVIO_MENSAJERIA
	ADD CONSTRAINT PK_ENVIO_MENSAJERIA PRIMARY KEY (ID_ENVIO),
		CONSTRAINT FK_MENSAJERIA FOREIGN KEY (ID_MENSAJERIA) REFERENCES FUSECHUDA.[SERVICIO_MENSAJERIA](NUMERO_MENSAJERIA),
		CONSTRAINT FK_REPARTIDOR FOREIGN KEY (ID_REPARTIDOR) REFERENCES FUSECHUDA.[REPARTIDOR](ID_REPARTIDOR)
