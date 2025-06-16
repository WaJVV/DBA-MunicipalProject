--Relacion Funcionario - Departamento

ALTER TABLE Funcionario
ADD CONSTRAINT fk_funcionario_departamento
FOREIGN KEY(id_departamento) REFERENCES Departamento(id_departamento);

CREATE INDEX idx_funcionario_departamento ON Funcionario(id_departamento);

-- Relación ContratoServicio - Ciudadano

ALTER TABLE ContratoServicio
ADD CONSTRAINT fk_contrato_ciudadano
FOREIGN KEY(id_ciudadano) REFERENCES Ciudadano(id_ciudadano);

-- Relación ContratoServicio - Servicio

ALTER TABLE ContratoServicio
ADD CONSTRAINT fk_contrato_servicio
FOREIGN KEY(id_servicio) REFERENCES Servicio(id_servicio);

CREATE INDEX idx_contrato_ciudadano ON ContratoServicio(id_ciudadano);
CREATE INDEX idx_contrato_servicio ON ContratoServicio(id_servicio);

-- Relación Factura - Contrato
ALTER TABLE Factura
ADD CONSTRAINT fk_factura_contrato
FOREIGN KEY (id_contrato) REFERENCES ContratoServicio(id_contrato);

CREATE INDEX idx_factura_contrato ON Factura(id_contrato);


-- Relación Pago - Factura
ALTER TABLE Pago
ADD CONSTRAINT fk_pago_factura
FOREIGN KEY (id_factura) REFERENCES Factura(id_factura);

CREATE INDEX idx_pago_factura ON Pago(id_factura);

-- Relación Reclamo - Ciudadano
ALTER TABLE Reclamo
ADD CONSTRAINT fk_reclamo_ciudadano
FOREIGN KEY (id_ciudadano) REFERENCES Ciudadano(id_ciudadano);

-- Relación Reclamo - Factura
ALTER TABLE Reclamo
ADD CONSTRAINT fk_reclamo_factura
FOREIGN KEY (id_factura) REFERENCES Factura(id_factura);

CREATE INDEX idx_reclamo_ciudadano ON Reclamo(id_ciudadano);
CREATE INDEX idx_reclamo_factura ON Reclamo(id_factura);

-- Relación RegistroAcceso - Funcionario
ALTER TABLE RegistroAcceso
ADD CONSTRAINT fk_registro_funcionario
FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario);

CREATE INDEX idx_registro_funcionario ON RegistroAcceso(id_funcionario);