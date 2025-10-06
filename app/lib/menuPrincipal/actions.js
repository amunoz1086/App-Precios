'use server'

import { pool } from "@/config/conectPRICINGDB";


export const fnQueryListarRegional = async () => {

    const listadoRegional = {};
    const sqlString = `CALL listarRegional()`;

    try {

        const [rows] = await pool.query(sqlString);

        listadoRegional.state = true;
        listadoRegional.message = `200`;
        listadoRegional.regional = rows[0];
        return JSON.stringify(listadoRegional);

    } catch (e) {

        // console.error(e);
        listadoRegional.STATUS = 500;
        listadoRegional.CODE = e?.code;
        listadoRegional.MESSAGE = e?.sqlMessage;
        return JSON.stringify(listadoRegional);
    };
};

export const fnQueryListarOficinas = async () => {

    const listadoOficinas = {};
    const sqlString = `CALL listarOficinas()`;

    try {

        const [rows] = await pool.query(sqlString);

        listadoOficinas.state = true;
        listadoOficinas.message = `200`;
        listadoOficinas.oficinas = rows[0];

        //  listadoOficinas.oficinas =  rows[0].filter(o => o.REGIONAL == idRegion)
        return JSON.stringify(listadoOficinas);

    } catch (e) {
        console.error(e);
        return JSON.stringify(e);
    };
};

export const fnQueryListarVinculo = async () => {

    const sqlString = `CALL queryListarSiNo()`;
    let responsServer = {};

    try {
        const [rows] = await pool.query(sqlString);

        if (rows[0].length === 0) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = rows[0];
            return JSON.stringify(responsServer);
        }

    } catch (error) {
        responsServer.STATUS = 500;
        responsServer.CODE = error.code;
        responsServer.MESSAGE = error.sqlMessage;
        return JSON.stringify(responsServer);
    };
};

export const queryListarTipoContrato = async () => {

    const sqlString = `CALL listarTipoContrato()`;
    let responsServer = {};

    try {
        const [rows] = await pool.query(sqlString);

        if (rows[0].length === 0) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = rows[0];
            return JSON.stringify(responsServer);
        }

    } catch (error) {
        responsServer.STATUS = 500;
        responsServer.CODE = error.code;
        responsServer.MESSAGE = error.sqlMessage;
        return JSON.stringify(responsServer);
    };
};

export const queryListarTipoCliente = async () => {

    const sqlString = `CALL listarTipoCliente()`;
    let responsServer = {};

    try {
        const [rows] = await pool.query(sqlString);

        if (rows[0].length === 0) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = rows[0];
            return JSON.stringify(responsServer);
        }

    } catch (error) {
        console.log('Error:', error.sqlMessage)
        responsServer.STATUS = 500;
        responsServer.CODE = error.code;
        responsServer.MESSAGE = error.sqlMessage;
        return JSON.stringify(responsServer);
    };
};

export const querylistarSector = async () => {

    const sqlString = `CALL listarSector()`;
    let responsServer = {};

    try {
        const [rows] = await pool.query(sqlString);

        if (rows[0].length === 0) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = rows[0];
            return JSON.stringify(responsServer);
        }

    } catch (error) {
        responsServer.STATUS = 500;
        responsServer.CODE = error.code;
        responsServer.MESSAGE = error.sqlMessage;
        return JSON.stringify(responsServer);
    };
};


export const queryListarEstadoBanco = async (req, res,) => {

    const sqlString = `CALL listarEstadoBanco()`;
    let responsServer = {};

    try {
        const [rows] = await pool.query(sqlString);

        if (rows[0].length === 0) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = rows[0];
            return JSON.stringify(responsServer);
        }

    } catch (error) {
        console.log(error);
        responsServer.STATUS = 500;
        responsServer.CODE = error.code;
        responsServer.MESSAGE = error.sqlMessage;
        return JSON.stringify(responsServer);
    };
};

export const queryListarEstadoCoomeva = async () => {

    const sqlString = `CALL listarEstadoCoomeva()`;
    let responsServer = {};

    try {
        const [rows] = await pool.query(sqlString);

        if (rows[0].length === 0) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = rows[0];
            return JSON.stringify(responsServer);
        }

    } catch (error) {
        responsServer.STATUS = 500;
        responsServer.CODE = error.code;
        responsServer.MESSAGE = error.sqlMessage;
        return JSON.stringify(responsServer);
    };
};

export const queryListarAsocCoomeva = async () => {

    const sqlString = `CALL listarAsocCoomeva()`;
    let responsServer = {};

    try {
        const [rows] = await pool.query(sqlString);

        if (rows[0].length === 0) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = rows[0];
            return JSON.stringify(responsServer);
        }

    } catch (error) {
        responsServer.STATUS = 500;
        responsServer.CODE = error.code;
        responsServer.MESSAGE = error.sqlMessage;
        return JSON.stringify(responsServer);
    };
};

export const fnQueryBuscarRegional = async (codRegional) => {

    const listadoRegional = {};
    const sqlString = `CALL buscarRegional(?)`;

    try {

        const [rows] = await pool.query(sqlString, [codRegional]);

        listadoRegional.state = true;
        listadoRegional.message = `200`;
        listadoRegional.regional = rows[0];
        return JSON.stringify(listadoRegional);

    } catch (e) {
        console.error(e);
        return JSON.stringify(e);
    };
};