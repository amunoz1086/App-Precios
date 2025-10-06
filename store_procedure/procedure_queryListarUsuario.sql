DELIMITER $$
	CREATE PROCEDURE queryListarUsuario ()
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
DROP PROCEDURE queryListarUsuario;
CALL queryListarUsuario();