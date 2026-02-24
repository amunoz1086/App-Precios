CREATE TABLE `homologaSector` (
  `idhomologaSector` int NOT NULL AUTO_INCREMENT,
  `codeCobis` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sectorCobis` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` int DEFAULT NULL COMMENT 'Código homologado.',
  PRIMARY KEY (`idhomologaSector`),
  KEY `idxCodeCobis` (`codeCobis`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;