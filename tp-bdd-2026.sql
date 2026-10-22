--tp
USE GD2C_2026
GO

CREATE SCHEMA ESTRESHADAS;
go

-- TABLAS
create table ESTRESHADAS.provincia (
	id_provincia BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nom_provincia varchar(255) NULL
)

create table ESTRESHADAS.localidad (
	id_localidad BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_provincia BIGINT NOT NULL REFERENCES ESTRESHADAS.provincia(id_provincia),
	nom_localidad varchar(255) NULL
)

CREATE TABLE ESTRESHADAS.local (
    id_local BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_localidad BIGINT NOT NULL REFERENCES ESTRESHADAS.localidad(id_localidad),
    nom_local VARCHAR(255) NULL,
    dir_local VARCHAR(255) NULL,
    tel_local VARCHAR(255) NULL,
    email_local VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.proveedor (
    id_proveedor BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_localidad BIGINT NOT NULL REFERENCES ESTRESHADAS.localidad(id_localidad),
    cuit_proveedor VARCHAR(255) NULL,
    raz_soc_proveedor VARCHAR(255) NULL,
    dir_proveedor VARCHAR(255) NULL,
    tel_proveedor VARCHAR(255) NULL,
    email_proveedor VARCHAR(255) NULL
)

create table ESTRESHADAS.cliente (
    id_cliente BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_localidad BIGINT REFERENCES ESTRESHADAS.localidad(id_localidad),
    dni_cliente varchar(255) NULL,
    fec_nac_cliente date NULL,
    nom_cliente varchar(255) NULL,
    ape_cliente varchar(255) NULL,
    dir_cliente varchar(255) NULL,
    tel_cliente varchar(255) NULL,
    email_cliente varchar(255) NULL
)

create table ESTRESHADAS.empleado (
	id_empleado BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_localidad BIGINT NOT NULL REFERENCES ESTRESHADAS.localidad(id_localidad),
	id_local BIGINT NOT NULL REFERENCES ESTRESHADAS.local(id_local),
	dni_empleado varchar(255) NULL,
	fec_nac_empleado date NULL,
	fec_ingr_empleado date NULL,
	puesto_empleado varchar(255) NULL,
	nom_empleado varchar(255) NULL,
	ape_empleado varchar(255) NULL,
	domc_empleado varchar(255) NULL,
	tell_empleado varchar(255) NULL,
	email_empleado varchar(255) NULL
)

CREATE TABLE ESTRESHADAS.compra (
    id_compra BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_empleado BIGINT NOT NULL REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_proveedor BIGINT NOT NULL REFERENCES ESTRESHADAS.proveedor(id_proveedor),
    nro_compra int NULL,
    total_compra numeric(38,2) NULL,
    fecha_compra date NULL
)

create table ESTRESHADAS.forma_pago (
	id_forma_pago BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	dscr_forma_pago varchar(255) NULL
)

create table ESTRESHADAS.venta (
    id_venta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_empleado BIGINT NOT NULL REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_cliente BIGINT NOT NULL REFERENCES ESTRESHADAS.cliente(id_cliente),
    id_forma_pago BIGINT NOT NULL REFERENCES ESTRESHADAS.forma_pago(id_forma_pago),
    nro_venta int NULL,
    fecha_venta smallDateTime NULL,
    total_venta numeric(38,2) NULL
)

create table ESTRESHADAS.marca (
	id_marca BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	dscr_marca varchar(255) NULL
)

create table ESTRESHADAS.tipo_producto (
	id_tipo_producto BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	dscr_tipo_producto varchar(255) NULL
)

create table ESTRESHADAS.producto (
	id_producto BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	id_marca BIGINT NOT NULL REFERENCES ESTRESHADAS.marca(id_marca),
	id_tipo_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.tipo_producto(id_tipo_producto),
	cod_producto varchar(255) NULL,
	nom_producto varchar(255) NULL,
	dscr_producto varchar(255) NULL,
	prec_producto numeric(38,2) NULL
)

CREATE TABLE ESTRESHADAS.detalle_compra (
    id_det_compra BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_compra BIGINT NOT NULL REFERENCES ESTRESHADAS.compra(id_compra),
    id_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.producto(id_producto),
    cant_det_compra int NULL,
    prec_unit_det_compra numeric(38,2) NULL
)

create table ESTRESHADAS.detalle_venta (
    id_det_venta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_venta BIGINT NOT NULL REFERENCES ESTRESHADAS.venta(id_venta),
    id_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.producto(id_producto),
    cant_det_venta int NULL,
    prec_unit_det_venta numeric(38,2) NULL,
    subtot_det_venta numeric(38,2) NULL
)

CREATE TABLE ESTRESHADAS.estado_bicicleta (
    id_est_bicicleta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    desc_est_bicicleta VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.estado_alquiler (
    id_est_alquiler BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    desc_est_alquiler VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.categoria_bicicleta (
    id_cat_bicicleta BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    dscr_cat_bicicleta VARCHAR(255) NULL,
)

CREATE TABLE ESTRESHADAS.modelo (
    id_modelo BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_cat_bicicleta BIGINT NOT NULL REFERENCES ESTRESHADAS.categoria_bicicleta(id_cat_bicicleta),
    nom_modelo VARCHAR(255) NULL,
    rodado_modelo VARCHAR(255) NULL,
    cuadro_modelo VARCHAR(255) NULL,
    color_modelo VARCHAR(255) NULL
)

CREATE TABLE ESTRESHADAS.bicicleta_alquiler (
    id_bici_alquiler BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_marca BIGINT NOT NULL REFERENCES ESTRESHADAS.marca(id_marca),
    id_modelo BIGINT NOT NULL REFERENCES ESTRESHADAS.modelo(id_modelo),
	id_local BIGINT NOT NULL REFERENCES ESTRESHADAS.local(id_local),
	id_est_bicicleta BIGINT NOT NULL REFERENCES ESTRESHADAS.estado_bicicleta(id_est_bicicleta),
    prec_hora_bicicleta numeric(38,2) NULL,
    prec_dia_bicicleta numeric(38,2) NULL
)

CREATE TABLE ESTRESHADAS.alquiler (
    id_alquiler BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_empleado BIGINT NOT NULL REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_cliente BIGINT NOT NULL REFERENCES ESTRESHADAS.cliente(id_cliente),
    id_bici_alquiler BIGINT NOT NULL REFERENCES ESTRESHADAS.bicicleta_alquiler(id_bici_alquiler),
	id_est_alquiler BIGINT NOT NULL REFERENCES ESTRESHADAS.estado_alquiler(id_est_alquiler),
    fec_init_alquiler DATETIME2(0) NULL,
    fec_dev_alquiler DATETIME2(0) NULL,
    fec_real_dev_alquiler DATETIME2(0) NULL,
    nro_alquiler int NULL,
    importe_alquiler NUMERIC(38,2) NULL
)

create table ESTRESHADAS.Estado_Reparacion (
    id_estadoRep BIGINT IDENTITY(1,1) PRIMARY KEY,
    desc_estado varchar(255) NULL
)

create table ESTRESHADAS.Reparacion (
    id_reparacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_cliente BIGINT REFERENCES ESTRESHADAS.Cliente(id_cliente),
    id_empleado BIGINT REFERENCES ESTRESHADAS.Empleado(id_empleado),
    id_producto BIGINT REFERENCES ESTRESHADAS.Producto(id_producto),
    id_estadoRep BIGINT REFERENCES ESTRESHADAS.Estado_Reparacion(id_estadoRep),
    nro_reparacion int NULL,
    nro_serie_bici_cli varchar(255) NULL,
    fecha_ingreso date NULL,
    fecha_entregaEstm date NULL,
    fecha_entregaReal date NULL,
    diagnostico varchar(255) NULL,
    precio_manoObra numeric(38,2) NULL,
    precio_repuestos numeric(38,2) NULL,
    precio_total numeric(38,2) NULL
)

create table ESTRESHADAS.Categoria_Repuesto (
    id_categoria BIGINT IDENTITY(1,1) PRIMARY KEY,
    desc_categoria varchar(255) NULL
)

create table ESTRESHADAS.Repuesto (
    id_repuesto BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_categoria BIGINT REFERENCES ESTRESHADAS.Categoria_Repuesto(id_categoria),
    cod_repuesto varchar(255) NULL,
    precio_repuesto numeric(38,2) NULL,
    desc_repuesto varchar(255) NULL,
    compatibilidad varchar(255) NULL
)

create table ESTRESHADAS.Detalle_Reparacion (
    id_detReparacion BIGINT IDENTITY(1,1) PRIMARY KEY,
    id_reparacion BIGINT REFERENCES ESTRESHADAS.Reparacion(id_Reparacion),
    id_repuesto BIGINT REFERENCES ESTRESHADAS.Repuesto(id_repuesto),
    subtotal numeric(38,2) NULL,
    precio_unitario numeric(38,2) NULL,
    cantidad int NULL
)

INSERT INTO ESTRESHADAS.Provincia (nom_provincia)
SELECT DISTINCT 
    M.Cliente_Provincia
FROM gd_esquema.Maestra M
WHERE M.Cliente_Provincia IS NOT NULL AND NOT EXISTS (select * from ESTRESHADAS.Provincia P where P.nom_provincia = M.Cliente_Provincia)

INSERT INTO ESTRESHADAS.Localidad (id_provincia, nom_localidad)
SELECT DISTINCT 
    (SELECT id_provincia FROM ESTRESHADAS.Provincia P
    WHERE P.nom_provincia = M.Cliente_Provincia),
    M.Cliente_Localidad
FROM gd_esquema.Maestra M
WHERE M.Cliente_Localidad IS NOT NULL AND NOT EXISTS (select * from ESTRESHADAS.Localidad L where L.nom_localidad = M.Cliente_localidad) 

insert into ESTRESHADAS.Cliente (id_localidad, dni_cliente, fec_nac_cliente, nom_cliente, ape_cliente, dir_cliente, tel_cliente, email_cliente)
select distinct
    L.id_localidad,
    M.Cliente_Dni_Cliente,
    M.Cliente_Fecha_Nacimiento_Cliente,
    M.Cliente_Nombre_Cliente,
    M.Cliente_Apellido_Cliente,
    M.Cliente_Direccion_Cliente,
    M.Cliente_Telefono_Cliente,
    M.Cliente_Email_Cliente
from gd_esquema.Maestra M INNER JOIN ESTRESHADAS.Localidad L
    ON L.nom_localidad = M.Cliente_Localidad;  

insert into ESTRESHADAS.Estado_Reparacion (desc_estado)
select distinct
    M.Estado_Reparacion_Estado_Reparacion
from gd_esquema.Maestra M

insert into ESTRESHADAS.Reparacion (id_cliente, id_empleado, id_producto, id_estadoRep, nro_reparacion, nro_serie_bici_cli, fecha_ingreso, fecha_entregaEstm, fecha_entregaReal, diagnostico, precio_manoObra, precio_repuestos, precio_total)
select distinct
    C.id_cliente,
    E.id_empleado,
    P.id_producto,
    EP.id_estadoRep,
    M.Reparacion_Nro_Reparacion,
    M.Reparacion_Numero_Serie_Bici_Reparacion,
    M.Reparacion_Fecha_Ingreso_Reparacion,
    M.Reparacion_Fecha_Entrega_Estimada_Reparacion,
    M.Reparacion_Fecha_Entrega_Real_Reparacion,
    M.Reparacion_Diagnostico_Reparacion,
    M.Reparacion_Precio_Mano_Obra_Reparacion,
    M.Reparacion_Precio_Repuestos_Reparacion,
    M.Reparacion_Precio_Total_Reparacion
from gd_esquema.Maestra M 
    INNER JOIN ESTRESHADAS.Cliente C
    on C.dni_cliente = M.Cliente_Dni_Cliente 
    INNER JOIN ESTRESHADAS.Empleado E
    on E.dni_empleado = M.Empleado_Dni_Empleado
    INNER JOIN ESTRESHADAS.Producto P
    on P.cod_producto = M.Producto_Cod_Producto
    INNER JOIN ESTRESHADAS.Estado_Reparacion EP
    on EP.desc_estado = M.Estado_Reparacion_Estado_Reparacion

insert into ESTRESHADAS.Categoria_Repuesto (desc_categoria)
select distinct
    M.Categoria_Repuestos_Categoria_Repuesto
from gd_esquema.Maestra M

insert into ESTRESHADAS.Repuesto (id_categoria, cod_repuesto, precio_repuesto, desc_repuesto, compatibilidad)
select distinct
    CR.id_categoria,
    M.Repuesto_Cod_Repuesto,
    M.Repuesto_Precio_Repuesto,
    M.Repuesto_Desc_Repuesto,
    M.Repuesto_Compatibilidad_Repuesto
from gd_esquema.Maestra M 
    INNER JOIN ESTRESHADAS.Categoria_Repuesto CR
    on CR.desc_categoria = M.Categoria_Repuestos_Categoria_Respuesto

insert into ESTRESHADAS.Detalle_Reparacion (id_reparacion, id_repuesto, subtotal, precio_unitario, cantidad)
select distinct
    R.id_reparacion,
    REPU.id_repuesto,
    M.Detalle_Reparacion_Subtotal_Repuesto,
    M.Detalle_Reparacion_Precio_Unitario_Repuesto,
    M.Detalle_Reparacion_Cantidad_Repuesto
from gd_esquema.Maestra M 
    INNER JOIN ESTRESHADAS.Reparacion R
    on R.nro_reparacion = M.Reparacion_Nro_Reparacion
    INNER JOIN ESTRESHADAS.Repuesto REPU
    on REPU.cod_repuesto = M.Repuesto_Cod_Repuesto