use PRICINGDB;

CREATE TABLE `PRICINGDB`.`filtroCuentas` (
  `idFiltro` INT NOT NULL AUTO_INCREMENT,
  `tipo` INT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idFiltro`));
