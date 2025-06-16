

-- Procedimiento para registrar un nuevo contrato de servicio,
-- Si el ciudadano y servicio existen antes de registrar el contrato

SELECT MAX(ID_CONTRATO) FROM CONTRATOSERVICIO;
CREATE SEQUENCE SEQ_CONTRATO START WITH 30 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE registrar_contrato_servicio(
  p_id_ciudadano IN INT,
  p_id_servicio IN INT,
  p_direccion_suministro IN NVARCHAR2,
  p_fecha_inicio IN DATE,
  p_estado IN NVARCHAR2
)
IS
  v_existe INT;
BEGIN
  -- Verificar si el ciudadano existe
  SELECT COUNT(*) INTO v_existe
  FROM Ciudadano
  WHERE id_ciudadano = p_id_ciudadano;

  IF v_existe = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'El ciudadano no existe.');
  END IF;

  -- Verificar si el servicio existe
  SELECT COUNT(*) INTO v_existe
  FROM Servicio
  WHERE id_servicio = p_id_servicio;

  IF v_existe = 0 THEN
    RAISE_APPLICATION_ERROR(-20002, 'El servicio no existe.');
  END IF;

  -- Insertar el contrato
  INSERT INTO ContratoServicio(
    id_contrato, id_ciudadano, id_servicio, direccion_suministro, fecha_inicio, estado_contrato
  )
  VALUES (
    SEQ_CONTRATO.NEXTVAL, p_id_ciudadano, p_id_servicio, p_direccion_suministro, p_fecha_inicio, p_estado
  );
END registrar_contrato_servicio;

EXEC registrar_contrato_servicio(1, 1, 'Calle 3, San José', TO_DATE('2024-05-12', 'YYYY-MM-DD'), 'Desactivado');

--SHOW ERRORS PROCEDURE registrar_contrato_servicio; Se ejecuta en caso de tener erorres

SELECT * FROM CONTRATOSERVICIO;
SELECT * FROM SERVICIO;

-- Procedimiento para cambiar estado del contrato de servicio,
-- Actualiza el campo estado_contrato al nuevo estado

CREATE OR REPLACE PROCEDURE cambiar_estado_contrato(
  p_id_contrato IN INT,
  p_nuevo_estado IN NVARCHAR2
)
IS
v_existe INT;

BEGIN

--Ingresa los Id's de la tabla
--de ServicioContratro para proceder con la verificacion  
SELECT COUNT(*) INTO v_existe FROM contratoServicio 
WHERE id_contrato = p_id_contrato;

-- Verificar si el Id del servicio existe
IF v_existe = 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'El ID del contrato no existe.');
END IF;

UPDATE ContratoServicio
SET estado_contrato = p_nuevo_estado
WHERE id_contrato = p_id_contrato;

END cambiar_estado_contrato;
--Visualiza datos antes de los cambios
SELECT * FROM contratoServicio
--Se realizan los cambios 
EXEC cambiar_estado_contrato(3, 'Suspendido');
--Visualiza datos despues de los cambios
SELECT * FROM contratoServicio

--Procedimiento para validar el registro de un nuevo pago
--Validar que el monto_pagado sea >= monto_total
SELECT * FROM Pago
SELECT * FROM Factura

UPDATE Factura
SET ESTADO_FACTURA = 'Pendiente'
Where ID_FACTURA = 6
CREATE SEQUENCE SEQ_PAGO START WITH 29 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE validar_y_registro_pago_nuevo(
  p_id_factura IN INT,
  p_monto_pagado IN INT,
  p_referencia_transaccion IN NVARCHAR2
)
IS
  v_estado_factura NVARCHAR2(100);
  v_monto_total NUMBER(10,2);
  v_vuelto NUMBER(10,2);  -- mejor que INT, para permitir decimales

BEGIN
  -- Verificar que la factura exista y obtener su estado y monto_total
  SELECT estado_factura, monto_total
  INTO v_estado_factura, v_monto_total
  FROM Factura
  WHERE id_factura = p_id_factura;

  -- Verificar que la factura esté pendiente
  IF v_estado_factura != 'Pendiente' THEN
    RAISE_APPLICATION_ERROR(-20001, 'La factura no está pendiente de pago.');
  END IF;

  -- Verificar que el monto pagado sea suficiente
  IF p_monto_pagado < v_monto_total THEN
    RAISE_APPLICATION_ERROR(-20002, 'El monto pagado es menor al monto total de la factura.');
  END IF;

  -- Calcular el vuelto (si hay)
  v_vuelto := p_monto_pagado - v_monto_total;

  -- Insertar el registro en la tabla Pago
  INSERT INTO Pago(
    id_pago,
    id_factura,
    fecha_pago,
    monto_pagado,
    vuelto_cambio,
    referencia_transaccion
  )
  VALUES (
    SEQ_PAGO.NEXTVAL,
    p_id_factura,
    SYSDATE,
    p_monto_pagado,
    v_vuelto,
    p_referencia_transaccion
  );

  -- Cambiar el estado de la factura a 'Pagada'
  UPDATE Factura
  SET estado_factura = 'Pagada'
  WHERE id_factura = p_id_factura;

  DBMS_OUTPUT.PUT_LINE('Pago registrado exitosamente.');
END validar_y_registro_pago_nuevo;



EXEC validar_y_registro_pago_nuevo(6, 10000, 'TRX-95162-ProcedimientoAl');

--*******************************************************************************************************************
--**********************************************************TRIGGERS*************************************************
--**********************************************************TRIGGERS************************************************
--**********************************************************TRIGGERS**************************************************
--**********************************************************TRIGGERS*************************************************
--*******************************************************************************************************************

--Trigger para evitar que un ciudadano tenga dis contratos activos para un mismo servicio
CREATE OR REPLACE TRIGGER tgr_validar_contrato_unico
BEFORE INSERT ON ContratoServicio
FOR EACH ROW
DECLARE
  v_existe NUMBER;
BEGIN
  -- Contar cuántos contratos activos tiene ese ciudadano para ese servicio
  SELECT COUNT(*)
  INTO v_existe
  FROM ContratoServicio
  WHERE id_ciudadano = :NEW.id_ciudadano
    AND id_servicio = :NEW.id_servicio
    AND estado_contrato = 'Activo';

  -- Si ya hay uno o más, lanzar error
  IF v_existe > 0 THEN
    RAISE_APPLICATION_ERROR(-20010, 'El ciudadano ya tiene un contrato activo para este servicio.');
  END IF;
END;
SELECT * FROM ContratoServicio

INSERT INTO ContratoServicio VALUES (35, 25, 10, 'San José, Zapote, frente al parque', TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'Activo');

--Trigger para evitar pagos con monto negativo

CREATE OR REPLACE TRIGGER tgr_validar_pago_positivo
BEFORE INSERT ON Pago
FOR EACH ROW
BEGIN
  IF :NEW.monto_pagado < 0 THEN
    RAISE_APPLICATION_ERROR(-20020, 'El monto pagado no puede ser negativo.');
  END IF;
END;

