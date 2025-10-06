-- stored procedure querySolicitudesPorParametrizar
DELIMITER $$
	CREATE PROCEDURE querySolicitudesPorParametrizar(IN USU CHAR(15))
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
				WHERE B.codEnte = USU AND B.codTipo = 0 AND D.estatusCorreo = 1
				ORDER BY COD_SOLICITUD ASC;
		END$$
DELIMITER ;

DROP PROCEDURE querySolicitudesPorParametrizar;
CALL querySolicitudesPorParametrizar(?);
CALL querySolicitudesPorParametrizar('jcib5894');


/* new */
DELIMITER $$
	DROP PROCEDURE IF EXISTS querySolicitudesPorParametrizar;
	CREATE PROCEDURE querySolicitudesPorParametrizar(IN USU CHAR(15), prDESDE DATE, prHASTA DATE)
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
CALL querySolicitudesPorParametrizar('jcib5894', '2025-01-06', '2025-06-20');