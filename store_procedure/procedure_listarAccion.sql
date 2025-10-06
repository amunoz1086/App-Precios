-- stored procedure listar Accion
DELIMITER $$
	DROP PROCEDURE IF EXISTS listarAccion;
	CREATE PROCEDURE listarAccion()
		BEGIN
			SELECT codLista, descripcion FROM Listas
			WHERE lista = 'Accion';
		END$$
DELIMITER ;
CALL listarAccion()