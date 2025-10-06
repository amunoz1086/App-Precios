-- NEW
DELIMITER $$
DROP PROCEDURE IF EXISTS queryAuditoria;
CREATE PROCEDURE queryAuditoria (
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

CALL queryAuditoria('MAPO1982', 2, '2025-06-13', '2025-06-13');

