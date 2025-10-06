'use server';

/* MP: función para la eliminacion de usuarios */

import { pool } from '../../../../config/conectPRICINGDB';
import { getSession } from "../../auth/auth";

export const fnDeleteUsuarios = async (req) => {
    // const sqlString = `CALL deleteUsuario(?)`;

    const { idUsuario, observacion } = JSON.parse(req);
    const usuario = (await getSession()).userBACK.user;
    const sqlString = `CALL updateEstadoUsuario(?, ?, ?, ?)`

    try {
        const [rows] = await pool.query(sqlString, [idUsuario, 0, observacion, usuario]);
        return JSON.stringify(200)
    } catch (error) {
        console.log(error);
        return JSON.stringify(error);
    }

};