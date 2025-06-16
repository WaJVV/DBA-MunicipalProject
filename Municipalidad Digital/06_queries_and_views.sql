-- 1. Lista todos los ciudadanos registrados, ordenados alfabéticamente por apellido.
 SELECT NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO FROM Ciudadano ORDER BY PRIMER_APELLIDO,SEGUNDO_APELLIDO;
-- 2. Muestra los funcionarios que pertenecen al Departamento de Tesoreria.
SELECT * FROM FUNCIONARIO;
SELECT * FROM DEPARTAMENTO;

SELECT
Departamento.Id_Departamento,
Funcionario.Nombre,
Funcionario.primer_apellido,
Departamento.Nombre_Departamento
FROM Funcionario
JOIN Departamento ON
Funcionario.id_departamento = Departamento.id_departamento
WHERE
departamento.nombre_departamento = 'Tesorería';

-- 3. Muestra los servicios contratados por un ciudadano usando su cédula.

-- 4. Consulta los ciudadanos que no han realizado ningún pago.

-- 5. Lista los reclamos realizados en los últimos 30 días.


-- 6. Crea una vista que muestre el historial de pagos con nombre del ciudadano, monto pagado y fecha.


-- 7. Crea una vista con los funcionarios y sus departamentos.


-- 8. Crea una vista que muestre las facturas vencidas (estado = 'Vencida').


-- 9. Crea una vista con los ciudadanos y los servicios que tienen contratados actualmente (estado_contrato = 'Activo').


-- 10. Crea una vista que relacione funcionarios con los accesos que han realizado al sistema.

