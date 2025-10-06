-- stored procedure perfil consulta queryListarSolicitudes
DELIMITER $$
	CREATE PROCEDURE queryListarSolicitudes()
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
			GROUP BY COD_SOLICITUD
			ORDER BY COD_SOLICITUD ASC
			LIMIT 1000;
		END$$
DELIMITER ;

DROP PROCEDURE queryListarSolicitudes;
CALL queryListarSolicitudes();


-- new
DELIMITER $$
	DROP PROCEDURE IF EXISTS queryListarSolicitudes;
	CREATE PROCEDURE queryListarSolicitudes(IN prUSU CHAR(15), prDESDE DATE, prHASTA DATE)
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





















				