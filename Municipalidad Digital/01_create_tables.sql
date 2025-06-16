CREATE TABLE Ciudadano(
id_ciudadano INT PRIMARY KEY,
nombre NVARCHAR2(100),
primer_apellido NVARCHAR2(100),
segundo_apellido NVARCHAR2(100),
email NVARCHAR2(100),
telefono INT,
cedula INT,
direccion NVARCHAR2(100)
);

CREATE TABLE Funcionario(
id_funcionario INT PRIMARY KEY,
nombre NVARCHAR2(100),
primer_apellido NVARCHAR2(100),
segundo_apellido NVARCHAR2(100),
puesto NVARCHAR2(100),
id_departamento INT,
telefono INT
);

CREATE TABLE Departamento(
id_departamento INT PRIMARY KEY,
nombre_departamento NVARCHAR2(100),
descripcion NVARCHAR2(500)
);

CREATE TABLE Servicio(
id_servicio INT PRIMARY KEY,
nombre_servicio NVARCHAR2(100),
descripcion NVARCHAR2(500),
tarifa_base NUMBER(10,2),
tarifa_variable NUMBER(10,2)
);


CREATE TABLE ContratoServicio(
id_contrato INT PRIMARY KEY,
id_ciudadano INT,
id_servicio INT,
direccion_suministro NVARCHAR2(500),
fecha_inicio DATE,
estado_contrato NVARCHAR2(100)
);



CREATE TABLE Factura(
id_factura INT PRIMARY KEY,
id_contrato INT,
fecha_emision DATE,
fecha_vencimiento DATE,
consumo INT,
monto_total NUMBER(10,2),
estado_factura NVARCHAR2(100)
);

CREATE TABLE Pago(
id_pago INT PRIMARY KEY,
id_factura INT,
fecha_pago DATE,
monto_pagado NUMBER(10,2),
vuelto_cambio NUMBER(10,2),
referencia_transaccion NVARCHAR2(500)
);

CREATE TABLE Reclamo(
id_reclamo INT PRIMARY KEY, 
id_ciudadano INT,
id_factura INT,
tipo_reclamo  NVARCHAR2(100),
descripcion NVARCHAR2(500),
estado_reclamo NVARCHAR2(100),
fecha_reclamo DATE -- Default SYSDATE en caso de querer agregar la fecha automamtica
);

CREATE TABLE RegistroAcceso(
id_registro INT PRIMARY KEY,
id_funcionario INT,
accion_realizada NVARCHAR2(100),
fecha_registro DATE DEFAULT SYSDATE,
detalle NVARCHAR2(100)
);


