USE `PRICINGDB`;

DELIMITER $$
DROP PROCEDURE IF EXISTS `actualizar_responsables_faltantes`$$
CREATE PROCEDURE `actualizar_responsables_faltantes`()
BEGIN
  -- Paso 1: Hacemos JOIN entre log_pricing y perfiles_usuario
  UPDATE log_pricing A
  
  -- Subconsulta: para cada REGISTRO_MODIFICADO, buscar su última fecha
  JOIN (
    SELECT USUARIO AS REGISTRO_MODIFICADO, MAX(fech_actualizacion) AS fech
    FROM perfiles_usuario
    GROUP BY USUARIO
  ) X 
  ON A.REGISTRO_MODIFICADO = X.REGISTRO_MODIFICADO

  -- JOIN para traer codUsu de esa fecha más reciente
  JOIN perfiles_usuario PU 
  ON PU.USUARIO = X.REGISTRO_MODIFICADO AND PU.fech_actualizacion = X.fech

  -- Condición: Solo si está vacío y es un DELETE PERFIL
  SET A.USUARIO = PU.codUsu
  WHERE (A.USUARIO IS NULL OR A.USUARIO = '')
    AND A.EVENTO = 'DELETE PERFIL';
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `buscarRegional`$$
CREATE PROCEDURE `buscarRegional`(IN COD INT)
BEGIN
			SELECT REGIONAL_RAD FROM regional
			WHERE COD_REGIONAL_RAD = COD;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `crear_o_recuperar_sesion`$$
CREATE PROCEDURE `crear_o_recuperar_sesion`(IN p_usuario_id VARCHAR(15), IN p_usuario_ip VARCHAR(15), OUT p_token VARCHAR(255), OUT p_mensaje VARCHAR(255), OUT p_ip VARCHAR(15), OUT p_sessionActiva BOOLEAN)
BEGIN
			DECLARE v_token_existente VARCHAR(255);
			DECLARE v_ip VARCHAR(15);
			-- Verificar si el usuario ya tiene una sesión
			SELECT token, user_ip INTO v_token_existente, v_ip
			FROM sessions
			WHERE user_id = p_usuario_id
			LIMIT 1;
    
			IF v_token_existente IS NOT NULL THEN
				-- Si ya tiene una sesión, devolver el token y un mensaje
				SET p_token = v_token_existente;
				SET p_mensaje = 'El usuario ya tiene una sesión abierta.';
				SET p_ip = v_ip;
				SET p_sessionActiva=TRUE;
			ELSE
				-- Si no tiene una sesión, crear una nueva sesión
				INSERT INTO sessions (user_id, user_ip, token)
				VALUES (p_usuario_id, p_usuario_ip, MD5(CONCAT(NOW(), RAND()))); -- Usar MD5 solo como ejemplo, en la práctica usar algo más seguro
        
				-- Obtener el token de la nueva sesión
				SELECT token INTO p_token
				FROM sessions
				WHERE user_id = p_usuario_id
				ORDER BY created_at DESC
				LIMIT 1;

				SET p_mensaje = 'Se creó la sesión con éxito.';
			END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deleteFrecuenciaNomina`$$
CREATE PROCEDURE `deleteFrecuenciaNomina`(IN IDPN INT)
BEGIN
			DELETE FROM frecuenciaNomina
            WHERE idfrecuenciaNomina = IDPN;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deleteGastosDirectosOficina`$$
CREATE PROCEDURE `deleteGastosDirectosOficina`(IN IDPN INT)
BEGIN
			DELETE FROM gastosDirectosOficina
            WHERE idgastosDirectosOficina = IDPN;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deleteGastosDirectosPse`$$
CREATE PROCEDURE `deleteGastosDirectosPse`(IN IDPN INT)
BEGIN
			DELETE FROM gastosDirectosPse
            WHERE idgastosDirectosPse = IDPN;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deleteNegociarNomina`$$
CREATE PROCEDURE `deleteNegociarNomina`(IN IDPN INT)
BEGIN
			DELETE FROM negociarNomina
            WHERE idnegociarNomina = IDPN;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deletePagoTerseros`$$
CREATE PROCEDURE `deletePagoTerseros`(IN IDPN INT)
BEGIN
			DELETE FROM pagoTerseros
            WHERE idpagoTerseros = IDPN;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deleteParametrosEfecty`$$
CREATE PROCEDURE `deleteParametrosEfecty`(IN ID INT)
BEGIN
			DELETE FROM ParametrosEfecty
            WHERE idParametrosEfecty = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deletePerfilUsuario`$$
CREATE PROCEDURE `deletePerfilUsuario`(USU VARCHAR(45))
BEGIN
			DELETE FROM perfiles_usuario
			WHERE USUARIO = USU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deletePlanRemuneracion`$$
CREATE PROCEDURE `deletePlanRemuneracion`(IN ID INT)
BEGIN
			DELETE FROM planRemuneracion
			WHERE idplanRemuneracion = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deletePromedioNomina`$$
CREATE PROCEDURE `deletePromedioNomina`(IN IDPN INT)
BEGIN
			DELETE FROM promedioNomina
            WHERE idpromedioNomina = IDPN;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `deleteUsuario`$$
CREATE PROCEDURE `deleteUsuario`(IN id CHAR(15))
BEGIN
    		DELETE FROM usuario WHERE USUARIO = id;
            CALL deletePerfilUsuario(id);
            CALL queryDeleteParametrizador(id);
            CALL queryDeleteEnte (id);
    	END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertCorresponsales`$$
CREATE PROCEDURE `insertCorresponsales`(IN COR VARCHAR(45), PLE DECIMAL(7,1), EST INT, PRO INT, USU CHAR(15))
BEGIN
			INSERT INTO corresponsales (corresponsales, tarifaPlena, estado, ticket_promedio, cod_usu)
			VALUES(COR, PLE, EST, PRO, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertDataBuzon`$$
CREATE PROCEDURE `insertDataBuzon`(IN SOLI INT, BUZON VARCHAR(9), DESCRIP VARCHAR(100), USU CHAR(15))
BEGIN
			INSERT INTO controlBuzon (cod_solicitud, buzon, descripcion, cod_usu)
			VALUES (SOLI, BUZON, DESCRIP, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertDataFile`$$
CREATE PROCEDURE `insertDataFile`(IN SOLI INT, CED VARCHAR(50), RUT VARCHAR(50), CER VARCHAR(50), FRM VARCHAR(50), CON VARCHAR(50), B6 VARCHAR(45), B7 VARCHAR(45), B8 VARCHAR(45), B9 VARCHAR(45), B10 VARCHAR(45), B11 VARCHAR(45), B12 VARCHAR(45), B13 VARCHAR(45), B14 VARCHAR(45), B15 VARCHAR(45), B16 VARCHAR(45), B17 VARCHAR(45), B18 VARCHAR(45), B19 VARCHAR(45), B20 VARCHAR(45), B21 VARCHAR(45), B22 VARCHAR(45), B23 VARCHAR(45), USU CHAR(15))
BEGIN
			INSERT INTO controlDocumentos (cod_solicitud, docCedula, docRut, docCertificado, docFormato, docContrato, docBuzon6, docBuzon7, docBuzon8, docBuzon9, docBuzon10, docBuzon11, docBuzon12, docBuzon13, docBuzon14, docBuzon15, docBuzon16, docBuzon17, docBuzon18, docBuzon19, docBuzon20, docBuzon21, docBuzon22, docBuzon23, cod_usu)
			VALUES (SOLI, CED, RUT, CER, FRM, CON, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20, B21, B22, B23, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertDataRemi`$$
CREATE PROCEDURE `insertDataRemi`(IN REMI LONGTEXT, USU VARCHAR(15))
BEGIN
			INSERT INTO remi (contenidoRemi, id_user)
			VALUES(REMI, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertEnteAprobacion`$$
CREATE PROCEDURE `insertEnteAprobacion`(IN COD INT, USU CHAR(15))
BEGIN
			INSERT INTO ente_aprobacion (COD_APROBADOR, USUARIO)
			VALUES(COD, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertEnteParametrizador`$$
CREATE PROCEDURE `insertEnteParametrizador`(IN USU CHAR(15))
BEGIN
			INSERT INTO ente_parametrizacion (USUARIO)
			VALUES(USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertFrecuenciaNomina`$$
CREATE PROCEDURE `insertFrecuenciaNomina`(IN TIPO VARCHAR(45), USU VARCHAR(45))
BEGIN
			INSERT INTO frecuenciaNomina (tipo, usuario)
			values (TIPO, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertGastosDirectosOficina`$$
CREATE PROCEDURE `insertGastosDirectosOficina`(IN TIPO VARCHAR(100), USU VARCHAR(45))
BEGIN
			INSERT INTO gastosDirectosOficina (tipoGastosDirectosOficina, cod_user)
			VALUES (TIPO, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertGastosDirectosPse`$$
CREATE PROCEDURE `insertGastosDirectosPse`(IN TIPO VARCHAR(100), USU VARCHAR(45))
BEGIN
			INSERT INTO gastosDirectosPse (tipoGastosDirectosPse, cod_user)
			VALUES (TIPO, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertJustificacionOficina`$$
CREATE PROCEDURE `insertJustificacionOficina`(IN COD_GASTO INT, TIPO VARCHAR(100), PERMITIR INT, PLENA DECIMAL(10,1), USU VARCHAR(45))
BEGIN
            INSERT INTO justificacionOficina (codGastosDirectosOfi, tipoJustificacionOfi, permitirNegociar, tarifaPlena, cod_usu)
			VALUES (COD_GASTO, TIPO, PERMITIR, PLENA, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertJustificacionPse`$$
CREATE PROCEDURE `insertJustificacionPse`(IN COD_GASTO INT, TIPO VARCHAR(100), PERMITIR INT, PLENA DECIMAL(10,1), USU VARCHAR(45))
BEGIN
            INSERT INTO justificacionPse (codGastosDirectosPse, tipoJustificacionPse, permitirNegociar, tarifaPlena, cod_usu)
			VALUES (COD_GASTO, TIPO, PERMITIR, PLENA, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertNegociarNomina`$$
CREATE PROCEDURE `insertNegociarNomina`(IN PAGO VARCHAR(45), PLENA DECIMAL(7,1), COSTO DECIMAL(7,1), CANT INT, NEGO INT, FORMULA VARCHAR(45), USU VARCHAR(45))
BEGIN
			INSERT INTO negociarNomina (pagoNomina, tarifaPlena, tarifaCosto, cantidad, permitirNegociar, formulaCalculo, usuario)
			values (PAGO, PLENA, COSTO, CANT, NEGO, FORMULA, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertPagoTerseros`$$
CREATE PROCEDURE `insertPagoTerseros`(IN PAGO VARCHAR(45), TARIFA DECIMAL(7,1), USU VARCHAR(45))
BEGIN
			INSERT INTO pagoTerseros (pagoTerseros, tarifaPlena, usuario)
			values (PAGO, TARIFA, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertParametrosEfecty`$$
CREATE PROCEDURE `insertParametrosEfecty`(IN TIPO VARCHAR(80), USU VARCHAR(45))
BEGIN
			INSERT INTO ParametrosEfecty (ParametrosEfecty, cod_usu)
			VALUES (TIPO, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertPerfilUsuario`$$
CREATE PROCEDURE `insertPerfilUsuario`(IN PER INT, USU VARCHAR(15), CUSU VARCHAR(15))
BEGIN
			INSERT INTO perfiles_usuario (COD_PERFIL, USUARIO, codUsu)
			VALUES(PER, USU, CUSU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertPlanRemuneracion`$$
CREATE PROCEDURE `insertPlanRemuneracion`(IN PLAN VARCHAR(25), INFERIOR DECIMAL(14,0), MAXIMO DECIMAL(14,0), TASA DECIMAL(5,2), USU VARCHAR(45))
BEGIN
			INSERT INTO planRemuneracion (planRemuneracion, rangoInferior, rangoMaximo, tasaEA, cod_usu)
			VALUE (PLAN, INFERIOR, MAXIMO, TASA, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertPromedioNomina`$$
CREATE PROCEDURE `insertPromedioNomina`(IN TIPO VARCHAR(45), USU VARCHAR(45))
BEGIN
			INSERT INTO promedioNomina (tipo, usuario)
			values (TIPO, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `insertUsuario`$$
CREATE PROCEDURE `insertUsuario`(IN nwUSU VARCHAR(45), NOM VARCHAR(80), COR VARCHAR(80), CAR INT, OFI INT, REG INT, CAN INT, EDO INT, OBN VARCHAR(200), USU VARCHAR(15))
BEGIN
			INSERT INTO usuario ( USUARIO, NOMBRE, CORREO, COD_CARGO, COD_OFICINA, COD_REGIONAL, COD_CANAL, ESTADO_USU, OBSERVACION, codUsu)
			VALUES(nwUSU, NOM, COR, CAR, OFI, REG, CAN, EDO, OBN, USU);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarAccion`$$
CREATE  PROCEDURE `listarAccion`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'Accion';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarAsocCoomeva`$$
CREATE PROCEDURE `listarAsocCoomeva`()
BEGIN
			SELECT COD_ASOC, ASOC FROM asoc;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarCanal`$$
CREATE PROCEDURE `listarCanal`()
BEGIN
			SELECT COD_CANAL_RAD, CANAL_RAD FROM canal ORDER BY COD_CANAL_RAD ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarCargos`$$
CREATE PROCEDURE `listarCargos`()
BEGIN
			SELECT COD_CARGO, CARGO FROM cargos ORDER BY COD_CARGO ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarEstadoBanco`$$
CREATE PROCEDURE `listarEstadoBanco`()
BEGIN
			SELECT COD_ESTADO_BCO, ESTADO_BCO FROM estado_bco;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarEstadoCoomeva`$$
CREATE PROCEDURE `listarEstadoCoomeva`()
BEGIN
			SELECT COD_ESTADO_ASO, ESTADO_ASO FROM estado_aso;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarIbr`$$
CREATE PROCEDURE `listarIbr`()
BEGIN
			SELECT cod_ibr, ibr_descripcion FROM PRICINGDB.ibr_control;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarNaturaleza`$$
CREATE PROCEDURE `listarNaturaleza`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'Naturaleza';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarOficinas`$$
CREATE PROCEDURE `listarOficinas`()
BEGIN
			SELECT COD_OFICINA, concat(COD_OFICINA, " - ", OFICINA) AS OFICINA, REGIONAL
            FROM oficina ORDER BY COD_OFICINA ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarPerfil`$$
CREATE PROCEDURE `listarPerfil`()
BEGIN
			SELECT COD_PERFIL, PERFIL, DESCRIPCION 
            FROM perfiles 
            ORDER BY COD_PERFIL ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarRegional`$$
CREATE PROCEDURE `listarRegional`()
BEGIN
			SELECT COD_REGIONAL_RAD, REGIONAL_RAD FROM regional ORDER BY COD_REGIONAL_RAD ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarSector`$$
CREATE PROCEDURE `listarSector`()
BEGIN
			SELECT COD_SECTOR, NOMBRE FROM sector;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarTipoAprobador`$$
CREATE PROCEDURE `listarTipoAprobador`()
BEGIN
			SELECT cod_aprobador, tipo_aprobador FROM tipo_aprobador ORDER BY idtipo_aprobador ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarTipoCliente`$$
CREATE PROCEDURE `listarTipoCliente`()
BEGIN
			SELECT COD_TIPO_CLIENTE, TIPOCLI FROM tipo_cliente;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `listarTipoContrato`$$
CREATE PROCEDURE `listarTipoContrato`()
BEGIN
			SELECT COD_TIP_CONTRATO, TIPO_CONTRATO FROM tipo_contrato;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryAdquirencia`$$
CREATE PROCEDURE `queryAdquirencia`()
BEGIN
			SELECT idadquirencia, tipoAdquirencia, puntos, tarifaCosto  FROM adquirencia;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryAprobador`$$
CREATE PROCEDURE `queryAprobador`(IN COD INT)
BEGIN
			SELECT A.USUARIO, B.tipo_aprobador, C.CORREO
			FROM ente_aprobacion AS A
			JOIN tipo_aprobador AS B ON B.COD_APROBADOR = A.COD_APROBADOR
			JOIN usuario AS C ON C.USUARIO = A.USUARIO
			WHERE A.COD_APROBADOR = COD
            ORDER BY rand()
            LIMIT 1;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryAprobarCreditos`$$
CREATE PROCEDURE `queryAprobarCreditos`(IN SOLICITUD INT, DECISION INT, OBSER VARCHAR(1500), USU CHAR(15))
BEGIN
            DECLARE APRO INT;
            DECLARE REQUERIDAS INT;
            DECLARE ENTE CHAR(4);
            DECLARE TIPOENTE INT;
            DECLARE ENTES_ATRIBUCION VARCHAR(30);
            DECLARE NAPRO INT;
            DECLARE PARAMETRIZADOR CHAR(15);
            DECLARE CORREOS TEXT;
            
			SET APRO = (SELECT count(A.codSolicitud)
						FROM asignaciones AS A
						JOIN solicitudes AS B ON A.codSolicitud = B.COD_SOLICITUD
						JOIN estado_asignacion AS C ON C.idAsignacion = A.idasignacion
						WHERE A.codSolicitud = SOLICITUD AND codDecision = 1
						GROUP BY A.codSolicitud);
			
            SET APRO = (SELECT IFNULL(APRO, 0));
            
            SET ENTES_ATRIBUCION = (SELECT JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION
									FROM solicitudes AS A 
									WHERE COD_SOLICITUD = SOLICITUD);
                            
			SET REQUERIDAS = (SELECT JSON_LENGTH(ENTES_ATRIBUCION));
            
            SET PARAMETRIZADOR = (SELECT JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR')) AS COD_PARAMETRIZADOR
									FROM solicitudes AS A 
									WHERE COD_SOLICITUD = SOLICITUD);
            
            IF DECISION = 0 THEN
				-- ACTUALIZAR ESTADO_ASIGANACION;
                INSERT INTO estado_asignacion (idAsignacion, codDecision, observacion, codUsuario)
				VALUES ((SELECT idasignacion FROM asignaciones WHERE codSolicitud = SOLICITUD ORDER BY idasignacion DESC Limit 1), DECISION, OBSER, USU);
                -- ACTUALIZAR ESTADO_SOLICITUD A NO APROBADOR;
                INSERT INTO estado_solicitud (codSolicitud, estadoAprobacion,fechaAprobacion, estadoParametrizacion, fechaParametrizacion)
				VALUES (SOLICITUD, DECISION, NOW(), DECISION, NOW());
                --
                SELECT 0 COD;
            ELSE
				IF (APRO + 1) < REQUERIDAS THEN
					-- ACTUALIZAR ESTADO_ASIGANACION;
                    INSERT INTO estado_asignacion (idAsignacion, codDecision, codUsuario)
					VALUES ((SELECT idasignacion FROM asignaciones WHERE codSolicitud = SOLICITUD ORDER BY idasignacion DESC Limit 1), DECISION, USU);
					-- INSERTAR ASIGANCION;
                    SET NAPRO = APRO + 1;
                    SET TIPOENTE = (SELECT JSON_UNQUOTE(JSON_EXTRACT(ENTES_ATRIBUCION, CONCAT('$[', NAPRO, ']'))));
                    SET ENTE = TIPOENTE;
                    SET CORREOS = (SELECT json_arrayagg(A.CORREO) FROM usuario AS A JOIN ente_aprobacion AS B ON B.USUARIO = A.USUARIO WHERE B.COD_APROBADOR = TIPOENTE);
                    
                    CALL queryInsertAsignacion(SOLICITUD, ENTE, TIPOENTE);
                    CALL queryDatosCorreo(SOLICITUD, CORREOS);
				ELSE
					-- ACTUALIZAR ESTADO_ASIGANACION;
                    INSERT INTO estado_asignacion (idAsignacion, codDecision, codUsuario)
					VALUES ((SELECT idasignacion FROM asignaciones WHERE codSolicitud = SOLICITUD ORDER BY idasignacion DESC Limit 1), DECISION, USU);
					-- ACTUALIZAR ESTADO PARAMETRIZADOR;
                    SET TIPOENTE = 0;
                    SET CORREOS = (SELECT CORREO FROM usuario WHERE USUARIO = PARAMETRIZADOR);
                    
                    CALL queryInsertAsignacion(SOLICITUD, PARAMETRIZADOR, TIPOENTE);
                    CALL queryDatosCorreo(SOLICITUD, CORREOS);
                    -- ACTUALIZAR ESTADO DE APROBACION
                    INSERT INTO estado_solicitud (codSolicitud, estadoAprobacion,fechaAprobacion)
					VALUES (SOLICITUD, DECISION, NOW());
				END IF;
			END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryAuditoria`$$
CREATE PROCEDURE `queryAuditoria`(
    IN USU VARCHAR(15),
    IN ACC INT,
    IN DESDE DATE,
    IN HASTA DATE
)
BEGIN
    DECLARE filtroUsuario BOOLEAN DEFAULT TRUE;
    DECLARE filtroAccion BOOLEAN DEFAULT TRUE;
    -- Determinar si se debe filtrar por usuario
    SET filtroUsuario = (USU != 'A');
    -- Determinar si se debe filtrar por acción
    SET filtroAccion = (ACC != 4);
    -- Consulta base
    CALL actualizar_responsables_faltantes();
    WITH log_expandido AS (
    SELECT 
        A.COD_LOGPRICING,
        A.USUARIO,
        A.ACCION,
        A.EVENTO,
        A.FECHA,
        A.REGISTRO_MODIFICADO,
        A.CAMPO_MODIFICADO,
        A.DATA_ACTUAL,
        A.DATA_NUEVA,
        A.OBSERVACION,
        LAG(A.EVENTO, 1) OVER (PARTITION BY A.REGISTRO_MODIFICADO, A.USUARIO ORDER BY A.COD_LOGPRICING) AS EVENTO_ANTERIOR,
        LAG(A.CAMPO_MODIFICADO, 1) OVER (PARTITION BY A.REGISTRO_MODIFICADO, A.USUARIO ORDER BY A.COD_LOGPRICING) AS CAMPO_ANTERIOR,
        LAG(A.EVENTO, 2) OVER (PARTITION BY A.REGISTRO_MODIFICADO, A.USUARIO ORDER BY A.COD_LOGPRICING) AS EVENTO_2_ANTES,
        LAG(A.CAMPO_MODIFICADO, 2) OVER (PARTITION BY A.REGISTRO_MODIFICADO, A.USUARIO ORDER BY A.COD_LOGPRICING) AS CAMPO_2_ANTES
    FROM log_pricing AS A
    WHERE DATE(FECHA) BETWEEN DESDE AND HASTA
      AND (filtroUsuario = FALSE OR USUARIO = USU)
      AND (filtroAccion = FALSE OR ACCION = ACC)
),
marcado AS (
    SELECT *,
        CASE
            WHEN EVENTO = 'INSERT PERFIL'
              AND CAMPO_MODIFICADO = 'COD_PERFIL'
              AND EVENTO_ANTERIOR = 'DELETE PERFIL'
              AND CAMPO_ANTERIOR = 'COD_PERFIL'
              AND EVENTO_2_ANTES IN ('UPDATE USUARIO', 'UPDATE ESTADO')
              AND CAMPO_2_ANTES IN ('COD_PERFIL', 'ESTADO_USU', 'COD_CARGO', 'COD_CANAL', 'COD_REGIONAL', 'COD_OFICINA')
            THEN 'Sí'
            WHEN EVENTO = 'DELETE PERFIL'
              AND CAMPO_MODIFICADO = 'COD_PERFIL'
              AND EVENTO_ANTERIOR IN ('UPDATE USUARIO', 'UPDATE ESTADO')
              AND CAMPO_ANTERIOR IN ('COD_PERFIL', 'ESTADO_USU', 'COD_CARGO', 'COD_CANAL', 'COD_REGIONAL', 'COD_OFICINA')
            THEN 'Sí'
            ELSE 'No'
        END AS OMITIDO_LOGICA
    FROM log_expandido
)
SELECT 
	A.USUARIO AS RESPONSABLE, B.descripcion AS ACCION, A.EVENTO, A.FECHA,
    A.REGISTRO_MODIFICADO, A.CAMPO_MODIFICADO, 
    -- Data actual
    CASE A.CAMPO_MODIFICADO
		WHEN 'COD_OFICINA' THEN (
			SELECT OFICINA 
            FROM oficina 
            WHERE COD_OFICINA = A.DATA_ACTUAL 
            LIMIT 1
        )
        WHEN 'COD_REGIONAL' THEN (
            SELECT REGIONAL_RAD 
            FROM regional 
            WHERE COD_REGIONAL_RAD = A.DATA_ACTUAL 
            LIMIT 1
        )
        WHEN 'ESTADO_USU' THEN (
			SELECT 
				IF(A.DATA_ACTUAL = 0, 
				'Eliminado', 
				(SELECT descripcion 
				FROM Listas 
				WHERE lista = 'Estado' AND codLista = A.DATA_ACTUAL 
				LIMIT 1)
			)
        )
        WHEN 'COD_CANAL' THEN (
            SELECT CANAL_RAD 
            FROM canal 
            WHERE COD_CANAL_RAD = A.DATA_ACTUAL 
            LIMIT 1
        )
        WHEN 'COD_CARGO' THEN (
            SELECT CARGO 
            FROM cargos 
            WHERE COD_CARGO = A.DATA_ACTUAL 
            LIMIT 1
        )
        WHEN 'COD_PERFIL' THEN (
            SELECT DESCRIPCION 
            FROM perfiles 
            WHERE COD_PERFIL = A.DATA_ACTUAL 
            LIMIT 1
        )
        ELSE A.DATA_ACTUAL
		END AS DATA_ACTUAL,
        -- Data nueva
        CASE A.CAMPO_MODIFICADO
        WHEN 'COD_OFICINA' THEN (
            SELECT OFICINA 
            FROM oficina 
            WHERE COD_OFICINA = A.DATA_NUEVA
            LIMIT 1
        )
        WHEN 'COD_REGIONAL' THEN (
            SELECT REGIONAL_RAD 
            FROM regional 
            WHERE COD_REGIONAL_RAD = A.DATA_NUEVA
            LIMIT 1
        )
        WHEN 'ESTADO_USU' THEN (
			SELECT 
				IF(A.DATA_NUEVA = 0, 
				'Eliminado', 
				(SELECT descripcion 
				FROM Listas 
				WHERE lista = 'Estado' AND codLista = A.DATA_NUEVA 
				LIMIT 1)
			)
        )
        WHEN 'COD_CANAL' THEN (
            SELECT CANAL_RAD 
            FROM canal 
            WHERE COD_CANAL_RAD = A.DATA_NUEVA
            LIMIT 1
        )
        WHEN 'COD_CARGO' THEN (
            SELECT CARGO 
            FROM cargos 
            WHERE COD_CARGO = A.DATA_NUEVA 
            LIMIT 1
        )
        WHEN 'COD_PERFIL' THEN (
            SELECT DESCRIPCION 
            FROM perfiles 
            WHERE COD_PERFIL = A.DATA_NUEVA
		LIMIT 1
    )
    ELSE A.DATA_NUEVA
	END AS DATA_NUEVA,
	A.OBSERVACION
FROM marcado AS A
JOIN Listas AS B ON B.lista = 'Accion' AND B.codLista = A.ACCION
WHERE OMITIDO_LOGICA = 'No'
ORDER BY REGISTRO_MODIFICADO, COD_LOGPRICING;
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryCorreoAprobadores`$$
CREATE PROCEDURE `queryCorreoAprobadores`(IN TIPOENTE INT)
BEGIN
			SELECT JSON_ARRAYAGG(A.CORREO) AS CORREOS
			FROM usuario AS A
			JOIN ente_aprobacion AS B ON B.USUARIO = A.USUARIO
			WHERE B.COD_APROBADOR = TIPOENTE;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryCorreoParametrizador`$$
CREATE PROCEDURE `queryCorreoParametrizador`(IN SOLICITUD INT)
BEGIN
			SET @ENTE = (SELECT codEnte FROM asignaciones WHERE codSolicitud = SOLICITUD ORDER BY idasignacion DESC LIMIT 1);
            SET @CORREO = (SELECT CORREO FROM usuario WHERE USUARIO = @ENTE);
			CALL queryDatosCorreo(SOLICITUD, @CORREO);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryCorreoRadicador`$$
CREATE PROCEDURE `queryCorreoRadicador`(IN SOLICITUD INT)
BEGIN
			SELECT CORREO FROM usuario
            WHERE USUARIO = (SELECT ID_RADICADOR FROM solicitudes WHERE COD_SOLICITUD = SOLICITUD);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryCorresponsales`$$
CREATE PROCEDURE `queryCorresponsales`()
BEGIN
			SELECT idcorresponsales, corresponsales, tarifaPlena, estado, ticket_promedio
			FROM corresponsales;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDataBuzon`$$
CREATE PROCEDURE `queryDataBuzon`(IN SOLI INT)
BEGIN
			SELECT cod_solicitud, buzon, descripcion
            FROM controlBuzon WHERE cod_solicitud = SOLI;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDataFile`$$
CREATE PROCEDURE `queryDataFile`(IN SOLI INT)
BEGIN
			SELECT cod_solicitud, docCedula, docRut, docCertificado, docFormato, docContrato,
            docBuzon6, docBuzon7, docBuzon8, docBuzon9, docBuzon10, docBuzon11, docBuzon12,
            docBuzon13, docBuzon14, docBuzon15, docBuzon16, docBuzon17, docBuzon18, docBuzon19,
            docBuzon20, docBuzon21, docBuzon22, docBuzon23
            FROM controlDocumentos WHERE cod_solicitud = SOLI;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDataRemi`$$
CREATE PROCEDURE `queryDataRemi`()
BEGIN
			SELECT contenidoRemi 
			FROM remi ORDER BY idremi DESC
			LIMIT 1;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDatosCorreo`$$
CREATE PROCEDURE `queryDatosCorreo`(IN SOLICITUD INT, CORREOS TEXT)
BEGIN
			SELECT 1 AS COD, A.COD_SOLICITUD, A.NIT_CLIENTE,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.antiguedad_ban') AS ANTIGUEDAD, 
			(CORREOS) AS CORREO,
            (SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CONVERT(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional'),SIGNED)) AS REGIONAL,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_MINIMO') AS RENTABILIDAD_MIN,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.UTILIDAD_ANUAL') AS UTILIDAD_ANUAL,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.POR_COSTO_INTEGRAL_Max') AS COSTO_INTEGRAL_MAX,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.TOTAL_PROMEDIO_COLOCA') AS TOTAL_CARTERA,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.VALOR_CAPTACION_1') AS TOTAL_CAPTACION,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.TOTAL_MARGEN_CARTERA') AS MARGEN_CARTERA,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.MARGEN_CAPTACION') AS MARGEN_CAPTACION,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.MARGEN_CONVENIOS') AS MARGEN_CONVENIOS,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ADQUI_RECIPRO') AS RECIPROCIDAD_ADQUIRIDA,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_ENTE_ATRIBUCION_FINAL[0].tipo_aprobador') AS CARGO_APRO,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_PARAMETRIZADOR.CARGO') AS CARGO_PARA,
            
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[0].monto')) AS CUPO_MONTO,
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[1].monto')) AS TESO_MONTO,
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[0].plazo')) AS CUPO_PLAZO,
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[1].plazo')) AS TESO_PLAZO,
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[0].coberturaFng')) AS CUPO_COBERTURA,
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[1].coberturaFng')) AS TESO_COBERTURA,
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[0].spreadIbr')) AS CUPO_REDESCUENTO,
			JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO[1].spreadIbr')) AS TESO_REDESCUENTO,
            
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RECIPROCIDAD_RESUMEN.ahorro.monto1')AS AHORROMONTO,
			JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RECIPROCIDAD_RESUMEN.ahorro.tasa1')AS AHORROTASA,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RECIPROCIDAD_RESUMEN.corriente.monto0')AS CORRIENTEMONTO,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RECIPROCIDAD_RESUMEN.corriente.tasa0')AS CORRIENTETASA,
            
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.SOLICITUD.tipoProducto.credito')AS CREDITO,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.SOLICITUD.tipoProducto.convenio')AS CONVENIO,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.SOLICITUD.tipoOperacion.nuevo')AS OPERACION,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.SOLICITUD.tipoConvenio.convenioPago')AS CONVENIOPAGO,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.SOLICITUD.tipoConvenio.convenioRecaudo')AS CONVENIORECAUDO,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.SOLICITUD.tipoConvenio.servicioFinanciero')AS SERVICIOFINANCIERO,
            
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_PAGO.convenioPagoNominaTipo')AS CONVENIONOMINA,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_PAGO.convenioPagoTerceros')AS CONVENIOTERCEROS,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_RECAUDO.recaudoOficina')AS RECAUDOBARRAS,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_RECAUDO.recaudoOficina')AS RECAUDOREFERENCIA,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_RECAUDO.recaudoPSE')AS RECAUDOPSE,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_RECAUDO.recaudoPSE')AS RECAUDOPORTAL,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_RECAUDO.recaudoCorresponsales')AS RECAUDOCORRESPONSAL,
            JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_RECAUDO.adquirencia')AS RECAUDOADQUIRENCIA
			FROM solicitudes AS A
			WHERE A.COD_SOLICITUD = SOLICITUD;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDeleteEnte`$$
CREATE PROCEDURE `queryDeleteEnte`(IN USU CHAR(15))
BEGIN
			DELETE FROM ente_aprobacion
			WHERE USUARIO = USU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDeleteParametrizador`$$
CREATE PROCEDURE `queryDeleteParametrizador`(IN USU CHAR(15))
BEGIN
			DELETE FROM ente_parametrizacion
			WHERE USUARIO = USU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDeleteSesionUsuario`$$
CREATE PROCEDURE `queryDeleteSesionUsuario`(IN USU CHAR(15))
BEGIN
			DELETE FROM sessions
			WHERE user_id = USU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryDetalleSolicitud`$$
CREATE PROCEDURE `queryDetalleSolicitud`(IN COD INT)
BEGIN			
            	SELECT 
                A.COD_SOLICITUD,
                A.ID_RADICADOR,
                A.NIT_CLIENTE,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.PRODUCTO') AS PRODUCTO,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO') AS CREDITO_NUEVO,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_PAGO') AS CONVENIO_PAGO,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_RECAUDO') AS CONVENIO_RECAUDO,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONVENIO_SERVICIO') AS SERVICIOS_FINANCIEROS,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION') AS RADICACION,
                JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.DOCUMENTO')) AS DOCUMENTO,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.REMI') AS REMI,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.DEPOSITO_VISTA') AS DEPOSITO_VISTA,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RECIPROCIDAD_RESUMEN') AS RECIPROCIDAD_RESUMEN,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CONFIGURACIO') AS CONFIGURACION,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.TECNICO_OPERADOR') AS TECNICO_OPERADOR	,
                JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CLIENTE_MODAL')) AS CLIENTE_MODAL,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CAMPO_ADICIONALES_MODAL') AS CAMPO_ADICIONALES_MODAL,
                JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CLIENTE_FIDUCIA')) AS CLIENTE_FIDUCIA,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.EDITAR') AS EDITAR,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.ESTADO_SOLICITUD') AS ESTADO_SOLICITUD,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.SOLICITUD') AS SOLICITUD,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME') AS KNIME
				FROM solicitudes AS A
				WHERE A.COD_SOLICITUD = COD;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS  `queryEnte`$$
CREATE PROCEDURE `queryEnte`(IN PERFIL CHAR(15), USU CHAR(15))
BEGIN
			IF PERFIL = 'Aprobación' THEN
				SELECT COD_APROBADOR FROM ente_aprobacion WHERE USUARIO = USU;
            ELSEIF PERFIL = 'Parametrización' THEN
				SELECT COD_PARAMETRIZADOR FROM ente_parametrizacion WHERE USUARIO = USU;
            END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryEstadoEnvioParametrizador`$$
CREATE PROCEDURE `queryEstadoEnvioParametrizador`(IN COD INT)
BEGIN
			SELECT IF(isnull(estatusCorreo) = 1, 'false', 'true') AS statusCorreo FROM estado_solicitud WHERE codSolicitud = COD;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryEstadoSolicitud`$$
CREATE PROCEDURE `queryEstadoSolicitud`(IN SOLICITUD INT)
BEGIN
			SELECT codSolicitud, estadoAprobacion, estadoParametrizacion
            FROM estado_solicitud
            WHERE codSolicitud = SOLICITUD;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryFrecuenciaNomina`$$
CREATE PROCEDURE `queryFrecuenciaNomina`()
BEGIN
			SELECT idfrecuenciaNomina, tipo, valor FROM frecuenciaNomina;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryGastosDirectosOficina`$$
CREATE PROCEDURE `queryGastosDirectosOficina`()
BEGIN
			SELECT idgastosDirectosOficina, tipoGastosDirectosOficina FROM gastosDirectosOficina;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryGastosDirectosPse`$$
CREATE PROCEDURE `queryGastosDirectosPse`()
BEGIN
			SELECT idgastosDirectosPse, tipoGastosDirectosPse FROM gastosDirectosPse;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryIbrs`$$
CREATE PROCEDURE `queryIbrs`()
BEGIN
			SELECT I.cod_ibr, I.ibr_descripcion, C.cod_fech, valor_ibr FROM ibr AS I
			JOIN  ibr_control AS C ON I.cod_ibr = C.cod_ibr
			WHERE C.cod_fech = (SELECT cod_fech FROM ibr_control ORDER BY cod_fech DESC LIMIT 1);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryInsertAsignacion`$$
CREATE PROCEDURE `queryInsertAsignacion`(IN SOLICITUD INT, ENTE CHAR(15), TIPOENTE INT)
BEGIN
			INSERT INTO asignaciones (codSolicitud, codEnte, codTipo)
			VALUES (SOLICITUD, ENTE, TIPOENTE);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryInsertSolicitud`$$
CREATE PROCEDURE `queryInsertSolicitud`(IN NIT CHAR(15), DATOS LONGTEXT, USU CHAR(15), APROBACIONES INT)
BEGIN
			INSERT INTO solicitudes (NIT_CLIENTE, DATOS_SOLICITUD, ID_RADICADOR, APROREQUERIDAS)
			VALUES (NIT, DATOS, USU, APROBACIONES);
            SELECT MAX(COD_SOLICITUD) AS SOLICITUD  FROM solicitudes;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryJustificacionOficina`$$
CREATE PROCEDURE `queryJustificacionOficina`()
BEGIN
			SELECT A.idgastosDirectosOficina, A.tipoGastosDirectosOficina, B.idjustificacionOficina,
            B.tipoJustificacionOfi, B.permitirNegociar, B.tarifaPlena
			FROM gastosDirectosOficina AS A
			JOIN justificacionOficina AS B ON A.idgastosDirectosOficina = B.codGastosDirectosOfi
			ORDER BY A.idgastosDirectosOficina ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryJustificacionPse`$$
CREATE PROCEDURE `queryJustificacionPse`()
BEGIN
			SELECT A.idgastosDirectosPse, A.tipoGastosDirectosPse,
            B.idjustificacionPse, B.tipoJustificacionPse, B.permitirNegociar, B.tarifaPlena
			FROM gastosDirectosPse AS A
			JOIN justificacionPse AS B ON A.idgastosDirectosPse = B.codGastosDirectosPse
			ORDER BY A.idgastosDirectosPse ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarAplica`$$
CREATE PROCEDURE `queryListarAplica`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'Aplica';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarCoberturaFng`$$
CREATE PROCEDURE `queryListarCoberturaFng`()
BEGIN
			SELECT A.codCobertura, A.valor, A.descripcion
			FROM coberturaFng AS A;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarCreditoPorAprobacion`$$
CREATE  PROCEDURE `queryListarCreditoPorAprobacion`(IN COD CHAR(15), NIT CHAR(10))
BEGIN			
            IF NIT = '' THEN
            SELECT A.COD_SOLICITUD, A.NIT_CLIENTE,
				(SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional') AS SIGNED)) AS REGIONAL,
				(SELECT OFICINA FROM oficina WHERE COD_OFICINA = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.oficina') AS SIGNED)) AS OFICINA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_MINIMO') AS RENTABILIDAD_MIN,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.UTILIDAD_ANUAL') AS UTILIDAD_ANUAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.POR_COSTO_INTEGRAL_Max') AS COSTO_INTEGRAL_MAX,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR') AS COD_PARAMETRIZADOR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoMonto') AS CUPO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoMonto') AS TESO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoPlazo') AS CUPO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoPlazo') AS TESO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoIBR') AS CUPO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoIBR') AS TESO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoCobertura') AS CUPO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoCobertura') AS TESO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.promedio') AS RECIPROCIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_ENTE_ATRIBUCION_FINAL[0].tipo_aprobador') AS CARGO_APRO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_PARAMETRIZADOR.CARGO') AS CARGO_PARA,
				B.idasignacion, B.codEnte, C.codDecision, A.APROREQUERIDAS
				FROM solicitudes AS A
				JOIN asignaciones AS B ON A.COD_SOLICITUD = B.codSolicitud 
				LEFT JOIN estado_asignacion AS C ON B.idasignacion = C.idasignacion
				WHERE isnull(C.codDecision) AND B.codEnte = COD AND B.codTipo != 0
				ORDER BY COD_SOLICITUD ASC;
            ELSE
				SELECT A.COD_SOLICITUD, A.NIT_CLIENTE,
				(SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional') AS SIGNED)) AS REGIONAL,
				(SELECT OFICINA FROM oficina WHERE COD_OFICINA = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.oficina') AS SIGNED)) AS OFICINA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_MINIMO') AS RENTABILIDAD_MIN,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.UTILIDAD_ANUAL') AS UTILIDAD_ANUAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.POR_COSTO_INTEGRAL_Max') AS COSTO_INTEGRAL_MAX,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR') AS COD_PARAMETRIZADOR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoMonto') AS CUPO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoMonto') AS TESO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoPlazo') AS CUPO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoPlazo') AS TESO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoIBR') AS CUPO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoIBR') AS TESO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoCobertura') AS CUPO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoCobertura') AS TESO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.promedio') AS RECIPROCIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_ENTE_ATRIBUCION_FINAL[0].tipo_aprobador') AS CARGO_APRO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_PARAMETRIZADOR.CARGO') AS CARGO_PARA,
				B.idasignacion, B.codEnte, C.codDecision, A.APROREQUERIDAS
				FROM solicitudes AS A
				JOIN asignaciones AS B ON A.COD_SOLICITUD = B.codSolicitud 
				LEFT JOIN estado_asignacion AS C ON B.idasignacion = C.idasignacion
				WHERE isnull(C.codDecision) AND B.codEnte = COD AND A.NIT_CLIENTE = NIT AND B.codTipo != 0
				ORDER BY COD_SOLICITUD ASC;
            END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarCreditoPorParametrizar`$$
CREATE PROCEDURE `queryListarCreditoPorParametrizar`(IN COD CHAR(15), NIT CHAR(10))
BEGIN			
            IF NIT = '' THEN
            SELECT A.COD_SOLICITUD, A.NIT_CLIENTE,
				(SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional') AS SIGNED)) AS REGIONAL,
				(SELECT OFICINA FROM oficina WHERE COD_OFICINA = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.oficina') AS SIGNED)) AS OFICINA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_MINIMO') AS RENTABILIDAD_MIN,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.UTILIDAD_ANUAL') AS UTILIDAD_ANUAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.POR_COSTO_INTEGRAL_Max') AS COSTO_INTEGRAL_MAX,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR') AS COD_PARAMETRIZADOR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoMonto') AS CUPO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoMonto') AS TESO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoPlazo') AS CUPO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoPlazo') AS TESO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoIBR') AS CUPO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoIBR') AS TESO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoCobertura') AS CUPO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoCobertura') AS TESO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.promedio') AS RECIPROCIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_ENTE_ATRIBUCION_FINAL[0].tipo_aprobador') AS CARGO_APRO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_PARAMETRIZADOR.CARGO') AS CARGO_PARA,
				B.idasignacion, B.codEnte, C.codDecision
				FROM solicitudes AS A
				JOIN asignaciones AS B ON A.COD_SOLICITUD = B.codSolicitud 
				LEFT JOIN estado_asignacion AS C ON B.idasignacion = C.idasignacion
				WHERE B.codEnte = COD AND B.codTipo = 0
				ORDER BY COD_SOLICITUD ASC;
            ELSE
				SELECT A.COD_SOLICITUD, A.NIT_CLIENTE,
				(SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional') AS SIGNED)) AS REGIONAL,
				(SELECT OFICINA FROM oficina WHERE COD_OFICINA = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.oficina') AS SIGNED)) AS OFICINA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_MINIMO') AS RENTABILIDAD_MIN,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.UTILIDAD_ANUAL') AS UTILIDAD_ANUAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.POR_COSTO_INTEGRAL_Max') AS COSTO_INTEGRAL_MAX,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR') AS COD_PARAMETRIZADOR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoMonto') AS CUPO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoMonto') AS TESO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoPlazo') AS CUPO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoPlazo') AS TESO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoIBR') AS CUPO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoIBR') AS TESO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoCobertura') AS CUPO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoCobertura') AS TESO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.promedio') AS RECIPROCIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_ENTE_ATRIBUCION_FINAL[0].tipo_aprobador') AS CARGO_APRO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_PARAMETRIZADOR.CARGO') AS CARGO_PARA,
				B.idasignacion, B.codEnte, C.codDecision
				FROM solicitudes AS A
				JOIN asignaciones AS B ON A.COD_SOLICITUD = B.codSolicitud 
				LEFT JOIN estado_asignacion AS C ON B.idasignacion = C.idasignacion
				WHERE B.codEnte = COD AND A.NIT_CLIENTE = NIT AND B.codTipo = 0
				ORDER BY COD_SOLICITUD ASC;
            END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarCreditos`$$
CREATE PROCEDURE `queryListarCreditos`(IN NIT CHAR(10))
BEGIN			
            IF NIT is null THEN
				SELECT A.COD_SOLICITUD, A.NIT_CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_MINIMO') AS RENTABILIDAD_MIN,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.UTILIDAD_ANUAL') AS UTILIDAD_ANUAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.POR_COSTO_INTEGRAL_Max') AS COSTO_INTEGRAL_MAX,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR') AS COD_PARAMETRIZADOR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoMonto') AS CUPO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoMonto') AS TESO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoPlazo') AS CUPO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoPlazo') AS TESO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoIBR') AS CUPO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoIBR') AS TESO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoCobertura') AS CUPO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoCobertura') AS TESO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.promedio') AS RECIPROCIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_ENTE_ATRIBUCION_FINAL[0].tipo_aprobador') AS CARGO_APRO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_PARAMETRIZADOR.CARGO') AS CARGO_PARA,
				if(B.estadoAprobacion is null, 'En Proceso', if(B.estadoAprobacion = 1, 'Aprobado', 'No Aprobado')) AS Aprobacion,
				if(B.estadoAprobacion = 1, 'Asignado', if(B.estadoParametrizacion = 0, 'No Aprobado', if(B.estadoParametrizacion = 1, 'Aprobado', 'No Asignado'))) AS Parametrizacion
				FROM solicitudes AS A
				LEFT JOIN estado_solicitud AS B ON A.COD_SOLICITUD = codSolicitud
                ORDER BY COD_SOLICITUD ASC
                Limit 50;
            ELSE
				SELECT A.COD_SOLICITUD, A.NIT_CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_MINIMO') AS RENTABILIDAD_MIN,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.UTILIDAD_ANUAL') AS UTILIDAD_ANUAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.POR_COSTO_INTEGRAL_Max') AS COSTO_INTEGRAL_MAX,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR') AS COD_PARAMETRIZADOR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoMonto') AS CUPO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoMonto') AS TESO_MONTO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoPlazo') AS CUPO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoPlazo') AS TESO_PLAZO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoIBR') AS CUPO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoIBR') AS TESO_IBR,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.cupoCobertura') AS CUPO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.tesoCobertura') AS TESO_COBERTURA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.CREDITO_NUEVO.promedio') AS RECIPROCIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_ENTE_ATRIBUCION_FINAL[0].tipo_aprobador') AS CARGO_APRO,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.DATOS_PARAMETRIZADOR.CARGO') AS CARGO_PARA,
				if(B.estadoAprobacion is null, 'En Proceso', if(B.estadoAprobacion = 1, 'Aprobado', 'No Aprobado')) AS Aprobacion,
				if(B.estadoAprobacion = 1, 'Asignado', if(B.estadoParametrizacion = 0, 'No Aprobado', if(B.estadoParametrizacion = 1, 'Aprobado', 'No Asignado'))) AS Parametrizacion
				FROM solicitudes AS A
				LEFT JOIN estado_solicitud AS B ON A.COD_SOLICITUD = codSolicitud
				WHERE A.NIT_CLIENTE = NIT
				ORDER BY COD_SOLICITUD ASC;
            END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarEstado`$$
CREATE PROCEDURE `queryListarEstado`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'Estado';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarIbrsTipoCred`$$
CREATE  PROCEDURE `queryListarIbrsTipoCred`()
BEGIN
			SELECT A.COD_TIP_PROD, B.NOMBRE, json_arrayagg(A.cod_ibr) AS cod_ibr,
            json_arrayagg(C.ibr_descripcion) AS ibr_descripcion, json_arrayagg(E.cod_fech) AS cod_fech,
            json_arrayagg(E.valor_ibr) AS valor_ibr
			FROM tipoCredIbrState AS A
			JOIN tipo_producto AS B ON B.COD_TIP_PROD = A.COD_TIP_PROD
			JOIN ibr AS C ON C.cod_ibr = A.cod_ibr
			JOIN  ibr_control AS E ON A.cod_ibr = E.cod_ibr
			WHERE A.codEstado = 1 AND E.cod_fech = (SELECT cod_fech FROM ibr_control ORDER BY cod_fech DESC LIMIT 1)
			GROUP BY A.COD_TIP_PROD
			ORDER BY A.COD_TIP_PROD DESC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarPlanes`$$
CREATE PROCEDURE `queryListarPlanes`()
BEGIN
			SELECT A.plan AS codPlan, B.descripcionPlan AS plan, A.tipoPlan AS tipo, C.descripcion AS tipoPlan, MAX(A.tasaEA) AS tasaEA, A.estadoPlan
			FROM rangoPlanes AS A
			JOIN planes AS B ON A.plan = B.plan
			JOIN tipoPlan AS C ON C.codTipoPlan = A.tipoPlan
			WHERE estadoPlan = 1
			GROUP BY A.plan
			ORDER BY A.plan ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarPlanRem`$$
CREATE PROCEDURE `queryListarPlanRem`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'PlanRem';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarProducto`$$
CREATE PROCEDURE `queryListarProducto`()
BEGIN
			SELECT COD_TIP_PROD, NOMBRE FROM tipo_producto
            ORDER BY NOMBRE ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS  `queryListarReciprocidadMinima`$$
CREATE PROCEDURE `queryListarReciprocidadMinima`()
BEGIN
			SELECT A.idReciprocidadMinima, A.monto
			FROM reciprocidadMinima AS A;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarRedescuento`$$
CREATE PROCEDURE `queryListarRedescuento`()
BEGIN
			SELECT A.cod_redescuento, A.descripcion
			FROM entidadRedescuento AS A
			WHERE A.codEstado = 1;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarSiNo`$$
CREATE PROCEDURE `queryListarSiNo`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'SiNo';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarSolicitudes`$$
CREATE PROCEDURE `queryListarSolicitudes`(IN prUSU CHAR(15), prDESDE DATE, prHASTA DATE)
BEGIN		        
			SELECT A.COD_SOLICITUD,
				date_format(A.FECHA_HORA, '%d-%m-%Y') AS FECHA_HORA,
				(SELECT OFICINA FROM oficina WHERE COD_OFICINA = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.oficina') AS SIGNED)) AS OFICINA,
				(SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional') AS SIGNED)) AS REGIONAL,
				A.NIT_CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.TOTAL_PROMEDIO_COLOCA') AS TOTAL_CARTERA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.VALOR_CAPTACION_1') AS TOTAL_CAPTACION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
                if((if(B.estadoAprobacion = 1, 'Asignado', if(B.estadoParametrizacion = 0, 'No Aprobado', if(B.estadoParametrizacion = 1, 'Parametrizado', 'No Asignado')))) = 'No Asignado', 
					(SELECT tipo_aprobador 
						FROM tipo_aprobador 
                        WHERE cod_aprobador = (SELECT codTipo 
												FROM asignaciones 
                                                WHERE codSolicitud = A.COD_SOLICITUD 
                                                ORDER BY idasignacion 
                                                DESC LIMIT 1)), '--') AS codEnte,
				if(B.estadoAprobacion is null, 'En Proceso', if(B.estadoAprobacion = 1, 'Aprobado', 'No Aprobado')) AS Aprobacion,
				if(B.estadoAprobacion = 1 and B.estadoParametrizacion is null, 'Asignado', if(B.estadoParametrizacion = 0, 'No Aprobado', if(B.estadoParametrizacion = 1, 'Parametrizado', 'No Asignado'))) AS Parametrizacion,
				C.idasignacion
			FROM solicitudes AS A
			LEFT JOIN estado_solicitud AS B ON A.COD_SOLICITUD = B.codSolicitud
			JOIN asignaciones AS C ON A.COD_SOLICITUD = C.codSolicitud
            WHERE DATE(A.FECHA_HORA) BETWEEN prDESDE AND prHASTA
			GROUP BY COD_SOLICITUD
			ORDER BY COD_SOLICITUD ASC
			LIMIT 10000;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarTipoConvenio`$$
CREATE PROCEDURE `queryListarTipoConvenio`()
BEGIN
			SELECT COD_CONVENIO, NOMBRE FROM convenio;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarTipoCuenta`$$
CREATE PROCEDURE `queryListarTipoCuenta`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'TipoCuenta';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarTipoId`$$
CREATE PROCEDURE `queryListarTipoId`()
BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'TipoId';
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarTipoOperacion`$$
CREATE PROCEDURE `queryListarTipoOperacion`()
BEGIN
			SELECT COD_OPERACION, NOMBRE FROM operacion;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarTipoProducto`$$
CREATE PROCEDURE `queryListarTipoProducto`()
BEGIN
			SELECT COD_PRODUCTO, NOMBRE FROM producto;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarUltimaFecha`$$
CREATE PROCEDURE `queryListarUltimaFecha`()
BEGIN
    		SELECT cod_fech, 
				DATE_FORMAT((DATE_ADD(fech_hast, INTERVAL 1 DAY)),"%Y-%m-%d") AS fech_hast
			FROM ibr_fechas
			ORDER BY cod_fech DESC 
			LIMIT 1;
    	END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListarUsuario`$$
CREATE PROCEDURE `queryListarUsuario`()
BEGIN
    		SELECT A.USUARIO, A.NOMBRE, A.CORREO, D.CARGO,
			-- E.REGIONAL_RAD AS REGIONAL, 
            -- F.OFICINA, G.CANAL_RAD AS CANAL,
			(SELECT json_arrayagg(L.DESCRIPCION)
			FROM perfiles_usuario AS J
			JOIN usuario AS K ON J.USUARIO = K.USUARIO
			JOIN perfiles AS L ON J.COD_PERFIL = L.COD_PERFIL
			WHERE J.USUARIO = A.USUARIO) AS PERFIL,
			if(I.tipo_aprobador IS NULL, '--', I.tipo_aprobador) AS TIPO_APROBADOR,
            M.descripcion AS ESTADO
			FROM usuario AS A
			LEFT JOIN ente_aprobacion AS C ON C.USUARIO = A.USUARIO
			JOIN cargos AS D ON A.COD_CARGO = D.COD_CARGO
			JOIN regional AS E ON A.COD_REGIONAL = E.COD_REGIONAL_RAD
			LEFT JOIN oficina AS F ON A.COD_OFICINA = F.COD_OFICINA
			JOIN canal AS G ON A.COD_CANAL = G.COD_CANAL_RAD
			LEFT JOIN tipo_aprobador AS I ON C.COD_APROBADOR = I.cod_aprobador
            JOIN Listas AS M ON M.lista = 'Estado' AND M.codLista = A.ESTADO_USU;
    	END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryListConfigurarIbr`$$
CREATE PROCEDURE `queryListConfigurarIbr`()
BEGIN
    		SELECT 
				f.cod_fech AS dKey, 
				DATE_FORMAT(f.fech_inic, "%d-%m-%Y") AS fech_inic, 
				DATE_FORMAT(f.fech_hast, "%d-%m-%Y") AS fech_hast, 
				CONCAT(MAX(CASE WHEN c.cod_ibr = '0' THEN c.valor_ibr END), "%") AS ibr0, 
				CONCAT(MAX(CASE WHEN c.cod_ibr = '1' THEN c.valor_ibr END), "%") AS ibr1, 
				CONCAT(MAX(CASE WHEN c.cod_ibr = '3' THEN c.valor_ibr END), "%") AS ibr3, 
				CONCAT(MAX(CASE WHEN c.cod_ibr = '6' THEN c.valor_ibr END), "%") AS ibr6, 
				CONCAT(MAX(CASE WHEN c.cod_ibr = '12' THEN c.valor_ibr END), "%") AS ibr12
			FROM ibr_fechas f
			JOIN ibr_control c ON f.cod_fech = c.cod_fech
			WHERE f.fech_inic BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE()
			GROUP BY f.cod_fech, f.fech_inic, f.fech_hast
			ORDER BY f.cod_fech DESC;
    	END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryLoginUsuario`$$
CREATE PROCEDURE `queryLoginUsuario`(IN LOGIN VARCHAR(15))
BEGIN
			SELECT USU.USUARIO, USU.CORREO, PER.PERFIL, PRU.COD_PERFIL, USU.ESTADO_USU
			FROM usuario AS USU
			JOIN perfiles_usuario AS PRU ON USU.USUARIO = PRU.USUARIO
			JOIN perfiles AS PER ON PRU.COD_PERFIL = PER.COD_PERFIL
			WHERE USU.USUARIO = LOGIN;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryNegociarNomina`$$
CREATE PROCEDURE `queryNegociarNomina`()
BEGIN
			SELECT idnegociarNomina, pagoNomina, tarifaPlena, tarifaCosto, cantidad, permitirNegociar, formulaCalculo FROM negociarNomina;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryPagoTerseros`$$
CREATE PROCEDURE `queryPagoTerseros`()
BEGIN
			SELECT idpagoTerseros, pagoTerseros, tarifaPlena, tarifaCosto FROM pagoTerseros;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryParametrizador`$$
CREATE PROCEDURE `queryParametrizador`(IN USU CHAR(15))
BEGIN
			SELECT B.CORREO, C.CARGO
			FROM ente_parametrizacion AS A
			JOIN usuario AS B ON B.USUARIO = A.USUARIO
			JOIN cargos AS C ON C.COD_CARGO = B.COD_CARGO
			WHERE A.USUARIO = USU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryParametrizarCreditos`$$
CREATE PROCEDURE `queryParametrizarCreditos`(IN SOLICITUD INT, DECISION INT, USU CHAR(15))
BEGIN
            DECLARE ASIGNACION INT;
            DECLARE PARAMETRIZADOR CHAR(15);
            DECLARE TIPOENTE INT;
			
            SET ASIGNACION = (SELECT A.idasignacion FROM asignaciones AS A
								WHERE A.codSolicitud = SOLICITUD AND codTipo = 0
								ORDER BY idasignacion DESC Limit 1);
                                
			SET PARAMETRIZADOR = (SELECT A.codEnte FROM asignaciones AS A
									WHERE A.codSolicitud = SOLICITUD AND codTipo = 0
                                    ORDER BY idasignacion DESC Limit 1);
		
            SET TIPOENTE = (SELECT COD_PARAMETRIZADOR FROM ente_parametrizacion
							WHERE USUARIO = PARAMETRIZADOR);
            
            IF DECISION = 1 THEN
				-- ACTUALIZAR ASIGNACION
                UPDATE asignaciones
				SET codTipo = TIPOENTE
				WHERE idasignacion = ASIGNACION;
				-- ACTUALIZAR ESTADO_ASIGANACION;
                INSERT INTO estado_asignacion (idAsignacion, codDecision, codUsuario)
				VALUES (ASIGNACION, DECISION, USU);
                -- ACTUALIZAR ESTADO_SOLICITUD;
				UPDATE estado_solicitud
				SET estadoParametrizacion = DECISION, fechaParametrizacion = NOW()
				WHERE codSolicitud = SOLICITUD;
			END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryParametrosEfecty`$$
CREATE PROCEDURE `queryParametrosEfecty`()
BEGIN
			SELECT idParametrosEfecty, ParametrosEfecty FROM ParametrosEfecty;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `querypermitirNegociar`$$
CREATE PROCEDURE `querypermitirNegociar`()
BEGIN
			SELECT cod_permitir, descripcion FROM permitirNegociar;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryPlanRemuneracion`$$
CREATE PROCEDURE `queryPlanRemuneracion`()
BEGIN
			SELECT A.idplanRemuneracion, A.planRemuneracion, 
			A.rangoInferior, A.rangoMaximo, A.tasaEA
			FROM planRemuneracion AS A
            ORDER BY A.rangoInferior ASC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryPromedioNomina`$$
CREATE PROCEDURE `queryPromedioNomina`()
BEGIN
			SELECT idpromedioNomina, tipo FROM promedioNomina;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryRecaudoOficina`$$
CREATE PROCEDURE `queryRecaudoOficina`()
BEGIN
			SELECT idrecaudoOficina, tipoRecaudoOficina, tarifaPlena, tarifaCosto FROM recaudoOficina;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryRecaudoPse`$$
CREATE PROCEDURE `queryRecaudoPse`()
BEGIN
			SELECT idrecaudoPse, tipoRecaudoPse, tarifaPlena, tarifaCosto FROM recaudoPse;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryRegionalSegunOficina`$$
CREATE PROCEDURE `queryRegionalSegunOficina`(IN OFICINA INT)
BEGIN
			SELECT REGIONAL_RAD FROM regional
			WHERE COD_REGIONAL_RAD = (SELECT REGIONAL FROM oficina WHERE COD_OFICINA = OFICINA);
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryServiciosFinancieros`$$
CREATE PROCEDURE `queryServiciosFinancieros`()
BEGIN
			SELECT A.idFinanciero, A.servicio, A.tarifa,
            A.costo, A.obligatorio
			FROM financieros AS A;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `querySolicitudesPorAprobacion`$$
CREATE PROCEDURE `querySolicitudesPorAprobacion`(IN USU CHAR(15), prDESDE DATE, prHASTA DATE)
BEGIN			
            	SELECT A.COD_SOLICITUD,
                date_format(A.FECHA_HORA, '%d-%m-%Y') AS FECHA_HORA,
                (SELECT OFICINA FROM oficina WHERE COD_OFICINA = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.oficina') AS SIGNED)) AS OFICINA,
                (SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional') AS SIGNED)) AS REGIONAL,
				A.NIT_CLIENTE,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.TOTAL_PROMEDIO_COLOCA') AS TOTAL_CARTERA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.VALOR_CAPTACION_1') AS TOTAL_CAPTACION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
                (SELECT tipo_aprobador 
					FROM tipo_aprobador 
                    WHERE cod_aprobador= (SELECT codTipo 
											FROM asignaciones 
                                            WHERE codSolicitud = A.COD_SOLICITUD 
                                            ORDER BY idasignacion 
                                            DESC LIMIT 1)) AS codEnte,
                if(D.estadoAprobacion is null, 'En Proceso', if(D.estadoAprobacion = 1, 'Aprobado', 'No Aprobado')) AS Aprobacion,
				if(D.estadoAprobacion = 1 and D.estadoParametrizacion is null, 'Asignado', if(D.estadoParametrizacion = 0, 'No Aprobado', if(D.estadoParametrizacion = 1, 'Parametrizado', 'No Asignado'))) AS Parametrizacion,
				B.idasignacion
				FROM solicitudes AS A
				JOIN asignaciones AS B ON A.COD_SOLICITUD = B.codSolicitud 
				LEFT JOIN estado_asignacion AS C ON B.idasignacion = C.idasignacion
                LEFT JOIN estado_solicitud AS D ON A.COD_SOLICITUD = D.codSolicitud
				WHERE isnull(C.codDecision) AND B.codTipo = (SELECT COD_APROBADOR 
																FROM ente_aprobacion
                                                                WHERE USUARIO = USU) AND
				DATE(A.FECHA_HORA) BETWEEN prDESDE AND prHASTA
				ORDER BY COD_SOLICITUD ASC
                LIMIT 5000;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `querySolicitudesPorParametrizar`$$
CREATE PROCEDURE `querySolicitudesPorParametrizar`(IN USU CHAR(15), prDESDE DATE, prHASTA DATE)
BEGIN	
				SELECT A.COD_SOLICITUD,
                date_format(A.FECHA_HORA, '%d-%m-%Y') AS FECHA_HORA,
                (SELECT OFICINA FROM oficina WHERE COD_OFICINA = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.oficina') AS SIGNED)) AS OFICINA,
                (SELECT REGIONAL_RAD FROM regional WHERE COD_REGIONAL_RAD = CAST(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.regional') AS SIGNED)) AS REGIONAL,
				A.NIT_CLIENTE,
                JSON_EXTRACT(A.DATOS_SOLICITUD,'$.RADICACION.cliente') AS CLIENTE,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.TOTAL_PROMEDIO_COLOCA') AS TOTAL_CARTERA,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.VALOR_CAPTACION_1') AS TOTAL_CAPTACION,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_ROA_EA') AS RENTABILIDAD,
				JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PORC_COSTO_INTEGRAL') AS COSTO_INTEGRAL,
                if((if(D.estadoAprobacion = 1, 'Asignado', if(D.estadoParametrizacion = 0, 'No Aprobado', if(D.estadoParametrizacion = 1, 'Parametrizado', 'No Asignado')))) = 'No Asignado', (SELECT tipo_aprobador FROM tipo_aprobador WHERE cod_aprobador= (SELECT COD_APROBADOR FROM ente_aprobacion WHERE USUARIO = B.codEnte)), '--') AS codEnte,
                if(D.estadoAprobacion is null, 'En Proceso', if(D.estadoAprobacion = 1, 'Aprobado', 'No Aprobado')) AS Aprobacion,
				if(D.estadoAprobacion = 1 and D.estadoParametrizacion is null, 'Asignado', if(D.estadoParametrizacion = 0, 'No Aprobado', if(D.estadoParametrizacion = 1, 'Parametrizado', 'No Asignado'))) AS Parametrizacion,
				B.idasignacion
				FROM solicitudes AS A
				JOIN asignaciones AS B ON A.COD_SOLICITUD = B.codSolicitud 
				LEFT JOIN estado_asignacion AS C ON B.idasignacion = C.idasignacion
                LEFT JOIN estado_solicitud AS D ON A.COD_SOLICITUD = D.codSolicitud
				WHERE B.codEnte = USU AND B.codTipo = 0 AND D.estatusCorreo = 1 AND DATE(A.FECHA_HORA) BETWEEN prDESDE AND prHASTA
				ORDER BY COD_SOLICITUD ASC
                LIMIT 5000;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryTipoCredIbrState`$$
CREATE PROCEDURE `queryTipoCredIbrState`()
BEGIN
			SELECT A.COD_TIP_PROD, B.NOMBRE, A.cod_ibr, C.ibr_descripcion, A.codEstado, D.descripcion
			FROM tipoCredIbrState AS A
			JOIN tipo_producto AS B ON B.COD_TIP_PROD = A.COD_TIP_PROD
			JOIN ibr AS C ON C.cod_ibr = A.cod_ibr
			JOIN Listas AS D ON D.lista = 'SiNo' AND D.codLista = A.codEstado
            ORDER BY A.COD_TIP_PROD DESC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryTipoRedescuentoStatus`$$
CREATE PROCEDURE `queryTipoRedescuentoStatus`()
BEGIN
			SELECT A.cod_redescuento, A.descripcion, A.codEstado, B.descripcion AS descripcionEstado
			FROM entidadRedescuento AS A
			JOIN Listas AS B ON B.lista = 'SiNo' AND B.codLista = A.codEstado;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryUpdateEnte`$$
CREATE PROCEDURE `queryUpdateEnte`(IN COD INT, USU CHAR(15))
BEGIN
			UPDATE ente_aprobacion
            SET COD_APROBADOR = COD
            WHERE USUARIO = USU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryUsuario`$$
CREATE PROCEDURE `queryUsuario`(IN id CHAR(15))
BEGIN
    		SELECT U.USUARIO, U.NOMBRE, U.CORREO,
            U.COD_CARGO, U.COD_OFICINA, U.COD_REGIONAL, U.COD_CANAL,
    		P.COD_PERFIL, P.PERFIL, U.ESTADO_USU
    		FROM usuario U
    		JOIN perfiles_usuario PU ON U.USUARIO = PU.USUARIO
    		JOIN perfiles P ON PU.COD_PERFIL = P.COD_PERFIL
    		WHERE U.USUARIO = id;
    	END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryValidarEntes`$$
CREATE PROCEDURE `queryValidarEntes`(IN SOLICITUD INT)
BEGIN
            DECLARE APRO INT;
            DECLARE REQUERIDAS INT;
            DECLARE ENTE CHAR(15);
            DECLARE TIPOENTE INT;
            DECLARE ENTES_ATRIBUCION VARCHAR(30);
            DECLARE NAPRO INT;
            DECLARE PARAMETRIZADOR CHAR(15);
            DECLARE RADICADOR CHAR(15);
            
			SET APRO = (SELECT count(A.codSolicitud)
						FROM asignaciones AS A
						JOIN solicitudes AS B ON A.codSolicitud = B.COD_SOLICITUD
						JOIN estado_asignacion AS C ON C.idAsignacion = A.idasignacion
						WHERE A.codSolicitud = SOLICITUD AND codDecision = 1
						GROUP BY A.codSolicitud);
			
            SET APRO = (SELECT IFNULL(APRO, 0));
            
            SET ENTES_ATRIBUCION = (SELECT JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.ENTE_ATRIBUCION_FINAL') AS ENTE_ATRIBUCION
									FROM solicitudes AS A 
									WHERE COD_SOLICITUD = SOLICITUD);
                            
			SET REQUERIDAS = (SELECT JSON_LENGTH(ENTES_ATRIBUCION));
            
            SET PARAMETRIZADOR = (SELECT USUARIO AS COD_PARAMETRIZADOR FROM ente_parametrizacion WHERE USUARIO = (SELECT JSON_UNQUOTE(JSON_EXTRACT(A.DATOS_SOLICITUD,'$.KNIME.PARAMETRIZADOR'))
									FROM solicitudes AS A 
									WHERE COD_SOLICITUD = SOLICITUD));
                                    
			SET RADICADOR = (SELECT USUARIO FROM usuario 
								WHERE USUARIO = (SELECT ID_RADICADOR FROM solicitudes WHERE COD_SOLICITUD = SOLICITUD));
                                    
			IF (APRO + 1) < REQUERIDAS THEN
				-- VALIDAR APROBADOR;
                SET NAPRO = APRO + 1;
                SET TIPOENTE = (SELECT JSON_UNQUOTE(JSON_EXTRACT(ENTES_ATRIBUCION, CONCAT('$[', NAPRO, ']'))));
                SET ENTE = (SELECT USUARIO FROM ente_aprobacion WHERE COD_APROBADOR = TIPOENTE ORDER BY RAND() LIMIT 1);
                SELECT ENTE;
			ELSE
				-- VALIDAR PARAMETRIZADOR;
                SELECT PARAMETRIZADOR, RADICADOR;
			END IF;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `queryValidarSesion`$$
CREATE PROCEDURE `queryValidarSesion`(IN USU VARCHAR(15))
BEGIN
			SELECT A.ip_user
			FROM sessions AS A
			WHERE A.user_id = USU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateAdquirencia`$$
CREATE PROCEDURE `updateAdquirencia`(IN ID INT, PUNTO INT, COSTO INT, USU VARCHAR(45))
BEGIN
			UPDATE adquirencia AS A
			SET A.puntos = PUNTO, A.tarifaCosto = COSTO, A.cod_usu = USU
			WHERE A.idadquirencia = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateCorreoParametrizador`$$
CREATE PROCEDURE `updateCorreoParametrizador`(IN COD INT, ESTADO INT)
BEGIN
			UPDATE estado_solicitud
			SET estatusCorreo = ESTADO, fechaCorreo = now()
			WHERE codSolicitud = COD;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateCorresponsales`$$
CREATE PROCEDURE `updateCorresponsales`(IN ID INT, TPLENA DECIMAL(7,1), ESTADO INT, TICKET INT, USU VARCHAR(45))
BEGIN
			UPDATE corresponsales AS A
			SET A.tarifaPlena = TPLENA, A.estado = ESTADO, A.ticket_promedio = TICKET, A.cod_usu = USU
			WHERE A.idcorresponsales = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updatedDataFile`$$
CREATE PROCEDURE `updatedDataFile`(IN SOLI INT, CED VARCHAR(50), RUT VARCHAR(50), CER VARCHAR(50), FRM VARCHAR(50), CON VARCHAR(50), B6 VARCHAR(45), B7 VARCHAR(45), B8 VARCHAR(45), B9 VARCHAR(45), B10 VARCHAR(45), B11 VARCHAR(45), B12 VARCHAR(45), B13 VARCHAR(45), B14 VARCHAR(45), B15 VARCHAR(45), B16 VARCHAR(45), B17 VARCHAR(45), B18 VARCHAR(45), B19 VARCHAR(45), B20 VARCHAR(45), B21 VARCHAR(45), B22 VARCHAR(45), B23 VARCHAR(45), USU CHAR(15))
BEGIN
			UPDATE controlDocumentos
			SET docCedula = CED, docRut = RUT, docCertificado = CER, docFormato = FRM, docContrato = CON, docBuzon6 = B6, docBuzon7 = B7, docBuzon8 = B8, docBuzon9 = B9, docBuzon10 = B10, docBuzon11 = B11, docBuzon12 = B12, docBuzon13 = B13, docBuzon14 = B14, docBuzon15 = B15, docBuzon16 = B16, docBuzon17 = B17, docBuzon18 = B18, docBuzon19 = B19, docBuzon20 = B20, docBuzon21 = B21, docBuzon22 = B22, docBuzon23 = B23, cod_usu = USU
			WHERE cod_solicitud = SOLI;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateDocument`$$
CREATE PROCEDURE `updateDocument`(IN ID INT, PATHS VARCHAR(50), VALOR LONGTEXT)
BEGIN
			SET @CLAVE = CONCAT('$.', PATHS);
            UPDATE solicitudes AS A
			SET A.DATOS_SOLICITUD = JSON_SET(DATOS_SOLICITUD, @CLAVE, VALOR) 
			WHERE COD_SOLICITUD = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateEstadoUsuario`$$
CREATE PROCEDURE `updateEstadoUsuario`(IN pUSU VARCHAR(45), EDO INT, OBN VARCHAR(200), USU VARCHAR(15))
BEGIN
			UPDATE usuario AS U 
			SET U.ESTADO_USU = EDO, U.OBSERVACION = OBN, U.codUsu = USU
			WHERE U.USUARIO = pUSU;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateJustificacionOficina`$$
CREATE PROCEDURE `updateJustificacionOficina`(IN COD_JUST INT, TIPO VARCHAR(100), PERMITIR INT, PLENA DECIMAL(10,1), USU VARCHAR(45))
BEGIN
            UPDATE justificacionOficina AS A
			SET A.tipoJustificacionOfi = TIPO, A.permitirNegociar= PERMITIR, A.tarifaPlena = PLENA, A.cod_usu = USU
			WHERE A.idjustificacionOficina = COD_JUST;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateJustificacionPse`$$
CREATE PROCEDURE `updateJustificacionPse`(IN COD_JUST INT, TIPO VARCHAR(100), PERMITIR INT, PLENA DECIMAL(10,1), USU VARCHAR(45))
BEGIN
            UPDATE justificacionPse AS A
			SET A.tipoJustificacionPse = TIPO, A.permitirNegociar= PERMITIR, A.tarifaPlena = PLENA, A.cod_usu = USU
			WHERE A.idjustificacionPse = COD_JUST;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateNegociarNomina`$$
CREATE PROCEDURE `updateNegociarNomina`(IN TPLENA DECIMAL(7,1), TCOSTO DECIMAL(7,1), CANT DECIMAL(3,2), PNEGOCIAR INT, FCALCULO VARCHAR(60), ID INT, USU CHAR(15))
BEGIN
            UPDATE negociarNomina AS N	
			SET N.tarifaPlena = TPLENA, N.tarifaCosto = TCOSTO, N.cantidad = CANT, N.permitirNegociar = PNEGOCIAR, N.formulaCalculo = FCALCULO, N.usuario = USU
			WHERE N.idnegociarNomina = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updatePagoTerceros`$$
CREATE PROCEDURE `updatePagoTerceros`(IN TPLENA DECIMAL(7,1), TCOSTO DECIMAL(7,1), ID INT, USU CHAR(15))
BEGIN
            UPDATE pagoTerseros AS P 
			SET P.tarifaPlena = TPLENA, P.tarifaCosto = TCOSTO, P.usuario = USU
			WHERE P.idpagoTerseros = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateParametrosEfecty`$$
CREATE PROCEDURE `updateParametrosEfecty`(IN IDPARA INT, TIPO VARCHAR(45), USU CHAR(15))
BEGIN
			UPDATE ParametrosEfecty AS A
			SET A.ParametrosEfecty = TIPO, A.cod_usu = USU
			WHERE A.idParametrosEfecty = IDPARA;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updatePromedioNomina`$$
CREATE PROCEDURE `updatePromedioNomina`(IN IDPRO INT, TIPO VARCHAR(45), USU CHAR(15))
BEGIN
			UPDATE promedioNomina AS A
			SET A.tipo = TIPO, A.usuario = USU
			WHERE A.idpromedioNomina = IDPRO;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateRecaudoOficina`$$
CREATE PROCEDURE `updateRecaudoOficina`(IN TPLENA DECIMAL(7,1), TCOSTO DECIMAL(7,1), ID INT, USU VARCHAR(45))
BEGIN
			UPDATE recaudoOficina AS R 
			SET R.tarifaPlena = TPLENA, R.tarifaCosto = TCOSTO, R.cod_user = USU
			WHERE R.idrecaudoOficina = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateRecaudoPse`$$
CREATE PROCEDURE `updateRecaudoPse`(IN TPLENA DECIMAL(7,1), TCOSTO DECIMAL(7,1), ID INT, USU VARCHAR(45))
BEGIN
			UPDATE recaudoPse AS R 
			SET R.tarifaPlena = TPLENA, R.tarifaCosto = TCOSTO, R.cod_user = USU
			WHERE R.idrecaudoPse = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateReciprocidadMinima`$$
CREATE PROCEDURE `updateReciprocidadMinima`(IN IDREC INT, MONTO INT, USU CHAR(15))
BEGIN
			UPDATE reciprocidadMinima AS A
			SET A.monto = MONTO, A.codUsu = USU
			WHERE A.idReciprocidadMinima = IDREC;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateServiciosFinancieros`$$
CREATE PROCEDURE `updateServiciosFinancieros`(IN ID INT, TARIFA INT, COSTO INT, OBLI INT, USU VARCHAR(45))
BEGIN
            UPDATE financieros AS A
			SET A.tarifa = TARIFA, A.costo= COSTO, A.obligatorio = OBLI, A.cod_usu = USU
			WHERE A.idFinanciero = ID;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateTipoCredIbrState`$$
CREATE PROCEDURE `updateTipoCredIbrState`(IN TIP_PROD INT, IBR INT, ESTADO INT, USU CHAR(15))
BEGIN
			UPDATE tipoCredIbrState AS A 
			SET A.codEstado = ESTADO, A.codUsu = USU
			WHERE A.COD_TIP_PROD = TIP_PROD  AND  A.cod_ibr = IBR;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateTipoRedescuentoStatus`$$
CREATE PROCEDURE `updateTipoRedescuentoStatus`(IN CODRED INT, CODEST INT, USU CHAR(15))
BEGIN
			UPDATE entidadRedescuento
			SET codEstado = CODEST, CodUsu = USU
			WHERE cod_redescuento = CODRED;
		END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS `updateUsuario`$$
CREATE PROCEDURE `updateUsuario`(IN pUSU VARCHAR(45), CAR INT, OFI INT, REG INT, CAN INT, EDO INT, OBN VARCHAR(200), USU VARCHAR(15))
BEGIN
			UPDATE usuario AS U 
			SET U.COD_CARGO = CAR, U.COD_OFICINA = OFI, U.COD_REGIONAL = REG, U.COD_CANAL = CAN,
			U.ESTADO_USU = EDO, U.OBSERVACION = OBN, U.codUsu =  USU
			WHERE U.USUARIO = pUSU;
		END$$
DELIMITER ;

-- Trigger

DELIMITER $$
  DROP TRIGGER IF EXISTS `tr_update_perfil`$$
  CREATE TRIGGER tr_update_perfil
  AFTER DELETE ON perfiles_usuario
  FOR EACH ROW
  BEGIN
    INSERT INTO log_pricing 
    (ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
    VALUES
    ('3', 'DELETE PERFIL', OLD.USUARIO, 'COD_PERFIL', OLD.COD_PERFIL, NULL, 'Perfil Anterior');
  END$$
DELIMITER ;


DELIMITER $$
DROP TRIGGER IF EXISTS `tr_insert_usuarios`$$
CREATE TRIGGER tr_insert_usuarios
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
  INSERT INTO log_pricing (USUARIO, ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
  VALUES
  (NEW.codUsu, '1', 'INSERT USUARIO', NULL, 'NOMBRE', NULL, NEW.NOMBRE, NULL),
  (NEW.codUsu, '1', 'INSERT USUARIO', NULL, 'USUARIO', NULL, NEW.USUARIO, NEW.OBSERVACION),
  (NEW.codUsu, '1', 'INSERT USUARIO', NULL, 'CORREO', NULL, NEW.CORREO, NULL),
  (NEW.codUsu, '1', 'INSERT USUARIO', NULL, 'COD_OFICINA', NULL, NEW.COD_OFICINA, NULL),
  (NEW.codUsu, '1', 'INSERT USUARIO', NULL, 'COD_CANAL', NULL, NEW.COD_CANAL, NULL),
  (NEW.codUsu, '1', 'INSERT USUARIO', NULL, 'COD_REGIONAL', NULL, NEW.COD_REGIONAL, NULL),
  (NEW.codUsu, '1', 'INSERT USUARIO', NULL, 'COD_CARGO', NULL, NEW.COD_CARGO, NULL);
END$$
DELIMITER ;


DELIMITER $$
  DROP TRIGGER IF EXISTS `tr_insert_perfil`$$
  CREATE TRIGGER tr_insert_perfil
  AFTER INSERT ON perfiles_usuario
  FOR EACH ROW
  BEGIN
    INSERT INTO log_pricing (USUARIO, ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
    VALUES
    (NEW.codUsu, '1', 'INSERT PERFIL', NEW.USUARIO, 'COD_PERFIL', NULL, NEW.COD_PERFIL, 'Perfil Nuevo');
  END$$
DELIMITER ;


DELIMITER $$
DROP TRIGGER IF EXISTS `tr_actualizar_usuarios`$$
CREATE TRIGGER tr_actualizar_usuarios
AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
  IF NOT OLD.COD_OFICINA <=> NEW.COD_OFICINA THEN
    INSERT INTO log_pricing (USUARIO, ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
    VALUES (NEW.codUsu, '3', 'UPDATE USUARIO', OLD.USUARIO, 'COD_OFICINA', OLD.COD_OFICINA, NEW.COD_OFICINA, NULL);
  END IF;

  IF NOT OLD.COD_CANAL <=> NEW.COD_CANAL THEN
    INSERT INTO log_pricing (USUARIO, ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
    VALUES (NEW.codUsu, '3', 'UPDATE USUARIO', OLD.USUARIO, 'COD_CANAL', OLD.COD_CANAL, NEW.COD_CANAL, NULL);
  END IF;

  IF NOT OLD.COD_REGIONAL <=> NEW.COD_REGIONAL THEN
    INSERT INTO log_pricing (USUARIO, ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
    VALUES (NEW.codUsu, '3', 'UPDATE USUARIO', OLD.USUARIO, 'COD_REGIONAL', OLD.COD_REGIONAL, NEW.COD_REGIONAL, NULL);
  END IF;

  IF NOT OLD.COD_CARGO <=> NEW.COD_CARGO THEN
    INSERT INTO log_pricing (USUARIO, ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
    VALUES (NEW.codUsu, '3', 'UPDATE USUARIO', OLD.USUARIO, 'COD_CARGO', OLD.COD_CARGO, NEW.COD_CARGO, NULL);
  END IF;

  IF NOT OLD.ESTADO_USU <=> NEW.ESTADO_USU THEN
    INSERT INTO log_pricing (USUARIO, ACCION, EVENTO, REGISTRO_MODIFICADO, CAMPO_MODIFICADO, DATA_ACTUAL, DATA_NUEVA, OBSERVACION)
    VALUES 
    (NEW.codUsu, 
    CASE
      WHEN NEW.ESTADO_USU = '1' THEN '1'
      WHEN NEW.ESTADO_USU = '2' THEN '2'
      WHEN NEW.ESTADO_USU = '0' THEN '0'
      ELSE '3'
    END,
    'UPDATE ESTADO', 
    OLD.USUARIO, 'ESTADO_USU', OLD.ESTADO_USU, NEW.ESTADO_USU, NEW.OBSERVACION);
  END IF;
END$$
DELIMITER ;