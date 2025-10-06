"use server";

import { pool } from '../../../config/conectPRICINGDB';
import { getSession } from "../auth/auth";
import { obtenerCookiePerfil } from "@/app/lib/auth/auth";


export const queryListarSolicitudes = async (data) => {

    const { dateDesde, dateHasta } = JSON.parse(data);

    const PERFILACTIVO = await obtenerCookiePerfil();
    const USUARIO = (await getSession()).userBACK.user;


    if (PERFILACTIVO.value === 'Aprobación') {
        const sqlStringAprobador = `CALL querySolicitudesPorAprobacion(?, ?, ?)`;
        let response = await request(sqlStringAprobador, USUARIO, 3, dateDesde, dateHasta); //codigo perfil
        return JSON.stringify(response);
    };

    if (PERFILACTIVO.value === 'Parametrización') {
        const sqlStringParametrizador = `CALL querySolicitudesPorParametrizar(?, ?, ?)`;
        let response = await request(sqlStringParametrizador, USUARIO, 4, dateDesde, dateHasta); //codigo perfil
        return JSON.stringify(response);
    };

    if (PERFILACTIVO.value === 'Consulta') {
        const sqlStringConsulta = `CALL queryListarSolicitudes(?, ?, ?)`;
        let response = await request(sqlStringConsulta, USUARIO, 5, dateDesde, dateHasta); //codigo perfil
        return JSON.stringify(response);
    };

    if (PERFILACTIVO.value === 'Radicación') {
        const sqlStringConsulta = `CALL queryListarSolicitudes(?, ?, ?)`;
        let response = await request(sqlStringConsulta, USUARIO, 2, dateDesde, dateHasta); //codigo perfil
        return JSON.stringify(response);
    };

};


async function request(sqlString, USU, codPerfil, prDesde, prHasta) {

    let resDataSolicitud = {};

    console.log(prDesde, prHasta)

    try {
        const [rows] = await pool.query(sqlString, [USU, prDesde, prHasta]);

        if (rows[0].length > 0) {
            resDataSolicitud.STATUS = true;
            resDataSolicitud.MESSAGE = 'Listado generado';
            resDataSolicitud.DATA = JSON.stringify(rows[0]);
            return (resDataSolicitud);

        } else {
            resDataSolicitud.STATUS = false;
            if (codPerfil === 5 || codPerfil === 2) {
                resDataSolicitud.MESSAGE = '¡Sin solicitudes para Mostrar!';
            } else {
                resDataSolicitud.MESSAGE = '¡Sin solicitudes por Aprobar!';
            }

            return (resDataSolicitud);
        };

    } catch (error) {
        console.log(error);
        resDataSolicitud.STATUS = false;
        resDataSolicitud.MESSAGE = `No fue posible generar el listado de solicitudes: ${error.code}`;
        resDataSolicitud.ERROR = error;
        return (resDataSolicitud);
    };
};