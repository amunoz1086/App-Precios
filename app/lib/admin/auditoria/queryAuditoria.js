'use server';

import { pool } from '../../../../config/conectPRICINGDB';

export const fnQueryAuditoria = async (res) => {
    const { usuario, accion, desde, hasta } = JSON.parse(res)
    const sqlString = `CALL queryAuditoria(?, ?, ?, ?)`;
    let auditoria = {};

    try {
        const [rows] = await pool.query(sqlString, [usuario, accion, desde, hasta]);
        auditoria.status = 200;
        auditoria.data = rows[0];
        return JSON.stringify(auditoria);
    } catch (error) {
        console.log(error);
        auditoria.status = 500;
        return JSON.stringify(auditoria);
    };
};