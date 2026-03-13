/**
 * fn_restConsultarCatalogos.js
 * ----------------------------
 * Servicio para consultar catálogos generales.
 * Refactorizado para usar sharedRest.js (soporta OAUTH_ENABLED y switch de protocolo).
 */

const sharedRest = require('../sharedRest');

/**
 * fn_restConsultarCatalogos()
 * Llama al servicio de consulta de catálogos.
 */
async function fn_restConsultarCatalogos(dataReques) {
    const { catalogo } = JSON.parse(dataReques);

    const host = process.env.URL_HOST_CATALOGO;
    const port = process.env.URL_PORT_CATALOGO;
    const path = process.env.URL_PATH_CATALOGO;

    const token = await sharedRest.getAccessToken();
    const payload = {
        header: await sharedRest.commonHeader({
            useUUID: true,
            requestType: 'transfer'
        }),
        metadata: sharedRest.commonMetadata(),
        deviceContext: await sharedRest.commonDeviceContext(),
        operationData: {
            catalog: `${catalogo.trim()}`
        }
    };

    let response_json_data = {};

    try {
        const result = await sharedRest.postJson(host, port, path, payload, token, 'ConsultarCatalogos');

        response_json_data.status = 200; // Asumimos 200 si postJson no falló
        response_json_data.data = result.operationData.catalogs;

        return JSON.stringify(response_json_data);

    } catch (error) {
        console.error(`❌ Error al consultar catálogo ${catalogo.trim()}:`, error.message);
        // En el original el catch no relanzaba pero devolvía undefined implícitamente o logueaba. 
        // Mantengo el log pero relanzo para coherencia con el wrapper.
        throw error;
    }
}

module.exports = {
    "fn_restConsultarCatalogos": fn_restConsultarCatalogos,
};