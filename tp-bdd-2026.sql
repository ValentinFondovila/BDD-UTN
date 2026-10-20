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
    id_cliente BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_localidad BIGINT NOT NULL REFERENCES ESTRESHADAS.localidad(id_localidad),
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

create table ESTRESHADAS.estado_reparacion (
    id_est_reparacion BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    dscr_est_reparacion varchar(255) NULL
)

create table ESTRESHADAS.categoria_repuesto (
    id_cat_repuesto BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    dscr_cat_repuesto varchar(255) NULL
)

create table ESTRESHADAS.repuesto (
    id_repuesto BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_cat_repuesto BIGINT NOT NULL REFERENCES ESTRESHADAS.categoria_repuesto(id_cat_repuesto),
    cod_repuesto varchar(255) NULL,
    precio_repuesto numeric(38,2) NULL,
    dscr_repuesto varchar(255) NULL,
    compt_repuesto varchar(255) NULL
)

create table ESTRESHADAS.reparacion (
    id_Reparacion BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_cliente BIGINT NOT NULL REFERENCES ESTRESHADAS.cliente(id_cliente),
    id_empleado BIGINT NOT NULL REFERENCES ESTRESHADAS.empleado(id_empleado),
    id_producto BIGINT NOT NULL REFERENCES ESTRESHADAS.producto(id_producto),
    id_est_reparacion BIGINT NOT NULL REFERENCES ESTRESHADAS.estado_reparacion(id_est_reparacion),
    nro_reparacion int NULL,
    nro__bici_cli_reparacion varchar(255) NULL,
    fec_ingr_reparacion date NULL,
    fec_entrega_reparacion date NULL,
    fec_ent_real_reparacion date NULL,
    diag_reparacion varchar(255) NULL,
    prec_mano_reparacion numeric(38,2) NULL,
    prec_rep_reparacion numeric(38,2) NULL,
    total_reparacion numeric(38,2) NULL
)

create table ESTRESHADAS.detalle_reparacion (
    id_det_reparacion BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_reparacion BIGINT NOT NULL REFERENCES ESTRESHADAS.reparacion(id_reparacion),
    id_repuesto BIGINT NOT NULL REFERENCES ESTRESHADAS.repuesto(id_repuesto),
    subtot_det_reparacion numeric(38,2) NULL,
    prec_unit_det_reparacion numeric(38,2) NULL,
    cant_det_reparacion int NULL
)
