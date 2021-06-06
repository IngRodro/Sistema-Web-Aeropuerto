-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sistemaaeropuerto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sistemaaeropuerto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistemaaeropuerto` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sistemaaeropuerto` ;

-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`aeropuerto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`aeropuerto` (
  `idAeropuerto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAeropuerto`))
ENGINE = InnoDB
AUTO_INCREMENT = 49
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`avion` (
  `idAvion` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(45) NULL DEFAULT NULL,
  `capacidad` INT NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAvion`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`clases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`clases` (
  `idClases` INT NOT NULL AUTO_INCREMENT,
  `nombreClase` VARCHAR(45) NULL DEFAULT NULL,
  `nAsientos` INT NULL DEFAULT NULL,
  `idAvion` INT NULL DEFAULT NULL,
  `porcentajeEPrecio` FLOAT NULL DEFAULT NULL,
  `estado` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idClases`),
  INDEX `FK_Clases_Vuelo_idx` (`idAvion` ASC) VISIBLE,
  CONSTRAINT `FK_Clases_Avion`
    FOREIGN KEY (`idAvion`)
    REFERENCES `sistemaaeropuerto`.`avion` (`idAvion`))
ENGINE = InnoDB
AUTO_INCREMENT = 42
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`company` (
  `idCompany` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCompany`))
ENGINE = InnoDB
AUTO_INCREMENT = 45
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`itinerario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`itinerario` (
  `idItinerario` INT NOT NULL AUTO_INCREMENT,
  `idAeropuertoDestino` INT NULL DEFAULT NULL,
  `idAeropuertoOrigen` INT NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  `hora` VARCHAR(3) NULL DEFAULT NULL,
  `minutos` VARCHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`idItinerario`),
  INDEX `FK_Iterinario_Aeropuerto_O_idx` (`idAeropuertoOrigen` ASC) VISIBLE,
  INDEX `FK_Iterinario_Aeropuerto_D_idx` (`idAeropuertoDestino` ASC) VISIBLE,
  CONSTRAINT `FK_Iterinario_Aeropuerto_D`
    FOREIGN KEY (`idAeropuertoDestino`)
    REFERENCES `sistemaaeropuerto`.`aeropuerto` (`idAeropuerto`),
  CONSTRAINT `FK_Iterinario_Aeropuerto_O`
    FOREIGN KEY (`idAeropuertoOrigen`)
    REFERENCES `sistemaaeropuerto`.`aeropuerto` (`idAeropuerto`))
ENGINE = InnoDB
AUTO_INCREMENT = 40
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`escala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`escala` (
  `idEscala` INT NOT NULL AUTO_INCREMENT,
  `numeroEscala` INT NULL DEFAULT NULL,
  `idAeropuerto` INT NULL DEFAULT NULL,
  `idItinerario` INT NULL DEFAULT NULL,
  `Precio` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`idEscala`),
  INDEX `FK_Escala_Aeropuerto_idx` (`idAeropuerto` ASC) VISIBLE,
  INDEX `FK_Escala_Iterinario_idx` (`idItinerario` ASC) VISIBLE,
  CONSTRAINT `FK_Escala_Aeropuerto`
    FOREIGN KEY (`idAeropuerto`)
    REFERENCES `sistemaaeropuerto`.`aeropuerto` (`idAeropuerto`),
  CONSTRAINT `FK_Escala_Iterinario`
    FOREIGN KEY (`idItinerario`)
    REFERENCES `sistemaaeropuerto`.`itinerario` (`idItinerario`))
ENGINE = InnoDB
AUTO_INCREMENT = 39
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`pasajero` (
  `idPasajero` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `edad` INT NULL DEFAULT NULL,
  `sexo` VARCHAR(45) NULL DEFAULT NULL,
  `documentoIdentidad` VARCHAR(45) NULL DEFAULT NULL,
  `pasaporte` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idPasajero`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`usuarios` (
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `edad` INT NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `Password` VARCHAR(500) NULL DEFAULT NULL,
  `TipoUsuario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`nombreUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`tipos_vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`tipos_vuelo` (
  `idTipos_vuelo` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(45) NULL DEFAULT NULL,
  `PorcentajeDesc` FLOAT NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipos_vuelo`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`vuelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`vuelo` (
  `idVuelo` INT NOT NULL AUTO_INCREMENT,
  `idCompany` INT NULL DEFAULT NULL,
  `idItinerario` INT NULL DEFAULT NULL,
  `idAvion` INT NULL DEFAULT NULL,
  `idTiposvuelo` INT NULL DEFAULT NULL,
  `estado` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idVuelo`),
  INDEX `FK_Vuelo_Avion_idx` (`idAvion` ASC) VISIBLE,
  INDEX `FK_Vuelo_Iterinario_idx` (`idItinerario` ASC) VISIBLE,
  INDEX `FK_Vuelo_Company_idx` (`idCompany` ASC) VISIBLE,
  INDEX `FK_Vuelo_Tipos_Vuelo_idx` (`idTiposvuelo` ASC) VISIBLE,
  CONSTRAINT `FK_Vuelo_Avion`
    FOREIGN KEY (`idAvion`)
    REFERENCES `sistemaaeropuerto`.`avion` (`idAvion`),
  CONSTRAINT `FK_Vuelo_Company`
    FOREIGN KEY (`idCompany`)
    REFERENCES `sistemaaeropuerto`.`company` (`idCompany`),
  CONSTRAINT `FK_Vuelo_Iterinario`
    FOREIGN KEY (`idItinerario`)
    REFERENCES `sistemaaeropuerto`.`itinerario` (`idItinerario`),
  CONSTRAINT `FK_Vuelo_Tipos_Vuelo`
    FOREIGN KEY (`idTiposvuelo`)
    REFERENCES `sistemaaeropuerto`.`tipos_vuelo` (`idTipos_vuelo`))
ENGINE = InnoDB
AUTO_INCREMENT = 44
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`pasaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`pasaje` (
  `idPasaje` INT NOT NULL AUTO_INCREMENT,
  `idPasajero` INT NULL DEFAULT NULL,
  `idVuelo` INT NULL DEFAULT NULL,
  `idClase` INT NULL DEFAULT NULL,
  `NAsiento` INT NULL DEFAULT NULL,
  `nombreUsuario` VARCHAR(45) NULL DEFAULT NULL,
  `precioTotal` FLOAT NULL DEFAULT NULL,
  `NEscala` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idPasaje`),
  INDEX `FK_Pasaje_Vuelo_idx` (`idVuelo` ASC) VISIBLE,
  INDEX `FK_Pasaje_Pasajero_idx` (`idPasajero` ASC) VISIBLE,
  INDEX `FK_Pasaje_Usuario_idx` (`nombreUsuario` ASC) VISIBLE,
  INDEX `FK_Pasaje_Clase_idx` (`idClase` ASC) VISIBLE,
  CONSTRAINT `FK_Pasaje_Clase`
    FOREIGN KEY (`idClase`)
    REFERENCES `sistemaaeropuerto`.`clases` (`idClases`),
  CONSTRAINT `FK_Pasaje_Pasajero`
    FOREIGN KEY (`idPasajero`)
    REFERENCES `sistemaaeropuerto`.`pasajero` (`idPasajero`),
  CONSTRAINT `FK_Pasaje_Usuario`
    FOREIGN KEY (`nombreUsuario`)
    REFERENCES `sistemaaeropuerto`.`usuarios` (`nombreUsuario`),
  CONSTRAINT `FK_Pasaje_Vuelo`
    FOREIGN KEY (`idVuelo`)
    REFERENCES `sistemaaeropuerto`.`vuelo` (`idVuelo`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemaaeropuerto`.`promocionesvuelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemaaeropuerto`.`promocionesvuelos` (
  `idPromocionesvuelos` INT NOT NULL AUTO_INCREMENT,
  `FechaInicio` DATE NULL DEFAULT NULL,
  `FechaFinal` DATE NULL DEFAULT NULL,
  `Descuento` DOUBLE NULL DEFAULT NULL,
  `idVuelo` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idPromocionesvuelos`),
  INDEX `FK_Promocionesvuelos_Vuelos_idx` (`idVuelo` ASC) VISIBLE,
  CONSTRAINT `FK_Promocionesvuelos_Vuelos`
    FOREIGN KEY (`idVuelo`)
    REFERENCES `sistemaaeropuerto`.`vuelo` (`idVuelo`))
ENGINE = InnoDB
AUTO_INCREMENT = 34
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `sistemaaeropuerto` ;

-- -----------------------------------------------------
-- procedure SP_A_Aeropuerto
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_A_Aeropuerto`(PNombre varchar(45))
BEGIN
	Update aeropuerto set estado = 'Activo' where nombre = PNombre;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_A_Clase
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_A_Clase`(
PnombreClase varchar(45), 
PidAvion int, 
PnAsientos int,
PPorcentajeEprecio float)
BEGIN
	Update clases set nAsientos = PnAsientos ,idAvion = PidAvion, PorcentajeEprecio = PPorcentajeEprecio, estado = 1 where nombreClase = PnombreClase and idAvion = PidAvion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_A_Company
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_A_Company`(PNombre varchar(45))
BEGIN
	Update company set estado = 'Activo' where nombre = PNombre;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_A_Tipo
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_A_Tipo`(PTipo varchar(45))
BEGIN

update tipos_vuelo set estado = 'Activo' where Tipo = PTipo;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Aeropuerto
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Aeropuerto`(
PidAeropuerto int(11)
)
BEGIN
update aeropuerto set Estado = 'Inactivo' where idAeropuerto = PidAeropuerto;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Avion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Avion`(PidAvion int(11))
BEGIN
	Update avion set estado = 'Inactivo' where idAvion = PidAvion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Clase
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Clase`(PidClase int)
BEGIN
	Update clases set estado = 0 where PidClase = idClases;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Company
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Company`(PidCompany int(11))
BEGIN
	Update company set estado = 'Inactivo' where idCompany = PidCompany;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Escala
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Escala`(PidEscala int)
BEGIN
	Delete from escala where idEscala = PidEscala;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Itinerario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Itinerario`(
PidItinerario int(11)
)
BEGIN
delete from iterinario where idIterinario = PidItinerario;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Pasaje
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Pasaje`(
PidPasaje int(11)
)
BEGIN
delete from pasaje where idPasaje = PidPasaje;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Pasajero
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Pasajero`(
PidPasajero int(11)
)
BEGIN
delete from pasajero where idPasajero = PidPasajero;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_D_Tipos
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_D_Tipos`(PidTipos_vuelo int)
BEGIN
	Update tipos_vuelo  set estado = 'Inactivo' where idTipos_vuelo = PidTipos_vuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Aeropuerto
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Aeropuerto`(
Pnombre varchar(45),
Ppais varchar(45),
Pciudad varchar(45)
)
BEGIN
INSERT INTO aeropuerto(nombre,pais,ciudad,Estado) value(Pnombre,Ppais,Pciudad,'Activo');
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Avion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Avion`(PModelo varchar(50), PCapacidad int)
BEGIN
	INSERT INTO avion(modelo,capacidad, estado) values (Pmodelo,Pcapacidad, 'Activo');
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Clase
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Clase`(
PnombreClase varchar(45),
PnAsientos int,
PidAvion int,
PPorcentajeEprecio float
)
BEGIN
	Insert into clases(nombreClase,nAsientos,idAvion,porcentajeEPrecio, estado) values(PnombreClase,PnAsientos,PidAvion,PPorcentajeEprecio, 1);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Company
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Company`(PNombre varchar(45))
BEGIN
	INSERT INTO company(nombre,estado) values (PNombre,'Activo');
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Escala
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Escala`( 
PnumeroEscala int,
PidAeropuerto int,
PidiIterinario int,
PPrecio float
)
BEGIN
	Insert into escala(numeroEscala,idAeropuerto,idItinerario, Precio) values(PnumeroEscala, PidAeropuerto, PidiIterinario, PPrecio);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Itinerario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Itinerario`(
PidAeropuertoDestino int(11),
PidAeropuertoOrigen int(11),
Pfecha date,
Phora varchar(3),
Pminutos varchar(3)
)
BEGIN
INSERT INTO itinerario(idAeropuertoDestino,idAeropuertoOrigen,fecha, hora, minutos) value(PidAeropuertoDestino,PidAeropuertoOrigen,Pfecha, Phora, Pminutos);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Pasaje
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Pasaje`(
PidPasajero int(11),
PidVuelo int(11),
PidClase int(11),
PNAsiento int(11),
PnombreUsuario varchar(45),
PprecioTotal float,
PNEscala int
)
BEGIN
INSERT INTO pasaje(idPasajero, idVuelo, idClase, NAsiento, nombreUsuario, precioTotal, NEscala) value(PidPasajero, PidVuelo, PidClase, PNAsiento, PnombreUsuario, PprecioTotal, PNEscala);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Pasajero
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Pasajero`(
PNombres varchar(50),
PApellidos varchar(50),
PEdad int(11),
PSexo varchar(50),
PDocumentoIdentidad varchar(50),
PPasaporte varchar(50)
)
BEGIN
insert into pasajero(nombres,apellidos,edad,sexo,documentoIdentidad,pasaporte) values(PNombres,PApellidos,PEdad,PSexo,PDocumentoIdentidad,PPasaporte);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Promocion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Promocion`(
PfechaInicio date,
PfechaFinal date,
PDescuento double
)
BEGIN
	Declare PidVuelo int;
    Set @PidVuelo = (Select max(idVuelo) FROM vuelo);
INSERT INTO promocionesvuelos(FechaInicio,FechaFinal,Descuento,idVuelo) value(PfechaInicio,PfechaFinal,PDescuento,@PidVuelo);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Tipos
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Tipos`(PTipo varchar(45), PDescuento float)
BEGIN
	INSERT INTO tipos_vuelo(Tipo, PorcentajeDesc, estado) values (PTipo,PDescuento, 'Activo');
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Usuario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Usuario`(
pNombreUsuario varchar(45),
pNombres varchar(45),
pApellidos varchar(45),
pEdad int(11),
pTelefono varchar(45),
pPassword varchar(45),
pTipoUser int
)
BEGIN
INSERT INTO usuarios(nombreUsuario,nombres,apellidos,edad,telefono,Password, TipoUsuario) values (pNombreUsuario,pNombres,pApellidos,pEdad,pTelefono,sha2(pPassword,512), pTipoUser);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_I_Vuelos
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_I_Vuelos`(PidCompany int, PidAvion int, PidTiposvuelo int)
BEGIN
	Declare PItinerio int;
    Set @PIterinario = (Select max(idItinerario) FROM itinerario);
	INSERT INTO vuelo(idCompany, idItinerario, idAvion, idTiposvuelo, estado) values (PidCompany,@PIterinario,PidAvion,PidTiposvuelo, 1);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Avion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Avion`(PidAvion int)
BEGIN
	SELECT * FROM sistemaaeropuerto.avion where idAvion = PidAvion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Clase
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Clase`(PidClases int)
BEGIN
	SELECT * FROM sistemaaeropuerto.clases where idClases = PidClases;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Escala
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Escala`(PidEscala int)
BEGIN
	SELECT * FROM sistemaaeropuerto.escala where idEscala = PidEscala;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Itinerario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Itinerario`(PidItinerario int)
BEGIN
	SELECT * FROM sistemaaeropuerto.itinerario where idItinerario = PidItinerario;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Promocion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Promocion`(PidVuelo int)
BEGIN
	SELECT * FROM sistemaaeropuerto.promocionesvuelos where idVuelo = PidVuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Tipo
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Tipo`(PidTipo int)
BEGIN
	select* from tipos_vuelo where idTipos_vuelo = PidTipo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Usuario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Usuario`(PnombreUsuario varchar(45))
BEGIN
	SELECT * FROM sistemaaeropuerto.usuarios where nombreUsuario = PnombreUsuario;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_1Vuelo
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_1Vuelo`(PidVuelo int)
BEGIN
	SELECT * FROM sistemaaeropuerto.vuelo where idVuelo = PidVuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Aeropuerto
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Aeropuerto`(
)
BEGIN
SELECT * FROM sistemaaeropuerto.aeropuerto;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_AeropuertosEscala
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_AeropuertosEscala`(PidItinerario int, PidAeropuerto int)
BEGIN
	SELECT * FROM sistemaaeropuerto.escala where idItinerario = PidItinerario and idAeropuerto = PidAeropuerto;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_AsientosPasaje
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_AsientosPasaje`(PidVuelo int, PidClase int)
BEGIN
	SELECT * FROM sistemaaeropuerto.pasaje where idVuelo = PidVuelo and idClase = PidClase;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Avion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Avion`(
)
BEGIN
SELECT * FROM sistemaaeropuerto.avion where estado = "Activo" or estado = "Ocupado";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_CRIPSHA2
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_CRIPSHA2`(PcripPass varchar(500))
BEGIN
	Select sha2(PcripPass,512) as crip;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Clase
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Clase`(PidAvion int)
BEGIN
	Select * from clases where idAvion = PidAvion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Company
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Company`(
)
BEGIN
	SELECT * FROM sistemaaeropuerto.company;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Escala
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Escala`(PidIterinario int)
BEGIN
	Select E.idEscala, E.numeroEscala, E.idAeropuerto , A.nombre, E.Precio, E.idItinerario from escala E
    INNER JOIN aeropuerto A ON E.idAeropuerto = A.idAeropuerto
    where E.idItinerario = PidIterinario
    order by E.numeroEscala;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Itinerario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Itinerario`(
)
BEGIN
SELECT * FROM sistemaaeropuerto.iterinario;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_LOGUINUSUARIO
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_LOGUINUSUARIO`(pUsuario varchar(50), pPass varchar(50))
BEGIN
select * from usuarios where nombreUsuario = pUsuario and password = sha2(pPass,512);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Pasaje
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Pasaje`(
PidVuelo int,
PNEscala int
)
BEGIN
SELECT * FROM sistemaaeropuerto.pasaje where idVuelo = PidVuelo and NEscala = PNEscala;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_PasajeClase
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_PasajeClase`(
PidVuelo int,
PidClase int
)
BEGIN
SELECT * FROM sistemaaeropuerto.pasaje where idVuelo = PidVuelo and idClase = PidClase;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_PasajeVuelo
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_PasajeVuelo`(
PidVuelo int
)
BEGIN
SELECT * FROM sistemaaeropuerto.pasaje where idVuelo = PidVuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Pasajero
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Pasajero`()
BEGIN

SELECT * FROM sistemaaeropuerto.pasajero;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Tipos
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Tipos`(
)
BEGIN
SELECT * FROM sistemaaeropuerto.tipos_vuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_VueloAvion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VueloAvion`(PidAvion int)
BEGIN
	Select * from vuelo where idAvion = PidAvion && estado != 0;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_VueloItinerario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VueloItinerario`(PidItinerario int)
BEGIN
	Select * from vuelo where idItinerario = PidItinerario;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Vuelos
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Vuelos`()
BEGIN
	SELECT vuelo.idVuelo Vuelo, company.nombre Compania, A1.nombre Aeropuerto_Origen, A2.nombre Aeropuerto_Destino, 
    avion.modelo Modelo_Avion, TV.Tipo Tipo_de_Vuelo, itinerario.fecha, itinerario.hora Hora, itinerario.minutos Minutos, 
    PV.Descuento Promo, PV.FechaFinal FechaMax, PV.FechaInicio FechaIni, vuelo.estado Estado
	FROM sistemaaeropuerto.vuelo 
	INNER JOIN company ON vuelo.idCompany = company.idCompany 
	INNER JOIN itinerario ON vuelo.idItinerario = itinerario.idItinerario  
	INNER JOIN aeropuerto A1 ON itinerario.idAeropuertoOrigen = A1.idAeropuerto 
	INNER JOIN aeropuerto A2 ON itinerario.idAeropuertoDestino = A2.idAeropuerto
	INNER JOIN avion ON vuelo.idAvion = avion.idAvion
	INNER JOIN tipos_vuelo TV ON vuelo.idTiposvuelo = TV.idTipos_vuelo
    INNER JOIN promocionesvuelos PV ON vuelo.idVuelo = PV.idVuelo
    order by Vuelo asc;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_VuelosId
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VuelosId`()
BEGIN
	SELECT vuelo.idVuelo Vuelo, company.idCompany  , company.nombre Compania, A1.idAeropuerto idAeropuertoO,A1.nombre Aeropuerto_Origen, 
    A2.idAeropuerto idAeropuertoD, A2.nombre Aeropuerto_Destino, avion.idAvion, avion.modelo Modelo_Avion, TV.idTipos_vuelo, TV.Tipo Tipo_de_Vuelo,
    itinerario.fecha, itinerario.hora Hora, itinerario.minutos Minutos, 
    PV.Descuento Promo, PV.FechaFinal FechaMax, PV.FechaInicio FechaIni, vuelo.estado Estado
	FROM sistemaaeropuerto.vuelo 
	INNER JOIN company ON vuelo.idCompany = company.idCompany 
	INNER JOIN itinerario ON vuelo.idItinerario = itinerario.idItinerario  
	INNER JOIN aeropuerto A1 ON itinerario.idAeropuertoOrigen = A1.idAeropuerto 
	INNER JOIN aeropuerto A2 ON itinerario.idAeropuertoDestino = A2.idAeropuerto
	INNER JOIN avion ON vuelo.idAvion = avion.idAvion
	INNER JOIN tipos_vuelo TV ON vuelo.idTiposvuelo = TV.idTipos_vuelo
    INNER JOIN promocionesvuelos PV ON vuelo.idVuelo = PV.idVuelo
    order by Vuelo asc;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_VuelosOrigen
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_VuelosOrigen`(PidAeropuerto int)
BEGIN
	SELECT vuelo.idVuelo Vuelo, company.nombre Compania, A1.nombre Aeropuerto_Origen, A2.nombre Aeropuerto_Destino, avion.modelo Modelo_Avion, 
    TV.Tipo Tipo_de_Vuelo, itinerario.fecha, itinerario.hora Hora, itinerario.minutos Minutos, PV.Descuento Promo, PV.FechaFinal FechaMax,PV.FechaInicio FechaIni, vuelo.estado Estado
	FROM sistemaaeropuerto.vuelo 
	INNER JOIN company ON vuelo.idCompany = company.idCompany 
	INNER JOIN itinerario ON vuelo.idItinerario = itinerario.idItinerario  
	INNER JOIN aeropuerto A1 ON itinerario.idAeropuertoOrigen = A1.idAeropuerto 
	INNER JOIN aeropuerto A2 ON itinerario.idAeropuertoDestino = A2.idAeropuerto
	INNER JOIN avion ON vuelo.idAvion = avion.idAvion
	INNER JOIN tipos_vuelo TV ON vuelo.idTiposvuelo = TV.idTipos_vuelo
    INNER JOIN promocionesvuelos PV ON vuelo.idVuelo = PV.idVuelo
    where A1.idAeropuerto = PidAeropuerto;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_S_Vuelos_Escalas
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_S_Vuelos_Escalas`()
BEGIN
SELECT vuelo.idVuelo Vuelo, escala.numeroEscala, escala.precio,AE.nombre AeropuertoEscala , A1.idAeropuerto idAeropuertoO,A1.nombre Aeropuerto_Origen, 
	TV.idTipos_vuelo, TV.Tipo Tipo_de_Vuelo, TV.PorcentajeDesc,
    itinerario.fecha, itinerario.hora Hora, itinerario.minutos Minutos, 
    PV.Descuento Promo, PV.FechaFinal FechaMax, PV.FechaInicio FechaIni, vuelo.estado Estado
	FROM sistemaaeropuerto.escala
    INNER JOIN aeropuerto AE ON escala.idAeropuerto = AE.idAeropuerto
    INNER JOIN itinerario ON escala.idItinerario = itinerario.idItinerario
    INNER JOIN vuelo ON itinerario.idItinerario = vuelo.idItinerario
	INNER JOIN aeropuerto A1 ON itinerario.idAeropuertoOrigen = A1.idAeropuerto 
	INNER JOIN avion ON vuelo.idAvion = avion.idAvion
	INNER JOIN tipos_vuelo TV ON vuelo.idTiposvuelo = TV.idTipos_vuelo
    INNER JOIN promocionesvuelos PV ON vuelo.idVuelo = PV.idVuelo
    order by Vuelo,numeroEscala asc;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Aeropuerto
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Aeropuerto`(
PidAeropuerto int(11),
Pnombre varchar(45),
Ppais varchar(45),
Pciudad varchar(45)
)
BEGIN
update aeropuerto set nombre = Pnombre, pais = Ppais, ciudad = Pciudad where idAeropuerto = PidAeropuerto;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Avion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Avion`(PModelo varchar(50), PCapacidad int, PidAvion int(11))
BEGIN
	Update avion set modelo = Pmodelo , capacidad = Pcapacidad where idAvion = PidAvion;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Clase
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Clase`(
PnombreClase varchar(45),
PnAsientos int,
PPorcentajeEprecio float,
PidClase int
)
BEGIN
    Update clases set nombreClase = PnombreClase, nAsientos = PnAsientos , PorcentajeEprecio = PPorcentajeEprecio where idClases = PidClase;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Company
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Company`(PNombre varchar(45), PidCompany int(11))
BEGIN
	Update company set nombre = PNombre where idCompany = PidCompany;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Escala
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Escala`(PidEscala int, PidAeropuerto int, PPrecio double)
BEGIN
	Update escala set idAeropuerto = PidAeropuerto, Precio = PPrecio where idEscala = PidEscala;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_EstadoAvion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_EstadoAvion`(PidAvion int, PEstado varchar(20))
BEGIN
	Update avion set estado = PEstado where idAvion = PidAvion; 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_EstadoVuelo
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_EstadoVuelo`(
PEstado int,
PidVuelo int
)
BEGIN
   Update sistemaaeropuerto.vuelo set estado = PEstado where idVuelo = PidVuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Itinerario
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Itinerario`(
PidItinerario int(11),
PidAeropuertoDestino int(11),
PidAeropuertoOrigen int(11),
Pfecha date,
Phora varchar(3),
Pminutos varchar(3)
)
BEGIN
	Update sistemaaeropuerto.itinerario set idAeropuertoDestino = PidAeropuertoDestino, idAeropuertoOrigen = PidAeropuertoOrigen, fecha = Pfecha, hora = Phora, minutos = Pminutos where idItinerario = PidItinerario;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_NEscala
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_NEscala`(PidItinerario int, PNEscala int)
BEGIN
	Update escala set numeroEscala = PNEscala - 1 where idItinerario = PidItinerario and numeroEscala = PNEscala;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Pasaje
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Pasaje`(
PidPasaje int(11),
PidPasajero int(11),
PidVuelo int(11),
PidClase int(11),
PNAsiento int(11),
PnombreUsuario varchar(45),
PprecioTotal float
)
BEGIN
update sistemaaeropuerto.pasaje set idPasajero = PidPasajero, idVuelo = PidVuelo, idClase = PidClase, NAsiento = PNAsiento, nombreUsuario = PnombreUsuario, precioTotal = PprecioTotal where idPasaje = PidPasaje;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Pasajero
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Pasajero`(
PNombres varchar(50),
PApellidos varchar(50),
PEdad int(11),
PSexo varchar(50),
PDocumentoIdentidad varchar(50),
PPasaporte varchar(50),
PidPasajero int(11)
)
BEGIN
update pasajero set nombres = PNombres, apellidos = PApellidos, edad = PEdad, sexo = PSexo, documentoIdentidad = PDocumentoIdentidad, pasaporte = PPasaporte where idPasajero = PidPasajero;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Promocion
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Promocion`(
PfechaInicio date,
PfechaFinal date,
PDescuento double,
PidVuelo int
)
BEGIN
	Update promocionesvuelos set FechaInicio = PfechaInicio,FechaFinal = PfechaFinal,Descuento = PDescuento where idVuelo = PidVuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Tipos
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Tipos`(PTipo varchar(45), PDescuento float, PidTipos_vuelo int)
BEGIN
	Update tipos_vuelo  set Tipo = PTipo, PorcentajeDesc = PDescuento where idTipos_vuelo = PidTipos_vuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_VueloFinalizado
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_VueloFinalizado`(
PidVuelo int
)
BEGIN
    Update sistemaaeropuerto.vuelo set estado = 0 where idVuelo = PidVuelo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SP_U_Vuelos
-- -----------------------------------------------------

DELIMITER $$
USE `sistemaaeropuerto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_U_Vuelos`(
PidCompany int, 
PidAvion int, 
PidTiposvuelo int, 
PidVuelo int
)
BEGIN
    Update sistemaaeropuerto.vuelo set idCompany = PidCompany, idAvion = PidAvion, idTiposvuelo = PidTiposvuelo where idVuelo = PidVuelo;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
