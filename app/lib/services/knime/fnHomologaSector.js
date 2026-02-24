"use server";

import { pool } from '../../../../config/conectPRICINGDB';

export const fnHomologaSector = async (code) => {

    const sqlString = `CALL queryHomologaSector(?)`;
    const responseSector = {};

    try {
        const [rows] = await pool.query(sqlString, [code]);
        responseSector.state = 200;
        responseSector.code = rows[0];
        return JSON.stringify(responseSector);

    } catch (e) {
        console.error(e);
        return JSON.stringify({ e });
    };
};