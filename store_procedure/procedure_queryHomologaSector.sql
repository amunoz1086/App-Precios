DELIMITER $$
	DROP PROCEDURE IF EXISTS queryHomologaSector $$
	CREATE PROCEDURE queryHomologaSector(IN pSECTOR CHAR(2))
		BEGIN	
			SELECT
				code
			FROM homologaSector
			WHERE codeCobis = pSECTOR;
		END$$       	
DELIMITER ;

CALL queryHomologaSector('F');