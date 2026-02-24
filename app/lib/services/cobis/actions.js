'use server'

import { pool } from "@/config/conectPRICINGDB";

export const fnQueryFiltroCuentas = async () => {

    const tipoCuenta = {};
    const sqlString = `CALL queryFiltrarCuentas()`;

    try {

        const [rows] = await pool.query(sqlString, []);
        const rawData = rows[0];
        let codTipo = [];
        
        for (const i of rawData) {
            codTipo.push(i.tipo);
        };

        tipoCuenta.state = 200;
        tipoCuenta.data = codTipo;
        return JSON.stringify(tipoCuenta);

    } catch (e) {
        console.error(e);
        return JSON.stringify(e);
    };
};