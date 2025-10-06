CREATE DATABASE  IF NOT EXISTS `PRICINGDB_LOCAL` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `PRICINGDB_LOCAL`;

DROP TABLE IF EXISTS `adquirencia`;
CREATE TABLE `adquirencia` (
  `idadquirencia` int NOT NULL AUTO_INCREMENT,
  `tipoAdquirencia` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `puntos` int DEFAULT NULL,
  `tarifaCosto` int DEFAULT NULL,
  `cod_usu` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idadquirencia`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `asignaciones`;
CREATE TABLE `asignaciones` (
  `idasignacion` int NOT NULL AUTO_INCREMENT,
  `codSolicitud` int DEFAULT NULL,
  `codEnte` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codTipo` int DEFAULT NULL,
  `fechaAsignacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idasignacion`)
) ENGINE=InnoDB AUTO_INCREMENT=1608 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `asoc`;
CREATE TABLE `asoc` (
  `COD_ASOC` int DEFAULT NULL,
  `ASOC` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `calificacion`;
CREATE TABLE `calificacion` (
  `COD_CALIF_MES` int NOT NULL AUTO_INCREMENT,
  `CALIF_MES` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COD_CALIF_MES`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `canal`;
CREATE TABLE `canal` (
  `COD_CANAL_RAD` int NOT NULL AUTO_INCREMENT,
  `CANAL_RAD` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`COD_CANAL_RAD`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cargos`;
CREATE TABLE `cargos` (
  `COD_CARGO` int NOT NULL AUTO_INCREMENT,
  `CARGO` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`COD_CARGO`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `coberturaFng`;
CREATE TABLE `coberturaFng` (
  `idcoberturaFng` int NOT NULL AUTO_INCREMENT,
  `codCobertura` int DEFAULT NULL,
  `valor` int DEFAULT NULL,
  `descripcion` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idcoberturaFng`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `controlBuzon`;
CREATE TABLE `controlBuzon` (
  `idcontrolBuzon` int NOT NULL AUTO_INCREMENT,
  `cod_solicitud` int NOT NULL,
  `buzon` varchar(9) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cod_usu` char(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fech_carga` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcontrolBuzon`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `controlDocumentos`;
CREATE TABLE `controlDocumentos` (
  `idcontrolDocumentos` int NOT NULL AUTO_INCREMENT,
  `cod_solicitud` int NOT NULL,
  `docCedula` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docRut` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docCertificado` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docFormato` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docContrato` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_usu` char(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fech_carga` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `docBuzon6` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon7` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon8` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon9` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon10` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon11` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon12` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon13` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon14` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon15` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon16` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon17` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon18` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon19` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon20` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon21` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon22` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `docBuzon23` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idcontrolDocumentos`),
  UNIQUE KEY `cod_solicitud_UNIQUE` (`cod_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `convenio`;
CREATE TABLE `convenio` (
  `COD_CONVENIO` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COD_CONVENIO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `corresponsales`;
CREATE TABLE `corresponsales` (
  `idcorresponsales` int NOT NULL AUTO_INCREMENT,
  `corresponsales` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarifaPlena` decimal(7,1) DEFAULT NULL,
  `estado` int DEFAULT NULL,
  `ticket_promedio` int DEFAULT NULL,
  `cod_usu` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idcorresponsales`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ente_aprobacion`;
CREATE TABLE `ente_aprobacion` (
  `COD_APROBADOR` int NOT NULL,
  `USUARIO` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `USUARIO_UNIQUE` (`USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ente_parametrizacion`;
CREATE TABLE `ente_parametrizacion` (
  `COD_PARAMETRIZADOR` int NOT NULL AUTO_INCREMENT,
  `USUARIO` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`COD_PARAMETRIZADOR`),
  UNIQUE KEY `USUARIO_UNIQUE` (`USUARIO`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `entidadRedescuento`;
CREATE TABLE `entidadRedescuento` (
  `idEntidadRedescuento` int NOT NULL AUTO_INCREMENT,
  `cod_redescuento` int DEFAULT NULL,
  `descripcion` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codEstado` int DEFAULT NULL,
  `codUsu` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEntidadRedescuento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `estado_asignacion`;
CREATE TABLE `estado_asignacion` (
  `idAsignacion` int DEFAULT NULL,
  `codDecision` int DEFAULT NULL,
  `codUsuario` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaDecision` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `idAsignacion_UNIQUE` (`idAsignacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `estado_aso`;
CREATE TABLE `estado_aso` (
  `COD_ESTADO_ASO` int DEFAULT NULL,
  `ESTADO_ASO` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `estado_bco`;
CREATE TABLE `estado_bco` (
  `COD_ESTADO_BCO` int NOT NULL,
  `ESTADO_BCO` char(47) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COD_ESTADO_BCO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `estado_solicitud`;
CREATE TABLE `estado_solicitud` (
  `codSolicitud` int DEFAULT NULL,
  `estadoAprobacion` int DEFAULT NULL,
  `fechaAprobacion` datetime DEFAULT NULL,
  `estadoParametrizacion` int DEFAULT NULL,
  `fechaParametrizacion` datetime DEFAULT NULL,
  `estatusCorreo` int DEFAULT NULL,
  `fechaCorreo` datetime DEFAULT NULL,
  UNIQUE KEY `codSolicitud_UNIQUE` (`codSolicitud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `estadosDecision`;
CREATE TABLE `estadosDecision` (
  `COD_DECISION` int NOT NULL,
  `DECISION` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COD_DECISION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `financieros`;
CREATE TABLE `financieros` (
  `idFinanciero` int NOT NULL AUTO_INCREMENT,
  `servicio` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarifa` int DEFAULT NULL,
  `costo` int DEFAULT NULL,
  `obligatorio` int DEFAULT NULL,
  `cod_usu` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFinanciero`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `frecuenciaNomina`;
CREATE TABLE `frecuenciaNomina` (
  `idfrecuenciaNomina` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor` int DEFAULT NULL,
  `usuario` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `frecuenciaNominacol` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idfrecuenciaNomina`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `gastosDirectosOficina`;
CREATE TABLE `gastosDirectosOficina` (
  `idgastosDirectosOficina` int NOT NULL AUTO_INCREMENT,
  `tipoGastosDirectosOficina` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_user` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idgastosDirectosOficina`)
) ENGINE=InnoDB AUTO_INCREMENT=998 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `gastosDirectosPse`;
CREATE TABLE `gastosDirectosPse` (
  `idgastosDirectosPse` int NOT NULL AUTO_INCREMENT,
  `tipoGastosDirectosPse` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_user` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idgastosDirectosPse`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ibr`;
CREATE TABLE `ibr` (
  `cod_ibr` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ibr_descripcion` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cod_ibr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ibr_control`;
CREATE TABLE `ibr_control` (
  `cod_fech` int DEFAULT NULL,
  `cod_ibr` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `valor_ibr` decimal(5,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ibr_fechas`;
CREATE TABLE `ibr_fechas` (
  `cod_fech` int NOT NULL AUTO_INCREMENT,
  `fech_inic` date DEFAULT NULL,
  `fech_hast` date DEFAULT NULL,
  `cod_user` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cod_fech`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `justificacionOficina`;
CREATE TABLE `justificacionOficina` (
  `idjustificacionOficina` int NOT NULL AUTO_INCREMENT,
  `codGastosDirectosOfi` int DEFAULT NULL COMMENT 'codigo foraneo gastos directos',
  `tipoJustificacionOfi` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permitirNegociar` int DEFAULT NULL COMMENT 'codigo foraneo de permitir negociar',
  `tarifaPlena` decimal(10,1) DEFAULT NULL,
  `cod_usu` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idjustificacionOficina`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `justificacionPse`;
CREATE TABLE `justificacionPse` (
  `idjustificacionPse` int NOT NULL AUTO_INCREMENT,
  `codGastosDirectosPse` int DEFAULT NULL,
  `tipoJustificacionPse` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permitirNegociar` int DEFAULT NULL,
  `tarifaPlena` decimal(10,1) DEFAULT NULL,
  `cod_usu` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idjustificacionPse`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `Listas`;
CREATE TABLE `Listas` (
  `idListas` int NOT NULL AUTO_INCREMENT,
  `lista` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codLista` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idListas`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `log_motor`;
CREATE TABLE `log_motor` (
  `COD_LOGMOTOR` int NOT NULL,
  `ERROR` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FECHA` date NOT NULL,
  `HORA` time(6) NOT NULL,
  `COD_SOLICITUD` int NOT NULL,
  PRIMARY KEY (`COD_LOGMOTOR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `log_pricing`;
CREATE TABLE `log_pricing` (
  `COD_LOGPRICING` int NOT NULL AUTO_INCREMENT,
  `USUARIO` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ACCION` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EVENTO` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `REGISTRO_MODIFICADO` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CAMPO_MODIFICADO` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FECHA` timestamp NULL DEFAULT NULL,
  `DATA_ACTUAL` longtext COLLATE utf8mb4_unicode_ci,
  `DATA_NUEVA` longtext COLLATE utf8mb4_unicode_ci,
  `OBSERVACION` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COD_LOGPRICING`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `PRICINGDB_LOCAL`.`log_pricing` 
DROP COLUMN `FECHA`;

ALTER TABLE `PRICINGDB_LOCAL`.`log_pricing` 
ADD COLUMN `FECHA` TIMESTAMP DEFAULT CURRENT_TIMESTAMP  
ON UPDATE CURRENT_TIMESTAMP;

DROP TABLE IF EXISTS `negociarNomina`;
CREATE TABLE `negociarNomina` (
  `idnegociarNomina` int NOT NULL AUTO_INCREMENT,
  `pagoNomina` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarifaPlena` int DEFAULT NULL,
  `tarifaCosto` int DEFAULT NULL,
  `cantidad` decimal(3,2) DEFAULT NULL,
  `permitirNegociar` int DEFAULT NULL COMMENT 'Clave foranea de la lista desplegable Permitir Negociar.',
  `formulaCalculo` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idnegociarNomina`)
) ENGINE=InnoDB AUTO_INCREMENT=1111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `oficina`;
CREATE TABLE `oficina` (
  `COD_OFICINA` int NOT NULL,
  `OFICINA` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `REGIONAL` int NOT NULL,
  PRIMARY KEY (`COD_OFICINA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `operacion`;
CREATE TABLE `operacion` (
  `COD_OPERACION` int NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`COD_OPERACION`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `pagoTerseros`;
CREATE TABLE `pagoTerseros` (
  `idpagoTerseros` int NOT NULL AUTO_INCREMENT,
  `pagoTerseros` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarifaPlena` decimal(7,1) DEFAULT NULL,
  `tarifaCosto` decimal(7,1) DEFAULT NULL,
  `usuario` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idpagoTerseros`)
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ParametrosEfecty`;
CREATE TABLE `ParametrosEfecty` (
  `idParametrosEfecty` int NOT NULL AUTO_INCREMENT,
  `ParametrosEfecty` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod_usu` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idParametrosEfecty`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `perfiles`;
CREATE TABLE `perfiles` (
  `COD_PERFIL` int NOT NULL,
  `PERFIL` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DESCRIPCION` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COD_PERFIL`),
  KEY `idx_perfiles` (`COD_PERFIL`,`PERFIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `perfiles_usuario`;
CREATE TABLE `perfiles_usuario` (
  `COD_PERFIL` int NOT NULL,
  `USUARIO` char(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codUsu` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `FK_PERFILES_USUARIO_PERFILES` (`COD_PERFIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `permitirNegociar`;
CREATE TABLE `permitirNegociar` (
  `cod_permitir` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cod_permitir`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `planRemuneracion`;
CREATE TABLE `planRemuneracion` (
  `idplanRemuneracion` int NOT NULL AUTO_INCREMENT,
  `planRemuneracion` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rangoInferior` decimal(14,0) DEFAULT NULL,
  `rangoMaximo` decimal(14,0) DEFAULT NULL,
  `tasaEA` decimal(5,2) DEFAULT NULL,
  `cod_usu` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idplanRemuneracion`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `COD_PRODUCTO` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NOMBRE` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`COD_PRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `promedioNomina`;
CREATE TABLE `promedioNomina` (
  `idpromedioNomina` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idpromedioNomina`)
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `recaudoOficina`;
CREATE TABLE `recaudoOficina` (
  `idrecaudoOficina` int NOT NULL AUTO_INCREMENT,
  `tipoRecaudoOficina` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarifaPlena` decimal(7,1) DEFAULT NULL,
  `tarifaCosto` decimal(7,1) DEFAULT NULL,
  `cod_user` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idrecaudoOficina`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `recaudoPse`;
CREATE TABLE `recaudoPse` (
  `idrecaudoPse` int NOT NULL AUTO_INCREMENT,
  `tipoRecaudoPse` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarifaPlena` decimal(7,1) DEFAULT NULL,
  `tarifaCosto` decimal(7,1) DEFAULT NULL,
  `cod_user` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idrecaudoPse`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `reciprocidadMinima`;
CREATE TABLE `reciprocidadMinima` (
  `idReciprocidadMinima` int NOT NULL AUTO_INCREMENT,
  `monto` int DEFAULT NULL,
  `codUsu` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idReciprocidadMinima`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `regional`;
CREATE TABLE `regional` (
  `COD_REGIONAL_RAD` int NOT NULL,
  `REGIONAL_RAD` char(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`COD_REGIONAL_RAD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `remi`;
CREATE TABLE `remi` (
  `idremi` int NOT NULL AUTO_INCREMENT,
  `contenidoRemi` longtext COLLATE utf8mb4_unicode_ci,
  `id_user` char(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idremi`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sector`;
CREATE TABLE `sector` (
  `id` int NOT NULL AUTO_INCREMENT,
  `COD_SECTOR` int NOT NULL,
  `NOMBRE` char(21) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `COD_SECTOR_UNIQUE` (`COD_SECTOR`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_ip` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5840 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `solicitudes`;
CREATE TABLE `solicitudes` (
  `COD_SOLICITUD` int NOT NULL AUTO_INCREMENT,
  `NIT_CLIENTE` char(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `DATOS_SOLICITUD` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ID_RADICADOR` char(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `FECHA_HORA` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `APROREQUERIDAS` int NOT NULL,
  PRIMARY KEY (`COD_SOLICITUD`)
) ENGINE=InnoDB AUTO_INCREMENT=528 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tipo_aprobador`;
CREATE TABLE `tipo_aprobador` (
  `idtipo_aprobador` int NOT NULL AUTO_INCREMENT,
  `cod_aprobador` int NOT NULL,
  `tipo_aprobador` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idtipo_aprobador`),
  UNIQUE KEY `cod_aprobador_UNIQUE` (`cod_aprobador`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tipo_cliente`;
CREATE TABLE `tipo_cliente` (
  `COD_TIPO_CLIENTE` int NOT NULL,
  `TIPOCLI` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`COD_TIPO_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tipo_contrato`;
CREATE TABLE `tipo_contrato` (
  `COD_TIP_CONTRATO` int DEFAULT NULL,
  `TIPO_CONTRATO` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tipo_convenio`;
CREATE TABLE `tipo_convenio` (
  `COD_CONVENIO` int NOT NULL,
  `TIPO_CONVENIO` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`COD_CONVENIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tipo_decision`;
CREATE TABLE `tipo_decision` (
  `COD_DECISION` int NOT NULL,
  `DECISION` char(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `COD_DECISION_UNIQUE` (`COD_DECISION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tipo_producto`;
CREATE TABLE `tipo_producto` (
  `COD_TIP_PROD` int NOT NULL,
  `NOMBRE` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COD_TIP_PROD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tipoCredIbrState`;
CREATE TABLE `tipoCredIbrState` (
  `idtipoCredIbrState` int NOT NULL AUTO_INCREMENT,
  `COD_TIP_PROD` int NOT NULL,
  `cod_ibr` int NOT NULL,
  `codEstado` int NOT NULL,
  `codUsu` char(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idtipoCredIbrState`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `USUARIO` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NOMBRE` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CORREO` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `COD_OFICINA` int NOT NULL,
  `COD_CANAL` int DEFAULT NULL,
  `COD_REGIONAL` int DEFAULT NULL,
  `COD_CARGO` int DEFAULT NULL,
  `ESTADO_USU` int DEFAULT NULL,
  `OBSERVACION` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codUsu` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fech_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
