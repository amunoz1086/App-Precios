-- stored procedure insert Ente Parametrizador
DELIMITER $$
	CREATE PROCEDURE insertEnteParametrizador (IN USU CHAR(15))
		BEGIN
			INSERT INTO ente_parametrizacion (USUARIO)
			VALUES(USU);
		END$$
DELIMITER ;

DROP PROCEDURE insertEnteParametrizador;
CALL insertEnteParametrizador(?);
CALL insertEnteParametrizador('ente11')