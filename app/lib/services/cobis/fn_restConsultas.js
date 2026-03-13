/**
 * fn_restConsultas.js
 * -------------------
 * Wrapper centralizado de llamadas salientes a las APIs de negocio (COBIS/BUC).
 * Refactorizado para usar sharedRest.js
 */

const sharedRest = require('../sharedRest');

/**
 * fn_restConsultarCliente()
 * Llama al endpoint BUC consulta única de datos del cliente.
 */
async function fn_restConsultarCliente(dataRequest) {
    const { identification, identificationType, customerType } =
        typeof dataRequest === 'string' ? JSON.parse(dataRequest) : dataRequest;

    const host = process.env.URL_HOST_CONSULTA_UNICA_DATOS_CLIENTE;
    const port = process.env.URL_PORT_CONSULTA_UNICA_DATOS_CLIENTE;
    const path = process.env.URL_PATH_CONSULTA_UNICA_DATOS_CLIENTE;

    const token = await sharedRest.getAccessToken();
    const payload = {
        header: await sharedRest.commonHeader(),
        metadata: sharedRest.commonMetadata(),
        deviceContext: await sharedRest.commonDeviceContext(),
        operationData: {
            PartyIdentification: {
                PartyIdentification: {
                    Identification: identification,
                    PartyIdentificationType: { Code: identificationType },
                },
            },
            CustomerType: customerType,
        },
    };

    let response_json_data = {};

    try {
        const resConsultaCliente = {
            status: 200,
            data: await sharedRest.postJson(host, port, path, payload, token, 'ConsultaUnicaDatosCliente'),
        };
        return JSON.stringify(resConsultaCliente);
    } catch (err) {
        const rawStatus = /Status\s+(\d+)/.exec(err.message);
        const status = rawStatus ? rawStatus[1] : null;
        const rawMessage = /^Status \d+:\s*\{/.test(err.message)
            ? JSON.parse(err.message.replace(/^Status \d+:\s*/, ''))
            : null;
        const message = rawMessage?.message ?? null;

        if (+status === 400) {
            response_json_data.data = { status: +status, message: `${message}` };
        } else {
            console.error('[fn_restConsultarCliente] Error:', err.message);
            response_json_data.data = {
                status: +status,
                message: `Code: ${status} - ${message}`,
            };
        }
        return JSON.stringify(response_json_data);
    }
}

/**
 * fn_restConsultarCuentas()
 * Llama al endpoint SavingsAccount para obtener cuentas del cliente.
 */
async function fn_restConsultarCuentas(dataRequest) {
    const { identification, identificationType } =
        typeof dataRequest === 'string' ? JSON.parse(dataRequest) : dataRequest;

    const host = process.env.URL_HOST_CUENTA_SOBREGIRO;
    const port = process.env.URL_PORT_CUENTA_SOBREGIRO;
    const path = process.env.URL_PATH_CUENTA_SOBREGIRO;

    const token = await sharedRest.getAccessToken();
    const payload = {
        header: await sharedRest.commonHeader(),
        metadata: sharedRest.commonMetadata(),
        deviceContext: await sharedRest.commonDeviceContext(),
        operationData: {
            CustomerReference: {
                PartyIdentification: {
                    IdentificationType: { Code: identificationType },
                    Identification: identification,
                },
            },
            Pagination: { PageNumber: 1, Size: 100 },
        },
    };

    let response_json_data = {};

    try {
        const resConsultaCuentas = {
            status: 200,
            data: await sharedRest.postJson(host, port, path, payload, token, 'ConsultarCuentas'),
        };
        return JSON.stringify(resConsultaCuentas);
    } catch (err) {
        const rawStatus = /Status\s+(\d+)/.exec(err.message);
        const status = rawStatus ? rawStatus[1] : null;
        const rawMessage = /^Status \d+:\s*\{/.test(err.message)
            ? JSON.parse(err.message.replace(/^Status \d+:\s*/, ''))
            : null;
        const message = rawMessage?.message ?? null;

        if (+status === 400) {
            response_json_data.data = { status: +status, message: `${message}` };
        } else {
            console.error('[fn_restConsultarCuentas] Error:', err.message);
            response_json_data.data = {
                status: +status,
                message: `Code: ${status} - ${message}`,
            };
        }
        return JSON.stringify(response_json_data);
    }
}

module.exports = { fn_restConsultarCliente, fn_restConsultarCuentas };