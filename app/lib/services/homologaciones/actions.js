'use server'

const resHomologarOficinas = require("@/app/lib/services/homologaciones/fn_restHomologacionOficinas");

export const fnHomologarOficinas = async (dataReques) => {

    const { oficina } = JSON.parse(dataReques);
    let resDataRaw = {};

    try {
        const rawData = await resHomologarOficinas.fn_restHomologacionOficinas(JSON.stringify({ oficina: oficina }));
        resDataRaw.state = 200;
        resDataRaw.data = JSON.parse(rawData);
        return JSON.stringify(resDataRaw);

    } catch (e) {
        console.error(e);
        return JSON.stringify(e);
    };
};