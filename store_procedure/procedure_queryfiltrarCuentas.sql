DELIMITER $$
	DROP PROCEDURE IF EXISTS queryFiltrarCuentas $$
	CREATE PROCEDURE queryFiltrarCuentas()
		BEGIN	
			SELECT 
				tipo
			FROM filtroCuentas;
		END$$       	
DELIMITER ;

CALL queryFiltrarCuentas();