/*Terminos importantes
CDB = Container DB  *** Contenedor principal, no se puede crear usuarios locales
PDB = Pluggable DB ** Las bases de datos que realmente tienen los objetos, datos etc
*/
SELECT SYS_CONTEXT('USERENV', 'CON_NAME') FROM DUAL;
SHOW PDBS;
ALTER SESSION SET CONTAINER = CDB$ROOT; /*CDB*/
ALTER SESSION SET CONTAINER = XEPDB1; /*PDB*/



CREATE USER C##leonardo IDENTIFIED BY pass123;
GRANT CREATE SESSION TO C##Leonardo;

SELECT username FROM dba_users  ORDER BY username; /*Verificar el usuario creado*/

CREATE ROLE C##rol_RH;
GRANT SELECT,INSERT, UPDATE ON Funcionario TO C##rol_RH;



GRANT CREATE SESSION TO C##rol_RH;

GRANT C##rol_RH TO C##Leonardo;

CREATE ROLE C##rol_funcionario_atencion_cliente;

GRANT SELECT ON Ciudadano TO C##rol_funcionario_atencion_cliente;
GRANT SELECT ON Factura TO C##rol_funcionario_atencion_cliente;
GRANT SELECT ON Pago TO C##rol_funcionario_atencion_cliente;
GRANT SELECT ON Servicio TO C##rol_funcionario_atencion_cliente
GRANT SELECT ON ContratoServicio TO C##rol_funcionario_atencion_cliente;
GRANT SELECT, INSERT ON Reclamo TO C##rol_funcionario_atencion_cliente;

CREATE ROLE C##rol_cajero
GRANT SELECT, INSERT ON Pago TO C##rol_cajero;
GRANT SELECT ON Factura TO C##rol_cajero;

CREATE ROLE C##rol_ciudadano
GRANT SELECT ON Ciudadano TO C##rol_ciudadano;
GRANT SELECT ON Factura TO  C##rol_ciudadano;
GRANT SELECT ON ContratoServicio TO C##rol_ciudadano;
REVOKE SELECT ON ContratoServicio TO C##rol_funcionario_atencion_cliente;

DROP ROLE C##rol_cajero

