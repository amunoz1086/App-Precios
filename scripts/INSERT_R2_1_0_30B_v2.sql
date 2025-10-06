USE `PRICINGDB`;

TRUNCATE TABLE `adquirencia`;
INSERT INTO `adquirencia`
VALUES
(7,'Crédito Visa',25,0,'AERC5495','2024-05-22 21:33:46'),
(8,'Débito Visa',25,0,'AERC5495','2024-05-22 21:34:02'),
(9,'Débito Electron',25,0,'AERC5495','2024-05-22 21:33:46'),
(10,'Débito Mastercard',25,0,'AERC5495','2024-05-28 18:54:54'),
(11,'Crédito Mastercard',25,0,'AERC5495','2024-05-28 18:54:54'),
(12,'Débito Maestro',25,0,'AERC5495','2024-05-31 06:31:42');

-- TRUNCATE TABLE `asignaciones`;

TRUNCATE TABLE `asoc`;
INSERT INTO `asoc`
VALUES
(1,'Asociado'),
(2,'Exasociado'),
(3,'No asociado');

TRUNCATE TABLE `calificacion`;
INSERT INTO `calificacion` 
VALUES
(1,'B'),
(2,'CC'),
(3,'INC'),
(4,'A'),
(5,'AA'),
(6,'BB');

TRUNCATE TABLE `canal`;
INSERT INTO `canal`
VALUES
(1,'Red'),
(2,'Cooperativo'),
(3,'Pyme'),
(4,'Institucional'),
(5,'GrupoGec');

TRUNCATE TABLE `cargos`;
INSERT INTO `cargos`
VALUES
(1,'Gerente Regional'),
(2,'Gerente Nacional'),
(3,'Vic. Comercial'),
(4,'Vic. Financiera'),
(5,'Presidencia'),
(6,'Junta Directiva'),
(8,'Ejecutivo de cuenta'),
(9,'Operacion');

TRUNCATE TABLE `coberturaFng`;
INSERT INTO `coberturaFng`
VALUES 
(1,1,0,'0%'),
(2,2,10,'10%'),
(3,3,20,'20%'),
(4,4,30,'30%'),
(5,5,40,'40%'),
(6,6,50,'50%'),
(7,7,60,'60%'),
(8,8,70,'70%'),
(9,9,80,'80%'),
(10,10,90,'90%'),
(11,11,100,'100%');

-- TRUNCATE TABLE `controlBuzon`;

-- TRUNCATE TABLE `controlDocumentos`;

TRUNCATE TABLE `convenio`;
INSERT INTO `convenio` 
VALUES 
(1,'Convenio de Pago'),
(2,'Convenio de Recaudo'),
(3,'Servicios Financieros');

TRUNCATE TABLE `corresponsales`;
INSERT INTO `corresponsales` 
VALUES 
(7,'Efecty',3500.0,1,1,'AERC5495','2024-11-22 15:08:17'),
(8,'Supergiros',6000.0,2,1,'AERC5495','2024-11-16 03:32:57'),
(9,'Saque y Pague',4000.0,1,2,'AERC5495','2024-06-11 15:11:13');

TRUNCATE TABLE `ente_aprobacion`;
INSERT INTO `ente_aprobacion` 
VALUES 
(3,'AMZR5511'),
(6,'CLCSSC07'),
(11,'Cper5070'),
(22,'dncadf01'),
(21,'DPPR4195'),
(3,'elrs9334'),
(11,'face1520'),
(12,'HEOP0531'),
(22,'hjmm5719'),
(21,'JCGM8614'),
(6,'jlvf6136'),
(6,'jmgi5353'),
(22,'kdpc0841'),
(11,'LGGA6413'),
(12,'maaa3337'),
(13,'MDCADE01'),
(4,'NDVN3138'),
(13,'oetb3698'),
(13,'SMCA1533'),
(13,'vafxde02');

TRUNCATE TABLE `ente_parametrizacion`;
INSERT INTO `ente_parametrizacion`
VALUES
(181,'ANRR7231'),
(209,'BHCH8247'),
(211,'BOFPEX14'),
(213,'BQFXOF18'),
(215,'CLCXCR09'),
(175,'DMSJ3210'),
(159,'JGCB0880'),
(219,'JOAQ5483'),
(177,'LILO1960'),
(176,'LISB3727'),
(165,'MAHA0246'),
(196,'MCMR4329'),
(170,'MLRR3283'),
(171,'namg0030'),
(198,'YACG7029');

TRUNCATE TABLE `entidadRedescuento`;
INSERT INTO `entidadRedescuento`
VALUES 
(1,1,'Bancoldex',1,'AERC5495','2024-12-10 00:49:01'),
(2,2,'Findeter',1,'AERC5495','2024-12-10 06:59:38'),
(3,3,'Finagro',1,'AERC5495','2024-12-10 06:59:38'),
(4,99,'No Aplica',1,'AERC5495','2024-12-10 06:59:38');

-- TRUNCATE TABLE `estado_asignacion`;

TRUNCATE TABLE `estado_aso`;
INSERT INTO `estado_aso` 
VALUES 
(0,'Estado de Asociado'),
(9,'No Estado'),
(10,'Activo Normal'),
(11,'Activo Cobranza Interna'),
(12,'Activo, Pre-Vinculado'),
(13,'Activo Cobranza Prejuridico Externo'),
(14,'Inactivo'),
(15,'Activo No Cobranza Secuestrado'),
(17,'Receso'),
(18,'Juridico Sin Proceso'),
(20,'Suspendido Normal'),
(21,'Suspendido Cobranza Interna'),
(22,'Suspendido Cobranza Prejuridico Interno'),
(23,'Suspendido Fidelización por Crédito'),
(24,'Suspendido por Terminación Tiempo Inactivo'),
(25,'Suspendido Cobranza Castigado'),
(26,'Suspendido por Fallecimiento'),
(27,'Suspendido - Receso'),
(30,'Retirado Normal'),
(31,'Retirado Cobranza Interna'),
(32,'Retirado Cobranza Prejuridico Interno'),
(33,'Retirado Cobranza Prejuridico Externo'),
(34,'Retirado Cobranza Juridico'),
(35,'Retirado Cobranza Castigado'),
(36,'Retirado Cobranza Castigado Normalizado'),
(37,'Retirado - Receso'),
(40,'Excluido Normal'),
(41,'Excluido Cobranza Interna'),
(42,'Excluido Cobranza Prejuridico Interno'),
(43,'Excluido Cobranza Prejuridico Externo'),
(44,'Excluido Cobranza Juridico'),
(45,'Excluido Cobranza Castigado'),
(46,'Excluido Cobranza Castigado Normalizado'),
(47,'Excluido Normalizado'),
(48,'Expulsión de la Cooperativa'),
(50,'Fallecido Normal'),
(51,'Fallecido Cobranza Cobranza Interna'),
(52,'Fallecido Cobranza Prejuridico Interno'),
(53,'Fallecido Cobranza Prejuridico Externo'),
(54,'Fallecido Cobranza Juridico'),
(55,'Fallecido Cobranza Castigado'),
(56,'Fallecido Cobranza Normalizado'),
(99,'Retiro Administrativo BUC');

TRUNCATE TABLE `estado_bco`;
INSERT INTO `estado_bco`
VALUES 
(0,'Estados de Clientes - Nueva Version'),
(9,'No Estado'),(10,'Activo Normal'),
(11,'Activo Cobranza Interna'),
(12,'Activo Cobranza Prejurídico Interna'),
(13,'Activo Prejuridico Activo Externa'),
(14,'Activo Cobranza Juridico'),
(15,'Activo No Cobranza - Secuestrado, Desaparecido'),
(16,'Activo Normalizado'),
(17,'Predemanda'),
(18,'Juridico sin Proceso'),
(19,'Concursal Vigente'),
(20,'Castigado'),
(21,'Castigado Normalizado'),
(22,'Concursal Castigada'),
(25,'Castigado sin Proceso'),
(26,'SEG BANC'),
(30,'Cesión de Cartera'),
(40,'Fallecido'),
(41,'Fallecido Cobranza Interna'),
(42,'Fallecido Cobranza Prejuridico Interna');

-- TRUNCATE TABLE `estado_solicitud`;

-- TRUNCATE TABLE `estadosDecision`;

TRUNCATE TABLE `financieros`;
INSERT INTO `financieros` 
VALUES 
(1,'Oficina Virtual PJ',86000,43000,1,'AERC5495','2025-02-04 16:19:09'),
(2,'Chequera 30',196947,29900,1,'AERC5495','2025-02-13 04:04:51'),
(3,'Chequera 100',650332,55794,1,'AERC5495','2025-02-04 16:19:09'),
(4,'Cheques de Gerencia',25946,717,1,'AERC5495','2025-02-13 04:05:27'),
(5,'Chequera Formas Continuas',10690,1116,1,'AERC5495','2025-02-13 04:04:51'),
(6,'Tarjeta de Crédito',32340,10144,1,'AERC5495','2025-02-13 04:04:51'),
(7,'Giros',12549,3908,1,'AERC5495','2025-02-04 16:19:09');

TRUNCATE TABLE `frecuenciaNomina`;
INSERT INTO `frecuenciaNomina` 
VALUES 
(117,'Semanal',4,'AERC5495','2024-04-29 00:56:44',NULL),
(118,'Quincenal',2,'AERC5495','2024-04-29 00:56:44',NULL),
(119,'Mensual',1,'AERC5495','2024-04-29 00:56:44',NULL);

TRUNCATE TABLE `gastosDirectosOficina`;
INSERT INTO `gastosDirectosOficina` 
VALUES 
(253,'Pago Web Service Oficina','loja','2024-04-29 00:54:54');

TRUNCATE TABLE `gastosDirectosPse`;
INSERT INTO `gastosDirectosPse` 
VALUES 
(30,'Paquete Trx Anual Pasarela','AERC5495','2024-03-21 21:02:10'),
(31,'Pago Web Service Hosting PSE','AERC5495','2024-03-21 21:37:42');

TRUNCATE TABLE `ibr`;
INSERT INTO `ibr` 
VALUES 
('0','IBR Overnight'),
('1','IBR a un mes'),
('12','IBR a doce meses'),
('3','IBR a tres meses'),
('6','IBR a seis meses');

TRUNCATE TABLE `ibr_control`;
INSERT INTO `ibr_control` 
VALUES 
(2,'0',3.000), (2,'1',2.000), (2,'3',4.000), (2,'6',5.000), (2,'12',3.000), (3,'0',4.000), (3,'1',4.000), (3,'3',4.000), (3,'6',4.000), (3,'12',4.000),
(4,'0',5.000), (4,'1',6.000), (4,'3',7.000), (4,'6',6.000), (4,'12',9.000), (5,'0',0.010), (5,'1',0.010), (5,'3',4.000), (5,'6',0.020), (5,'12',0.020),
(6,'0',0.010), (6,'1',0.010), (6,'3',4.000), (6,'6',0.020), (6,'12',0.020), (7,'0',0.070), (7,'1',0.010), (7,'3',6.000), (7,'6',0.020), (7,'12',0.030),
(8,'0',0.020), (8,'1',0.020), (8,'3',4.000), (8,'6',0.030), (8,'12',0.040), (12,'0',0.140), (12,'1',0.180), (12,'3',7.000), (12,'6',0.120), (12,'12',0.360),
(13,'0',2.000), (13,'1',2.000), (13,'3',5.000), (13,'6',2.000), (13,'12',2.000), (14,'0',0.010), (14,'1',0.010), (14,'3',0.010), (14,'6',0.010), (14,'12',0.010),
(15,'0',0.020), (15,'1',0.020), (15,'3',0.020), (15,'6',0.020), (15,'12',0.020), (16,'0',0.030), (16,'1',0.030), (16,'3',0.030), (16,'6',0.030), (16,'12',0.030),
(17,'0',2.000), (17,'1',3.000), (17,'3',7.000), (17,'6',3.000), (17,'12',4.000), (18,'0',4.000), (18,'1',5.000), (18,'3',7.000), (18,'6',8.000), (18,'12',9.000),
(19,'0',3.000), (19,'1',3.000), (19,'3',4.000), (19,'6',3.000), (19,'12',3.000), (20,'0',11.000), (20,'1',11.010), (20,'3',10.650), (20,'6',11.000), (20,'12',11.000),
(21,'0',11.000), (21,'1',11.010), (21,'3',10.650), (21,'6',11.000), (21,'12',11.000), (22,'0',9.170), (22,'1',9.210), (22,'3',8.940), (22,'6',8.610), (22,'12',8.210),
(23,'0',9.170),(23,'1',9.210),(23,'3',8.910),(23,'6',8.610),(23,'12',8.210),(24,'0',8.990),(24,'1',8.870),(24,'3',8.820),(24,'6',8.700),(24,'12',8.440),(25,'0',8.990),
(25,'1',8.870),(25,'3',8.820),(25,'6',8.700),(25,'12',8.440),(26,'0',8.990),(26,'1',8.870),(26,'3',8.820),(26,'6',8.700),(26,'12',8.440),(27,'0',9.000),(27,'1',8.850),
(27,'3',8.800),(27,'6',8.670),(27,'12',8.460),(28,'0',9.000),(28,'1',8.970),(28,'3',8.950),(28,'6',8.820),(28,'12',8.580),(29,'0',8.980),(29,'1',8.990),(29,'3',8.950),
(29,'6',8.800),(29,'12',8.550),(30,'0',8.000),(30,'1',8.000),(30,'3',8.000),(30,'6',8.000),(30,'12',8.000),(31,'0',8.000),(31,'1',8.000),(31,'3',8.000),(31,'6',8.000),
(31,'12',8.000),(42,'0',8.980),(42,'1',8.990),(42,'3',8.950),(42,'6',8.800),(42,'12',8.550),(32,'0',8.000),(32,'1',8.000),(32,'3',8.000),(32,'6',8.000),(32,'12',8.000),
(33,'0',8.000),(33,'1',8.000),(33,'3',8.000),(33,'6',8.000),(33,'12',8.000),(34,'0',8.000),(34,'1',8.000),(34,'3',8.000),(34,'6',8.000),(34,'12',8.000),(35,'0',8.000),
(35,'1',8.000),(35,'3',8.000),(35,'6',8.000),(35,'12',8.000),(36,'0',8.000),(36,'1',8.000),(36,'3',8.000),(36,'6',8.000),(36,'12',8.000),(37,'0',8.000),(37,'1',8.000),
(37,'3',8.000),(37,'6',8.000),(37,'12',8.000),(38,'0',8.000),(38,'1',8.000),(38,'3',8.000),(38,'6',8.000),(38,'12',8.000),(39,'0',8.000),(39,'1',8.000),(39,'3',8.000),
(39,'6',8.000),(39,'12',8.000),(40,'0',8.000),(40,'1',8.000),(40,'3',8.000),(40,'6',8.000),(40,'12',8.000),(40,'0',8.000),(40,'1',8.000),(40,'3',8.000),(40,'6',8.000),
(40,'12',8.000),(41,'0',8.000),(41,'1',8.000),(41,'3',8.000),(41,'6',8.000),(41,'12',8.000),(44,'0',12.980),(44,'1',12.899),(44,'3',12.000),(44,'6',12.500),
(44,'12',12.700),(45,'0',12.980),(45,'1',12.899),(45,'3',12.000),(45,'6',12.500),(45,'12',12.700),(46,'0',12.980),(46,'1',12.899),(46,'3',12.000),(46,'6',12.500),
(46,'12',12.700),(47,'0',12.980),(47,'1',12.899),(47,'3',12.000),(47,'6',12.500),(47,'12',12.700),(48,'0',12.980),(48,'1',12.899),(48,'3',12.000),(48,'6',12.500),
(48,'12',12.700),(49,'0',12.980),(49,'1',12.899),(49,'3',12.000),(49,'6',12.500),(49,'12',12.700),(50,'0',12.980),(50,'1',12.899),(50,'3',12.000),(50,'6',12.500),
(50,'12',12.700),(51,'0',12.980),(51,'1',12.899),(51,'3',12.000),(51,'6',12.500),(51,'12',12.700),(52,'0',12.980),(52,'1',12.899),(52,'3',12.000),(52,'6',12.500),
(52,'12',12.700),(53,'0',12.980),(53,'1',12.899),(53,'3',12.000),(53,'6',12.500),(53,'12',12.700),(54,'0',8.960),(54,'1',8.910),(54,'3',8.870),(54,'6',8.800),
(54,'12',8.690),(55,'0',9.950),(55,'1',8.920),(55,'3',8.870),(55,'6',8.790),(55,'12',8.690),(56,'0',8.729),(56,'1',8.695),(56,'3',8.680),(56,'6',8.665),
(56,'12',8.672),(57,'0',8.730),(57,'1',8.700),(57,'3',8.675),(57,'6',8.672),(57,'12',8.659),(58,'0',8.740),(58,'1',8.800),(58,'3',8.765),(58,'6',8.772),
(58,'12',8.659);

TRUNCATE TABLE `ibr_fechas`;
INSERT INTO `ibr_fechas` 
VALUES 
(2,'2023-09-07','2023-09-10','AERC5495'),(3,'2023-09-11','2023-09-30','AERC5495'),(4,'2023-10-01','2023-10-31','AERC5495'),(5,'2023-11-01','2023-11-30','AERC5495'),
(6,'2023-11-01','2023-11-30','AERC5495'),(7,'2023-12-01','2023-12-31','AERC5495'),(8,'2025-01-18','2025-01-18','AERC5495'),(12,'2025-01-19','2025-01-19','AERC5495'),
(13,'2025-01-20','2025-01-20','AERC5495'),(14,'2025-01-21','2025-01-21','AERC5495'),(15,'2025-01-22','2025-01-22','AERC5495'),(16,'2025-01-23','2025-01-23','AERC5495'),
(17,'2025-01-24','2025-01-24','AERC5495'),(18,'2025-01-25','2025-01-25','daog8465'),(19,'2025-01-26','2025-01-26','AERC5495'),(20,'2025-01-27','2025-01-27','AERC5495'),
(21,'2025-01-28','2025-01-28','AERC5495'),(22,'2025-01-29','2025-01-29','AERC5495'),(23,'2025-01-30','2025-01-30','AERC5495'),(24,'2025-01-31','2025-01-31','AERC5495'),
(25,'2025-02-01','2025-02-01','AERC5495'),(26,'2025-02-02','2025-02-02','AERC5495'),(27,'2025-02-03','2025-02-03','AERC5495'),(28,'2025-02-04','2025-02-04','AERC5495'),
(29,'2025-02-05','2025-02-05','AERC5495'),(30,'2025-02-06','2025-02-06','AERC5495'),(31,'2025-02-07','2025-02-07','AERC5495'),(32,'2025-02-08','2025-02-08','AERC5495'),
(33,'2025-02-09','2025-02-09','AERC5495'),(34,'2025-02-10','2025-02-10','AERC5495'),(35,'2025-02-11','2025-02-11','AERC5495'),(36,'2025-02-12','2025-02-12','AERC5495'),
(37,'2025-02-13','2025-02-13','AERC5495'),(38,'2025-02-14','2025-02-14','AERC5495'),(39,'2025-02-15','2025-02-15','AERC5495'),(40,'2025-02-16','2025-02-16','AERC5495'),
(41,'2025-02-17','2025-02-17','AERC5495'),(42,'2025-02-18','2025-02-18','AERC5495'),(44,'2025-02-19','2025-02-19','AERC5495'),(45,'2025-02-20','2025-02-20','AERC5495'),
(46,'2025-02-21','2025-02-21','AERC5495'),(47,'2025-02-22','2025-02-22','AERC5495'),(48,'2025-02-23','2025-02-23','AERC5495'),(49,'2025-02-24','2025-02-24','AERC5495'),
(50,'2025-02-25','2025-02-25','AERC5495'),(51,'2025-02-26','2025-02-26','AERC5495'),(52,'2025-02-27','2025-02-27','AERC5495'),(53,'2025-02-28','2025-02-28','AERC5495'),
(54,'2025-03-01','2025-03-26','AERC5495'),(55,'2025-06-10','2025-06-10','AERC5495'),(56,'2025-06-11','2025-07-17','AERC5495'),(57,'2025-07-18','2025-07-19','AERC5495'),
(58,'2025-07-20','2025-07-22','AERC5495');

TRUNCATE TABLE `justificacionOficina`;
INSERT INTO `justificacionOficina` 
VALUES 
(77,253,'GTO Implementacion ',1,0.0,'AERC5495','2024-09-06 19:23:12');

TRUNCATE TABLE `justificacionPse`;
INSERT INTO `justificacionPse` 
VALUES 
(17,31,'GTO Implementacion',1,0.0,'AERC5495','2024-06-12 15:08:03'),
(23,30,'Paquete Pasarela Banco',1,0.0,'AERC5495','2024-06-12 15:08:03');

TRUNCATE TABLE `Listas`;
INSERT INTO `Listas` 
VALUES 
(1,'Estado','1','Activo'),
(2,'Estado','2','Inactivo'),
(3,'Aplica','1','Aplica'),
(4,'Aplica','2','No Aplica'),
(5,'SiNo','1','Si'),
(6,'SiNo','0','No'),
(7,'TipoId','1','CC'),
(8,'TipoId','2','CE'),
(9,'TipoId','4','TI'),
(10,'TipoId','5','PA'),
(11,'TipoId','6','RC'),
(12,'TipoCuenta','1','Ahorro'),
(13,'TipoCuenta','2','Corriente'),
(14,'PlanRem','1','PN'),
(15,'PlanRem','2','COOP1'),
(16,'PlanRem','3','COOP2'),
(17,'PlanRem','4','PYME1'),
(18,'PlanRem','5','PYME2'),
(19,'PlanRem','6','Nesgocios Especiales'),
(20,'TipoId','3','NIT'),
(21,'Naturaleza','1','Publico'),
(22,'Naturaleza','2','Privado'),
(23,'Accion','1','Activación'),
(24,'Accion','2','Inactivación'),
(25,'Accion','0','Eliminación'),
(26,'Accion','3','Actualización'),
(27,'Accion','4','Todas');

-- TRUNCATE TABLE `log_motor`;

-- TRUNCATE TABLE `log_pricing`;

TRUNCATE TABLE `negociarNomina`;
INSERT INTO `negociarNomina` 
VALUES 
(1096,'Retiro Exentos - Cajero Red Propia',0,1000,0.00,1,'','AERC5495','2025-02-04 16:00:39'),
(1097,'Retiro Exentos - Cajero Red Verde',7385,3297,3.00,2,'','ktof5963','2025-07-16 15:05:18'),
(1098,'Retiro Exentos - Cajero Saque y Pague',0,1000,0.00,1,'','AERC5495','2024-12-15 04:08:25'),
(1099,'Retiro Exentos - Efecty(Corresponsales)',2418,1365,1.00,2,'','ktof5963','2025-07-16 15:05:18'),
(1100,'Retiro en Oficina',0,563,9.99,1,'','AERC5495','2024-11-16 03:43:45'),
(1101,'Transferencias Interbancarias ACH',11117,237,2.00,2,'','ktof5963','2025-07-16 15:05:18'),
(1102,'No Tx Pago nómina Cta Bancoomeva',3730,145,0.00,5,'','AERC5495','2025-02-04 16:00:39'),
(1103,'Cuota de manejo Chip',14989,5456,0.00,5,'','AERC5495','2025-02-04 16:00:39');

TRUNCATE TABLE `oficina`;
INSERT INTO `oficina` 
VALUES 
(1,'Tesoreria Direccion General',9),(102,'Oficina Sur - Cali',1),(105,'Oficina Sede Nacional - Cali',1),(106,'Oficina Imbanaco - Cali',1),
(107,'Oficina Unicentro - Cali',1),(108,'Oficina Chipichape',1),(109,'Oficina Cosmocentro - Cali',1),(118,'Oficina Laboratorio Core',1),
(160,'Banca Empresarial Institucionales Cali',1),(161,'Banca Empresarial Gerente 1 Cali',1),(162,'Banca Empresarial Gerente 2 Cali',1),
(163,'Banca Empresarial Gerente 3 Cali',1),(164,'Banca Pyme Ejecutivo 3 Cali',1),(165,'Originadores Empresariales Cali',1),
(166,'Ejecutivo Pyme 166 Cali',1),(167,'Banca Pyme Ejecutivo 4 Cali',1),(168,'Banca Pyme Ejecutivo 5 Cali',1),(180,'Banca Empresarial Empresas del Grupo',9),
(181,'Banca Empresarial Empresas Grupo Palmira',9),(182,'Originadores Libranza Cali',1),(183,'Originadores Libranza Bogotá',5),
(184,'Originadores Libranza Caribe',6),(185,'Originadores Libranza Eje Cafetero',1),(186,'Originadores Libranza Medellín',6),
(187,'Originadores Libranza Palmira',1),(190,'Gerente Empresarial Sector Cooperativo B',5),(191,'Gerente Empresarial Sector Cooperativo C',1),
(193,'Gerente Empresarial Sector Cooperativo M',6),(194,'Gerente Empresarial Sector Cooperativo B',5),(196,'Ejecutivo Sector Cooperativo - Bucaraman',6),
(301,'Medellín Centro',6),(302,'Oficina Oviedo - Medellin',6),(304,'Oficina Las Americas - Medellin',6),(305,'Oficina La 33 - Medellin',6),
(360,'Banca Empresarial Institucionales Medellin',6),(361,'Banca Empresarial Gerente 1 Medellin',6),(362,'Banca Empresarial Gerente 2 Medellin',6),
(363,'Banca Pyme Ejecutivo 2 Medellín',6),(365,'Ejecutivo Pyme 365 Medellin',6),(366,'Ejecutivo Pyme Bucaramanga',6),(367,'Ejecutivo Pyme Monteria',6),
(401,'Oficina Principal - Palmira',1),(402,'Oficina Versalles - Palmira',1),(461,'Banca Empresarial Gerente 1 Palmira',1),(501,'Oficina Santa Barbara',5),
(502,'Oficina Galerias - Bogota',5),(503,'Oficina Av Chile - Bogota',5),(504,'Oficina Niza - Bogota',5),(505,'Oficina Centro Internacional - Bogota',5),
(507,'Oficina Unicentro - Bogota',5),(508,'Oficina Ciudad Salitre - Bogota',5),(512,'Oficina Principal - Bogota',5),(514,'Oficina Plaza de las Americas - Bogota',5),
(515,'Oficina Cedritos - Bogota',5),(560,'Banca Empresarial Institucionales Bogota',5),(561,'Banca Empresarial Gerente 1 Bogota',5),
(563,'Banca Empresarial Gerente 3 Bogota',5),(565,'Banca Empresarial Gerente 5 Bogota',5),(566,'Banca Pyme Ejecutivo 3 Bogotá',5),
(567,'Banca Pyme Ejecutivo 4 Bogotá',5),(568,'Originadores Empresariales Bogotá',5),(569,'Ejecutivo Pyme 569 Bogota',5),(570,'Ejecutivo Pyme 570 Bogota',5),
(601,'Armenia Principal',1),(701,'Apartado',6),(801,'Oficina Barranquilla Prado',6),(802,'Oficina Barranquilla Norte',6),(806,'Calle 93',6),
(860,'Banca Empresarial Institucionales Caribe',6),(861,'Banca Empresarial Gerente 1 Caribe',6),(862,'Banca Empresarial Gerente 2 Caribe',6),
(863,'Banca Pyme Ejecutivo 3 Caribe',6),(864,'Banca Pyme Ejecutivo 3 Caribe',6),(865,'Originadores Empresariales Caribe',6),
(866,'Banca Pyme Ejecutivo 5 Caribe',6),(901,'Popayan',1),(1001,'Buga',1),(1101,'Buenaventura',1),(1201,'Tulua',1),(1301,'Ibague',1),(1401,'Pereira Centro',1),
(1402,'Pereira Prometeo',1),(1460,'Banca Empresarial Institucionales Eje',1),(1461,'Banca Empresarial Gerente 1 Eje',1),(1462,'Ejecutivo Banca Empresarial Pereira',1),
(1463,'Ejecutivo Banca Empresarial Manizales',1),(1464,'Ejecutivo Banca Empresarial Armenia',1),(1501,'Cartago',1),(1601,'Manizales Principal',1),
(1701,'Neiva',1),(1801,'Florencia',1),(1901,'Pasto',1),(2001,'Quibdo',6),(2101,'Bucaramanga',6),(2301,'Cucuta',6),(2401,'Valledupar',6),
(2501,'Cartagena Manga',6),(2601,'Monteria',6),(2701,'Santa Marta',6),(2801,'Sogamoso',5),(2901,'Villavicencio',5),(3001,'Tunja',5),(3101,'Sincelejo',6),
(3201,'Yopal',5),(3301,'Pamplona',6),(3401,'Chia',5),(3501,'Rionegro',6),(3601,'Envigado',6),(3701,'Barrancabermeja..N',6),(4301,'Mayorca',6),(4401,'Duitama',5),
(4601,'Riohacha',6);

TRUNCATE TABLE `operacion`;
INSERT INTO `operacion` 
VALUES 
(1,'Nuevo'),
(2,'Ajuste');

TRUNCATE TABLE `pagoTerseros`;
INSERT INTO `pagoTerseros` 
VALUES 
(472,'Pagos Bancoomeva',3730.0,145.0,'AERC5495','2025-02-04 16:04:56'),
(473,'Pagos ACH ',10525.0,237.0,'AERC5495','2024-11-16 03:43:45'),
(474,'Pagos Sebra',71830.0,47279.0,'AERC5495','2025-03-27 16:37:22');

TRUNCATE TABLE `ParametrosEfecty`;
INSERT INTO `ParametrosEfecty` 
VALUES 
(1,'$1-$250.000','AERC5495','2024-12-18 19:31:29'),
(10,'$250.001-$350.000','AERC5495','2024-12-18 19:31:29'),
(11,'$350.001-$550.000','AERC5495','2024-12-18 19:31:29'),
(12,'$550.001-$1000.000','AERC5495','2024-12-18 19:31:29');

TRUNCATE TABLE `perfiles`;
INSERT INTO `perfiles` 
VALUES 
(1,'Administración','Administrador General'),
(2,'Radicación','Radicación'),
(3,'Aprobación','Aprobación'),
(4,'Parametrización','Parametrización'),
(5,'Consulta','Consulta'),
(6,'ADFNC','Administrador Financiero');

TRUNCATE TABLE `perfiles_usuario`;
INSERT INTO `perfiles_usuario` 
VALUES 
(2,'JGCB0880',NULL,'2025-02-28 18:49:06'),(4,'JGCB0880',NULL,'2025-02-28 18:49:06'),(3,'SMCA1533',NULL,'2025-02-28 18:49:06'),
(2,'MAHA0246',NULL,'2025-02-28 18:49:06'),(4,'MAHA0246',NULL,'2025-02-28 18:49:06'),(2,'MLRR3283',NULL,'2025-02-28 18:49:06'),
(4,'MLRR3283',NULL,'2025-02-28 18:49:06'),(2,'namg0030',NULL,'2025-02-28 18:49:06'),(4,'namg0030',NULL,'2025-02-28 18:49:06'),
(2,'DMSJ3210',NULL,'2025-02-28 18:49:06'),(4,'DMSJ3210',NULL,'2025-02-28 18:49:06'),(2,'LISB3727',NULL,'2025-02-28 18:49:06'),
(4,'LISB3727',NULL,'2025-02-28 18:49:06'),(2,'LILO1960',NULL,'2025-02-28 18:49:06'),(4,'LILO1960',NULL,'2025-02-28 18:49:06'),
(2,'ANRR7231',NULL,'2025-02-28 18:49:06'),(4,'ANRR7231',NULL,'2025-02-28 18:49:06'),(3,'NDVN3138',NULL,'2025-02-28 18:49:06'),
(3,'dncadf01',NULL,'2025-03-27 13:22:40'),(3,'kdpc0841',NULL,'2025-03-27 13:23:02'),(3,'maaa3337',NULL,'2025-03-27 13:23:50'),
(3,'vafxde02',NULL,'2025-03-27 13:24:54'),(3,'oetb3698',NULL,'2025-03-27 13:25:22'),(3,'jmgi5353',NULL,'2025-03-27 13:26:58'),
(3,'MDCADE01',NULL,'2025-05-23 16:34:42'),(4,'MCMR4329',NULL,'2025-06-05 21:59:27'),(4,'YACG7029',NULL,'2025-06-05 22:00:07'),
(1,'VAOZ3347','AERC5495','2025-06-13 14:02:40'),(2,'SALT6911','AERC5495','2025-06-13 18:25:31'),(2,'cmlv4280','AERC5495','2025-06-20 23:23:17'),
(4,'BHCH8247','AERC5495','2025-06-20 23:24:52'),(4,'BOFPEX14','AERC5495','2025-06-20 23:25:14'),(4,'BQFXOF18','AERC5495','2025-06-20 23:25:37'),
(2,'CAEV5896','AERC5495','2025-06-20 23:25:54'),(4,'CLCXCR09','AERC5495','2025-06-20 23:26:46'),(2,'DPPR4195','AERC5495','2025-06-20 23:45:18'),
(2,'eatv8722','AERC5495','2025-06-20 23:46:19'),(2,'HEOP0531','AERC5495','2025-06-20 23:47:25'),(3,'hjmm5719','AERC5495','2025-06-20 23:50:13'),
(3,'JCGM8614','AERC5495','2025-06-20 23:50:28'),(4,'JOAQ5483','AERC5495','2025-06-20 23:50:59'),(3,'LGGA6413','AERC5495','2025-06-20 23:51:27'),
(3,'elrs9334','AERC5495','2025-06-21 16:06:10'),(5,'clcxcr51','AERC5495','2025-06-25 22:24:01'),(1,'AERC5495','AERC5495','2025-07-01 16:10:55'),
(3,'Cper5070','AERC5495','2025-07-03 14:09:22'),(3,'face1520','AERC5495','2025-07-03 16:14:57'),(1,'WECA1331','AERC5495','2025-07-04 16:12:38'),
(2,'kscm4868','AERC5495','2025-07-11 20:18:33'),(2,'lmza4356','jjap5013','2025-07-11 20:44:22'),(2,'yrmg3557','WECA1331','2025-07-12 05:16:13'),
(6,'ktof5963','AERC5495','2025-07-16 13:56:22'),(2,'natq5916','AERC5495','2025-07-16 19:03:16'),(3,'CLCSSC07','AERC5495','2025-07-16 19:05:59'),
(3,'jlvf6136','AERC5495','2025-07-16 20:28:51'),(2,'ajog8849','AERC5495','2025-07-25 17:08:24'),(3,'AMZR5511','AERC5495','2025-08-06 02:39:29'),
(2,'DYMH1095','AERC5495','2025-08-06 16:16:12');

TRUNCATE TABLE `permitirNegociar`;
INSERT INTO `permitirNegociar` 
VALUES 
(1,'Ilimitado'),
(2,'No'),
(3,'Si'),
(4,'Inactivo'),
(5,'Calculo');

TRUNCATE TABLE `planRemuneracion`;
INSERT INTO `planRemuneracion`
VALUES 
(92,'PN',1,50000000,0.00,'AERC5495','2024-04-29 18:29:43'),(93,'PN',50000001,100000000,1.00,'AERC5495','2024-04-29 18:33:18'),
(94,'PN',100000001,150000000,1.00,'AERC5495','2024-04-29 18:33:18'),(95,'PN',150000001,10000000000,2.00,'AERC5495','2024-04-29 18:33:19'),
(96,'PN',10000000001,20000000000,1.00,'AERC5495','2024-04-29 18:33:19'),(97,'COOP1',1,50000000,1.00,'AERC5495','2024-04-29 18:38:08'),
(98,'COOP1',50000001,100000000,5.00,'AERC5495','2024-04-29 18:38:08'),(99,'COOP1',100000001,500000000,7.00,'AERC5495','2024-04-29 18:38:08'),
(100,'COOP1',500000001,1000000000,8.00,'AERC5495','2024-04-29 18:38:08'),(101,'COOP1',1000000001,17000000000,9.00,'AERC5495','2024-04-29 18:38:08'),
(102,'COOP1',17000000001,20000000000,2.00,'AERC5495','2024-04-29 18:38:09'),(103,'COOP2',1,50000000,1.00,'AERC5495','2024-04-29 18:41:19'),
(104,'COOP2',50000001,500000000,4.00,'AERC5495','2024-04-29 18:41:19'),(105,'COOP2',500000001,5000000000,11.00,'AERC5495','2024-04-29 18:41:19'),
(106,'COOP2',5000000001,17000000000,12.00,'AERC5495','2024-04-29 18:41:19'),(107,'COOP2',17000000001,20000000000,2.00,'AERC5495','2024-04-29 18:41:19'),
(108,'PYME1',1,50000000,3.00,'AERC5495','2024-05-20 07:37:23');

TRUNCATE TABLE `producto`;
INSERT INTO `producto` 
VALUES 
('01','Crédito'),
('02','Captación'),
('03','Convenio');

TRUNCATE TABLE `promedioNomina`;
INSERT INTO `promedioNomina` 
VALUES 
(205,'Hasta un SMMLV','AERC5495','2024-12-03 17:04:30'),
(209,'SMMLV-$1,6 MM','AERC5495','2024-12-03 08:29:12'),
(210,'Mayor a $1.6 MM','AERC5495','2024-12-03 17:04:30');

TRUNCATE TABLE `recaudoOficina`;
INSERT INTO `recaudoOficina` 
VALUES 
(1,'Código de Barras',9993.0,1368.0,'AERC5495','2025-02-04 15:49:00'),
(2,'Manual - Referencia',10690.0,1954.0,'AERC5495','2025-02-04 15:49:00');

TRUNCATE TABLE `recaudoPse`;
INSERT INTO `recaudoPse` 
VALUES 
(1,'Portal de Pagos',3301.0,364.0,'AERC5495','2025-02-04 15:49:01'),
(2,'PSE Recaudos',3301.0,468.0,'AERC5495','2025-02-04 15:49:01');

TRUNCATE TABLE `reciprocidadMinima`;
INSERT INTO `reciprocidadMinima` 
VALUES 
(1,10000000,'AERC5495','2024-12-11 14:47:07');

TRUNCATE TABLE `regional`;
INSERT INTO `regional` 
VALUES 
(1,'Sur'),
(5,'Centro'),
(6,'Norte'),
(9,'Dirección Nacional');

-- TRUNCATE TABLE `remi`;

TRUNCATE TABLE `sector`;
INSERT INTO `sector`
VALUES 
(12,34,'Solidario'),
(13,9,'Construcción'),
(14,24,'Educación'),
(15,17,'Servicios Financieros'),
(16,29,'Salud'),
(17,7,'Oficial'),
(18,26,'Industrial'),
(19,4,'Otra'),
(20,31,'Comercio'),
(21,16,'Transporte'),
(22,99,'Persona Natural');

-- TRUNCATE TABLE `sessions`;

-- TRUNCATE TABLE `solicitudes`;

TRUNCATE TABLE `tipo_aprobador`;
INSERT INTO `tipo_aprobador` 
VALUES 
(1,3,'Vic. Comercial'),(2,4,'Vic. Financiera'),(3,21,'Gerente Nacional PN'),
(4,22,'Gerente Nacional PJ'),(5,11,'Gerente Regional Sur'),(6,12,'Gerente Regional Centro'),
(7,13,'Gerente Regional Norte'),(11,5,'Presidencia'),(12,6,'Junta Directiva');

TRUNCATE TABLE `tipo_cliente`;
INSERT INTO `tipo_cliente` 
VALUES (1,'PN'),
(2,'Pj');

TRUNCATE TABLE `tipo_contrato`;
INSERT INTO `tipo_contrato` 
VALUES 
(1,'Independiente'),
(2,'Pensionado'),
(3,'Contrato fijo'),
(4,'Contrato indefinido'),
(5,'N/A');

TRUNCATE TABLE `tipo_convenio`;
INSERT INTO `tipo_convenio` 
VALUES 
(0,'Sin Convenio'),
(1,'Cliente Integral'),
(2,'Nomina y Proveedores'),
(3,'Nomina y Recaudo'),
(5,'Solo Nomina'),
(6,'Solo Proveedores'),
(7,'Solo Recaudo');

TRUNCATE TABLE `tipo_decision`;
INSERT INTO `tipo_decision` 
VALUES 
(0,'No Aprobado'),
(1,'Aprobado');

TRUNCATE TABLE `tipo_producto`;
INSERT INTO `tipo_producto` 
VALUES 
(43,'Tesorería'),
(44,'Cupo');

TRUNCATE TABLE `tipoCredIbrState`;
INSERT INTO `tipoCredIbrState` 
VALUES 
(1,43,0,0,'AERC5495','2024-12-11 14:36:02'),
(2,43,1,1,'AERC5495','2024-12-10 07:00:18'),
(3,43,12,0,'AERC5495','2024-12-11 14:36:02'),
(5,43,3,0,'AERC5495','2024-12-11 14:36:02'),
(6,43,6,0,'AERC5495','2024-12-11 14:36:02'),
(7,44,0,0,'AERC5495','2024-12-10 07:11:49'),
(8,44,1,1,'AERC5495','2024-12-11 14:36:02'),
(9,44,12,0,'AERC5495','2024-12-10 07:11:49'),
(11,44,3,0,'AERC5495','2024-12-10 07:11:49'),
(12,44,6,0,'AERC5495','2024-12-11 14:36:02');

TRUNCATE TABLE `usuario`;
INSERT INTO `usuario` 
VALUES 
('AERC5495','Andres Eduardo Ramirez Clavijo','andrese_ramirez@coomeva.com.co',1,1,9,9,1,'','AERC5495','2025-07-01 16:10:55'),
('ajog8849','Alvaro Javier Otalora Guaza','alvaro_otalora@coomeva.com.co',1,1,9,8,2,'Inactivacion de prueba','AERC5495','2025-07-25 17:08:24'),
('AMZR5511','Adriana Milena Zabala Rodriguez','adrianam_zabala@coomeva.com.co',102,1,1,9,1,'cambios de prueba','AERC5495','2025-08-06 02:39:29'),
('ANRR7231','Angelica Ramirez Rojas','angelica_ramirez@coomeva.com.co',1,5,9,9,1,NULL,'AERC5495','2025-06-20 23:18:25'),
('BHCH8247','Beatriz Helena Cutiva Henao','beatrizh_cutiva@coomeva.com.co',102,1,1,8,1,'','AERC5495','2025-06-20 23:24:51'),
('BOFPEX14','Juan Guillermo Castillo Osorio','juang_castillo@coomeva.com.co',102,1,5,8,1,'','AERC5495','2025-06-20 23:25:13'),
('BQFXOF18','Maira Ivonne Muñoz Gonzalez','mairai_munoz@coomeva.com.co',102,1,6,8,1,'','AERC5495','2025-06-20 23:25:36'),
('CAEV5896','Carolina Echeverry Valdes','carolina_echeverry@coomeva.com.co',102,1,9,2,0,'Eliminacion de Prueba','DYMH1095','2025-06-25 20:52:28'),
('CLCSSC07','Maria Clemencia Marroquin Moreno','mariac_marroquin@coomeva.com.co',1,2,9,6,1,'','AERC5495','2025-07-16 19:05:59'),
('CLCXCR09','Sandra Natalia Ceballos Grisales','sandran_ceballos@coomeva.com.co',102,5,9,9,1,'','AERC5495','2025-06-20 23:26:46'),
('clcxcr51','Carolina  Madrid Panesso','carolina_madrid@coomeva.com.co',102,5,9,6,1,'activando','AERC5495','2025-06-25 22:24:01'),
('cmlv4280','Carlos Mario Larrahondo Valencia','carlosm_larrahondo@coomeva.com.co',102,1,1,1,0,'Eliminacion de usuario','DYMH1095','2025-06-25 21:42:02'),
('Cper5070','Carol Paola Espinosa Rodriguez','carolp_espinosa@coomeva.com.co',102,1,1,1,1,'','AERC5495','2025-06-24 12:46:33'),
('DMSJ3210','Diana Marcela Saldarriaga Jaramillo','dianam_saldarriaga@coomeva.com.co',0,1,2,8,1,NULL,'AERC5495','2025-06-20 23:29:13'),
('dncadf01','Diana Isabel Ruiz Patino','dianai_ruiz@coomeva.com.co',1,2,9,2,NULL,NULL,NULL,'2025-06-20 23:30:48'),
('DPPR4195','Diana Patricia Piedrahita Rios','dianap_piedrahita@coomeva.com.co',102,1,1,1,1,'Activacion','AERC5495','2025-06-20 23:45:18'),
('DYMH1095','Diana Yineth Montero Hernandez','dianay_montero@coomeva.com.co',183,1,5,9,1,'Prueba II','AERC5495','2025-08-06 16:16:12'),
('eatv8722','Edier Augusto Tapasco Velasco','ediera_tapascov@coomeva.com.co',102,4,1,9,1,'Activacion','AERC5495','2025-06-20 23:46:19'),
('elrs9334','Elizabeth Rubiano Sanchez','elizabeth_rubiano@coomeva.com.co',1,1,9,9,1,'Activacion','AERC5495','2025-06-21 16:06:10'),
('face1520','Franchessca Andrea Celemin Escobar','franchesscaa_celemin@coomeva.com.co',102,1,1,1,1,'Usuario prueba','AERC5495','2025-07-03 16:14:57'),
('HEOP0531','Hugo Esgardo Olaya Parra','hugoe_olaya@coomeva.com.co',102,4,1,9,1,'Activacion','AERC5495','2025-06-20 23:47:25'),
('hjmm5719','Hellen Jessica Murillo Moreno','hellenj_murillo@coomeva.com.co',102,1,9,2,1,'','AERC5495','2025-06-20 23:50:13'),
('JCGM8614','Julio Cesar Gomez Maya','julioc_gomez@coomeva.com.co',102,1,9,2,1,'','AERC5495','2025-06-20 23:50:28'),
('JGCB0880','Juan Guillermo Cardona Bermudez','juang_cardona@coomeva.com.co',102,1,1,9,1,NULL,'AERC5495','2025-06-20 23:33:51'),
('jlvf6136','Jorge Luis Villa Fernandez','jorgel_villa@coomeva.com.co',105,1,1,9,1,'','AERC5495','2025-07-16 20:28:51'),
('jmgi5353','Johana Maribel Gil Villegas','johanam_gil@coomeva.com.co',601,1,9,2,NULL,NULL,NULL,'2025-06-20 23:34:25'),
('JOAQ5483','Johana Angel Quijano','johana_angel@coomeva.com.co',102,1,9,9,1,'','AERC5495','2025-06-20 23:50:59'),
('kdpc0841','Karen Dayana Ponce Cordoba','karend_ponce@coomeva.com.co',1,2,9,9,NULL,NULL,NULL,'2025-06-20 23:35:11'),
('kscm4868','Kenen Steven Celis Muñoz','kenens_celis@coomeva.com.co',1,1,9,9,1,'','AERC5495','2025-07-11 20:18:33'),
('ktof5963','Kelly Tatiana Emigdia Ortiz Flor','kellyt_ortiz@coomeva.com.co',1,1,9,4,1,'','AERC5495','2025-07-16 13:56:22'),
('LGGA6413','Luis Guillermo Gutierrez Arias','luisg_gutierrez@coomeva.com.co',102,1,1,1,1,'','AERC5495','2025-06-20 23:51:27'),
('LILO1960','Liliana Londoño Otero','liliana_londono@coomeva.com.co',401,1,4,8,1,NULL,'AERC5495','2025-06-20 23:35:52'),
('LISB3727','Liliana Suarez Barajas','liliana_suarez@coomeva.com.co',0,3,3,8,1,NULL,'AERC5495','2025-06-20 23:36:04'),
('lmza4356','Laura Marcela Zambrano Andrade','lauram_zambrano@coomeva.com.co',1,1,9,9,1,'Reactivacion','jjap5013','2025-07-11 20:44:22'),
('maaa3337','Maykol Alejandro Agudelo Amaya','maykola_agudelo@coomeva.com.co',512,1,5,9,NULL,NULL,NULL,'2025-06-20 23:36:22'),
('MAHA0246','Marysol Herrera Arias','marysol_herrera@coomeva.com.co',1,3,9,8,1,NULL,'AERC5495','2025-06-20 23:36:39'),
('MCMR4329','Maria Camila Muñoz Rosas','mariac_munoz@coomeva.com.co',1,5,9,9,NULL,NULL,NULL,'2025-06-20 23:37:17'),
('MDCADE01','Marcela Naranjo Ruiz','marcela_naranjo@coomeva.com.co',184,1,6,1,1,NULL,'AERC5495','2025-06-20 23:37:37'),
('MLRR3283','Martha Lucia Rodriguez Rios','marthal_rodriguez@coomeva.com.co',1,3,9,8,1,NULL,'AERC5495','2025-06-20 23:37:55'),
('namg0030','Natalia Mejia Granada','natalia_mejia@coomeva.com.co',0,3,3,8,1,NULL,'AERC5495','2025-06-20 23:38:10'),
('natq5916','Nathalie Torres Quintero','nathalie_torresq@coomeva.com.co',102,3,1,8,1,'Reactivación de prueba 16-07-2025 2PM','AERC5495','2025-07-16 19:03:16'),
('NDVN3138','Nestor Daniel Vacca Nuñez','nestor_vaccan@coomeva.com.co',1,1,9,4,1,NULL,'AERC5495','2025-06-20 23:40:03'),
('oetb3698','Osvaldo Ernesto Tafur Barros','osvaldoe_tafur@coomeva.com.co',802,1,6,9,NULL,NULL,NULL,'2025-06-20 23:40:17'),
('SALT6911','Santiago Lopera Taborda','santiago_lopera@coomeva.com.co',1,1,9,8,1,'reasignación','AERC5495','2025-06-20 23:40:34'),
('SMCA1533','Susana Maria Cabrera Antequera','susanam_cabrera@coomeva.com.co',0,1,6,1,2,NULL,'AERC5495','2025-06-20 23:41:04'),
('vafxde02','Juan Gabriel Lopez Gutierrez','juang_lopez@coomeva.com.co',801,1,6,9,NULL,NULL,NULL,'2025-06-20 23:41:22'),
('VAOZ3347','Valentina Ospina Zapata','valentina_ospina@coomeva.com.co',102,4,1,9,2,'Pruebas','AERC5495','2025-06-20 23:41:42'),
('WECA1331','Wellignton Cortes Alvarez','wellignton_cortes@coomeva.com.co',1,1,9,9,1,'Activacion 04/07/2025','AERC5495','2025-07-04 16:12:38'),
('YACG7029','Yudi Alexandra Campos Gonzalez','yudia_campos@coomeva.com.co',1,5,9,9,NULL,NULL,NULL,'2025-06-20 23:42:12'),
('yrmg3557','Yenni Rocio Manjarres Garcia','yennir_manjarres@coomeva.com.co',183,3,9,8,2,'','WECA1331','2025-07-12 05:16:13');