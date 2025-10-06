DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_responsables_faltantes;
CREATE PROCEDURE actualizar_responsables_faltantes()
BEGIN
  UPDATE log_pricing A
  JOIN (
    SELECT USUARIO AS REGISTRO_MODIFICADO, MAX(fech_actualizacion) AS fech
    FROM perfiles_usuario
    GROUP BY USUARIO
  ) X 
  ON A.REGISTRO_MODIFICADO = X.REGISTRO_MODIFICADO
  JOIN perfiles_usuario PU 
  ON PU.USUARIO = X.REGISTRO_MODIFICADO AND PU.fech_actualizacion = X.fech
  SET A.USUARIO = PU.codUsu
  WHERE (A.USUARIO IS NULL OR A.USUARIO = '')
    AND A.EVENTO = 'DELETE PERFIL';
END$$
DELIMITER ;

CALL actualizar_responsables_faltantes();