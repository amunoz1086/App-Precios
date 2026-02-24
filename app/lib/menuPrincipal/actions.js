'use server'

import { pool } from "@/config/conectPRICINGDB";
const restConsultarCatalogos = require("@/app/lib/services/catalogos/fn_restConsultarCatalogos");


export const fnQueryListarRegional = async () => {

    const listadoRegional = {};

    try {
        const rows = await restConsultarCatalogos.fn_restConsultarCatalogos(JSON.stringify({ catalogo: 'cl_oficina' }));
        let parsedRows = {};

        if (typeof (rows) === 'string' && rows.length > 0) {
            parsedRows = JSON.parse(rows);
        } else {
            throw (new Error("No fue posible serializar los datos del catalogo"));
        };

        if (+parsedRows.status === 200) {
            const regionalesCode = new Set(['1', '2', '3', '4', '5', '6', '17']);
            listadoRegional.regional = parsedRows.data.filter(regional => regionalesCode.has(regional.code));
            listadoRegional.oficinas = parsedRows.data.filter(oficina => !regionalesCode.has(oficina.code));
        };

        listadoRegional.state = true;
        listadoRegional.message = `200`;
        return JSON.stringify(listadoRegional);

    } catch (e) {
        listadoRegional.STATUS = 500;
        listadoRegional.CODE = e?.code;
        listadoRegional.MESSAGE = e?.sqlMessage;
        return JSON.stringify(listadoRegional);
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

    let responsServer = {};

    try {
        const rows = await restConsultarCatalogos.fn_restConsultarCatalogos(JSON.stringify({ catalogo: 'cl_sector_economico' }));
        let parsedRows = {};

        if (typeof (rows) === 'string' && rows.length > 0) {
            parsedRows = JSON.parse(rows);
        } else {
            throw (new Error("No fue posible serializar los datos del catalogo"));
        };

        if (+parsedRows.status !== 200) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);
        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = parsedRows.data;
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

    let responsServer = {};

    try {
        const rows = await restConsultarCatalogos.fn_restConsultarCatalogos(JSON.stringify({ catalogo: 'cl_tip_cliente' }));
        let parsedRows = {};

        if (typeof (rows) === 'string' && rows.length > 0) {
            parsedRows = JSON.parse(rows);
        } else {
            throw (new Error("No fue posible serializar los datos del catalogo"));
        };

        if (+parsedRows.status !== 200) {
            responsServer.STATUS = 202;
            responsServer.MESSAGE = 'Entidad sin registros';
            return JSON.stringify(responsServer);

        } else {
            responsServer.STATUS = 200;
            responsServer.DATA = parsedRows.data;
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