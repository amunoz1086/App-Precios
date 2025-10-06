DELIMITER $$
	CREATE PROCEDURE insertPerfilUsuario (IN PER INT, USU VARCHAR(15), CUSU VARCHAR(15))
		BEGIN
			INSERT INTO perfiles_usuario (COD_PERFIL, USUARIO, codUsu)
			VALUES(PER, USU, CUSU);
		END$$
DELIMITER ;

DROP PROCEDURE insertPerfilUsuario;
CALL insertPerfilUsuario('1', 'usu1040');
SELECT * FROM perfiles_usuario