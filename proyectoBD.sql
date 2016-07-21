CREATE schema proyecto;

CREATE TABLE proyecto.persona (
  DNI_per varchar(20) NOT NULL,
  Nombre varchar(45) NOT NULL,
  Apellido varchar(45) NOT NULL,
  Direccion varchar(45) NOT NULL,
  Codigo_Postal int NOT NULL,
  Email varchar(45) default NULL,
  Facebook varchar(100) default NULL,
  Fecha_Nac date NOT NULL,
  Edad int NOT NULL,
  TelFijo varchar(45) default NULL,
  TelMovil varchar(45) default NULL,
  PRIMARY KEY  (DNI_per)
);

CREATE TABLE proyecto.padrino (
  DNI varchar(20) NOT NULL,
  PRIMARY KEY  (DNI),
  CONSTRAINT fk_padrino FOREIGN KEY (DNI) REFERENCES proyecto.persona (DNI_per)
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE TABLE proyecto.programa (
  nombre varchar(45) NOT NULL,
  descripcion varchar(255) default NULL,
  PRIMARY KEY (nombre)
 );

CREATE TABLE proyecto.donante (
  DNI_pad varchar(20) NOT NULL,
  ocupacion varchar(100) NOT NULL,
  cuil_cuit varchar (13) NOT NULL,
  PRIMARY KEY (DNI_pad),
  CONSTRAINT fk_donante FOREIGN KEY (DNI_pad) REFERENCES  proyecto.padrino (DNI)
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE DOMAIN proyecto.dom_estados AS varchar (20)
  CHECK (VALUE IN ('Sin Llamar', 'Error', 'En Gestion', 'Adherido', 'Amigo', 'No Acepta', 'Baja', 'Voluntario'));

CREATE TABLE proyecto.contacto (
  DNI_pad varchar(20) NOT NULL,
  estados proyecto.dom_estados NOT NULL,
  fPrimerContacto date NOT NULL,
  fAlta date,
  fBaja date,
  fRechazoAdhesion date,
  PRIMARY KEY (DNI_pad),
  CONSTRAINT fk_contacto FOREIGN KEY (DNI_pad) REFERENCES  proyecto.padrino  ( DNI )
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE TABLE proyecto.puede_ser (
  DNI_don varchar(20) NOT NULL,
  DNI_con varchar(20) NOT NULL,
  CONSTRAINT fk_ser1 FOREIGN KEY (DNI_don) REFERENCES proyecto.donante (DNI_pad)
  ON UPDATE CASCADE  
  ON DELETE CASCADE,
  CONSTRAINT fk_ser2 FOREIGN KEY (DNI_con) REFERENCES proyecto.contacto (DNI_pad)
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE TABLE proyecto.referencia(
  DNI_per varchar(20) NOT NULL,
  DNI_pad varchar(20) NOT NULL,
  relacion varchar(255),
  comentario varchar(255),
  CONSTRAINT fk_referencia1 FOREIGN KEY (DNI_per) REFERENCES proyecto.persona (DNI_per)
  ON UPDATE CASCADE  
  ON DELETE CASCADE,
  CONSTRAINT fk_referencia2 FOREIGN KEY (DNI_pad) REFERENCES proyecto.contacto (DNI_pad)
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE TABLE proyecto.MedioDePago (
  id_MedioPago varchar(45) NOT NULL,
  PRIMARY KEY (id_MedioPago)
);

CREATE TABLE proyecto.nombre_tarjeta (
  nombre varchar(45) NOT NULL,
  PRIMARY KEY (nombre)
);

CREATE TABLE proyecto.tarjetaCredito (
  nombre_tarjeta varchar(45) NOT NULL,
  id_mp_credito varchar(45) NOT NULL,
  nro_tarjeta varchar(16) NOT NULL,
  fecha_vto date NOT NULL,
  cvv varchar(3) NOT NULL,
  PRIMARY KEY (id_mp_credito),
  CONSTRAINT fk_credito1 FOREIGN KEY (id_mp_credito) REFERENCES proyecto.MedioDePago (id_MedioPago)
  ON UPDATE CASCADE  
  ON DELETE CASCADE,
  CONSTRAINT fk_credito2 FOREIGN KEY (nombre_tarjeta) REFERENCES proyecto.nombre_tarjeta (nombre)
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE TABLE proyecto.tarjetaDebito_transferencia (
  id_mp_debito varchar(45) NOT NULL,
  tipoCuenta varchar(45) NOT NULL,
  cbu int NOT NULL,
  nro_cuenta int NOT NULL,
  nombre_bco varchar(45) NOT NULL,
  sucursal_bco varchar (45) NOT NULL,
  PRIMARY KEY (id_mp_debito),
  CONSTRAINT fk_debito FOREIGN KEY (id_mp_debito) REFERENCES proyecto.MedioDePago (id_MedioPago)
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE TABLE proyecto.aporta (
  DNI_don varchar(20) NOT NULL,
  nombre_prog varchar(45) NOT NULL,
  id_mp varchar (45) NOT NULL,
  monto varchar (10),
  frecuencia varchar (20),
  PRIMARY KEY (DNI_don, nombre_prog),
  CONSTRAINT fk_aporta1 FOREIGN KEY (DNI_don) REFERENCES proyecto.donante (DNI_pad)
  ON UPDATE CASCADE  
  ON DELETE CASCADE,
  CONSTRAINT fk_aporta2 FOREIGN KEY (nombre_prog) REFERENCES proyecto.programa (nombre)
  ON UPDATE CASCADE  
  ON DELETE CASCADE,
  CONSTRAINT fk_aporta3 FOREIGN KEY (id_mp) REFERENCES proyecto.MedioDePago (id_MedioPago)
  ON UPDATE CASCADE  
  ON DELETE CASCADE
);

CREATE TABLE proyecto.donantes_eliminados (
  DNI varchar(20) NOT NULL,
  ocupacion varchar(100) NOT NULL,
  cuil_cuit varchar(13) NOT NULL,
  usuario_eliminador varchar(45) NOT NULL,
  fecha_eliminacion date NOT NULL,
  constraint pk_eliminado primary key (DNI)
);

INSERT INTO proyecto.persona VALUES
  ('38883516', 'Gino', 'Carignano', 'Mariano Moreno 351', '6140', 'gino.jc@hotmail.com', 'ginoCarignano', '1995-08-18', '20', '3583484003', '3583435314'),
  ('38883418', 'Santiago', 'Cuello', 'constitucion 123', '5800', 'santi@hotmail.com', 'santiCuello', '1994-03-12', '21', '3584805003', '3584353327'),
  ('38883000', 'Pablo', 'Martinez', 'La Rioja 935', '5800', 'pablin@hotmail.com', 'pabloMart', '1995-01-10', '21', '3584201234', '358456789012');

INSERT INTO proyecto.padrino VALUES 
  ('38883516'),
  ('38883418'),
  ('38883000');
  
INSERT INTO proyecto.donante VALUES
  ('38883516', '20-38883516-9', 'Empleado'),
  ('38883418', '20-38883418-7','Taxista');

INSERT INTO proyecto.contacto VALUES
  ('38883000', 'Amigo', '2015-05-24', '2015-05-30', '2016-01-14'),
  ('38883516', 'Adherido', '2010-01-01', '2010-01-01', '2010-01-01'),
  ('38883418', 'Amigo','2011-09-20', '2010-01-01', '2010-01-01');
  

INSERT INTO proyecto.programa VALUES
  ('Comida', 'Alimento para los niños'),
  ('ropa', 'ropa para los chicos');

INSERT INTO proyecto.MedioDePago VALUES
  ('1-C'),
  ('2-C'),
  ('3-C'),
  ('4-C'),
  ('5-C'),
  ('1-D'),
  ('2-D'),
  ('3-D'),
  ('4-D'),
  ('5-D');

INSERT INTO proyecto.aporta VALUES
  ('38883516', 'ropa', '1-D', '1000', 'mensual'),
  ('38883418', 'Comida', '1-C', '20000', 'anual');

INSERT INTO proyecto.nombre_tarjeta VALUES
  ('Naranja'),
  ('Mastercard'),
  ('Cordoba'),
  ('Visa');

INSERT INTO proyecto.tarjetacredito VALUES
  ('Naranja', '1-C', '12345678', '2019-10-24', '012'),
  ('Mastercard', '2-C', '98765432', '2016-12-31', '345'),
  ('Visa','3-C', '23434514', '2010-01-12', '432'),
  ('Naranja', '4-C', '12345678', '2017-09-04', '978');

insert into proyecto.tarjetadebito_transferencia values
  ('1-D', 'cta cte', '12345678', '012', 'Santander', '12'),
  ('2-D', 'caja de ahorro', '98765432', '345', 'Bancor', '32'),
  ('3-D', 'cta cte', '23434514', '432', 'Nacion', '24'),
  ('4-D', 'caja de ahorro', '12345678', '978', 'Santander', '23');


--Trigger que realiza la auditoria del donante eliminado, es decir, agrega los datos del donante eliminado a la tabla "Donantes_Eliminados" para que no se pierdan.

CREATE FUNCTION proyecto.auditoria() RETURNS TRIGGER AS $$
  BEGIN
    INSERT INTO proyecto.donantes_eliminados VALUES (OLD.dni_pad, OLD.ocupacion, OLD.cuil_cuit, CURRENT_USER, NOW());
    RETURN NEW;
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER trigger_eliminacion_donante AFTER DELETE 
  ON proyecto.donante FOR EACH ROW EXECUTE PROCEDURE proyecto.auditoria();
  

--Trigger que elimina el programa al cual aportaba el donante eliminado.

CREATE FUNCTION proyecto.eliminar_programa() RETURNS TRIGGER AS $$
  BEGIN
    DELETE FROM proyecto.programa WHERE (OLD.nombre_prog = nombre);
    RETURN NEW;
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER eliminacion_programa AFTER DELETE 
  ON proyecto.aporta FOR EACH ROW EXECUTE PROCEDURE proyecto.eliminar_programa();


--Trigger que elimina el medio de pago que utilizaba el donante para realizar los aportes a determinado programa.

CREATE FUNCTION proyecto.eliminar_MedioDePago() RETURNS TRIGGER AS $$
  BEGIN
    DELETE FROM proyecto.MedioDePago WHERE (OLD.id_mp = id_mediopago);
    RETURN NEW;
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER eliminacion_MedioDePago AFTER DELETE 
  ON proyecto.aporta FOR EACH ROW EXECUTE PROCEDURE proyecto.eliminar_MedioDePago();


--Trigger que cambia el estado del cliente (que haya sido donante y se lo haya eliminado) a 'Baja' y se agrega la fecha de baja del mismo.

CREATE FUNCTION proyecto.estado_contacto() RETURNS TRIGGER AS $$
  BEGIN
    UPDATE proyecto.contacto SET estados = 'Baja', fBaja = NOW() 
    WHERE DNI_pad = OLD.DNI_pad;
    RETURN NEW;
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER trigger_estado_contacto AFTER DELETE 
  ON proyecto.donante FOR EACH ROW EXECUTE PROCEDURE proyecto.estado_contacto();



