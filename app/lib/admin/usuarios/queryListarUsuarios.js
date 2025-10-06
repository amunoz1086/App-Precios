'use server';

/* MP: función para la consulta de usuarios */

import { pool } from '../../../../config/conectPRICINGDB';

export const fnQueryListarUsuarios = async () => {

    const sqlString = `CALL queryListarUsuario()`;
    let listaUsuarios = {};

    try {
        const [rows] = await pool.query(sqlString);
        listaUsuarios.status = 200;
        listaUsuarios.data = rows[0];
        return JSON.stringify(listaUsuarios);
    } catch (error) {
        console.log(error);
        listaUsuarios.status = 500;
        return JSON.stringify(listaUsuarios);
    };
};