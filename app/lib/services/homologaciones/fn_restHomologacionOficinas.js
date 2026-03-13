/**
 * fn_restHomologacionOficinas.js
 * ------------------------------
 * Servicio para homologar oficinas cobis.
 * Refactorizado para usar sharedRest.js (soporta OAUTH_ENABLED y switch de protocolo).
 */

const sharedRest = require('../sharedRest');

/**
 * fn_restHomologacionOficinas()
 * Llama al servicio de homologación de oficinas.
 */
async function fn_restHomologacionOficinas(dataReques) {
    const { oficina } = JSON.parse(dataReques);

    const host = process.env.URL_HOST_OFICINA_HOMOLOGADA;
    const port = process.env.URL_PORT_OFICINA_HOMOLOGADA;
    const path = process.env.URL_PATH_OFICINA_HOMOLOGADA;
    const CAT_HOMOLOGADO = process.env.CATALOGO_HOMOLOGADO;

    const token = await sharedRest.getAccessToken();
    const payload = {
        header: await sharedRest.commonHeader({
            useUUID: true,
            requestType: 'transfer'
        }),
        metadata: sharedRest.commonMetadata(),
        deviceContext: await sharedRest.commonDeviceContext(),
        operationData: {
            RedisStore: {
                Reference: {
                    Text: `${CAT_HOMOLOGADO}`
                },
                SelectionKey: {
                    Text: `${oficina},P`
                }
            }
        }
    };

    let response_json_data = {};

    try {
        const result = await sharedRest.postJson(host, port, path, payload, token, 'HomologacionOficinas');

        if (+result.status === 500) {
            throw {
                "status": "500",
                "errorCode": "350301",
                "oficinaError": `${oficina}`,
                "errorMessage": "No response was received from the service 'Redis table: cl_oficina_cobis_taylor'"
            };
        }

<<<<<<< Updated upstream
            const req = http.request(options, function (res) {
                const chunks = [];
                json_data.status = res.statusCode;

                res.on("data", function (chunk) {
                    chunks.push(chunk);
                });

                res.on("end", function (chunk) {
                    const body = Buffer.concat(chunks);
                    resolve(body.toString());
                });

                res.on("error", function (error) {
                    reject(error);
                });
            });

            const postData = JSON.stringify({
                "header": {
                    "messageId": `${randomUUID()}`,
                    "timestamp": new Date().toISOString(),
                    "originatingBank": process.env.ORINATINGBANK,
                    "authToken": `${token_type} ${access_token}`,
                    "callbackUrl": process.env.CALLBACKURL,
                    "requestType": "transfer",
                    "transactionId": 'txn-' + Date.now()
                },
                "metadata": {
                    "priority": process.env.PRIORITY,
                    "serviceLevelAgreement": process.env.SERVICELEVELAGREEMENT,
                    "processingMode": process.env.PROCESSINGMODE
                },
                "deviceContext": {
                    "deviceId": 'device-' + Date.now(),
                    "deviceType": 'server',
                    "osVersion": process.version,
                    "ipAddress": "127.0.0.1",
                    "macAddress": "00:1B:44:11:3A:B7",
                    "geoLocation": {
                        "latitude": "0.0000",
                        "longitude": "0.0000"
                    },
                    "clientApp": {
                        "appName": process.env.APPNAME,
                        "appVersion": process.env.APPVERSION,
                        "userAgent": `${usuario}`
                    }
                },
                "operationData": {
                    "RedisStore": {
                        "Reference": {
                            "Text": `${CAT_HOMOLOGADO}`
                        },
                        "SelectionKey": {
                            "Text": `${oficina},P`
                        }
                    }
                }
            });

            req.write(postData);
            req.end();

        });

        await promise
            .finally(() => console.log(`✅ Consulta Oficina n°${oficina} status: ${json_data.status}`))
            .then(result => {
                let resultParser = JSON.parse(result);
                if (+resultParser.status === 500) {
                    let erros = {
                        "status": "500",
                        "errorCode": "350301",
                        "oficinaError": `${oficina}`,
                        "errorMessage": "No response was received from the service 'Redis table: cl_oficina_cobis_taylor'"
                    };
                    throw (erros);
                };
                response_json_data.status = json_data.status;
                response_json_data.data = resultParser.operationData.QueryCriteria;
            })
            .catch(error => {
                throw (error);
            });
=======
        response_json_data.status = 200; // Asumimos 200 si postJson no falló
        response_json_data.data = result.operationData.QueryCriteria;
>>>>>>> Stashed changes

        return JSON.stringify(response_json_data);

    } catch (error) {
        console.error(`❌ Error al homologar oficina cobis n°${oficina}:`, error.errorMessage || error.message);
        throw error;
    }
}

module.exports = {
    "fn_restHomologacionOficinas": fn_restHomologacionOficinas,
};