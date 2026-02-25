const http = require('http');
const fs = require('fs');
const { randomUUID } = require('crypto');
const { getSession } = require('@/app/lib/auth/auth');
const keycloak = require('@/app/lib/services/keycloak/fn_restKeycloak');

async function fn_restHomologacionOficinas(dataReques) {

    const { oficina } = JSON.parse(dataReques);

    const OFICINA_HOMOLOGADA_HOST = process.env.URL_HOST_OFICINA_HOMOLOGADA;
    const OFICINA_HOMOLOGADA_PORT = process.env.URL_PORT_OFICINA_HOMOLOGADA;
    const OFICINA_HOMOLOGADA_PATH = process.env.URL_PATH_OFICINA_HOMOLOGADA;

    const CAT_HOMOLOGADO = process.env.CATALOGO_HOMOLOGADO;

    const token = JSON.parse(await keycloak.fn_restKeycloak());
    const access_token = token.data.access_token;
    const token_type = token.data.token_type;

    const usuario = (await getSession()).userBACK.user;

    const options = {
        'method': 'POST',
        'hostname': `${OFICINA_HOMOLOGADA_HOST}`,
        'port': OFICINA_HOMOLOGADA_PORT,
        'path': `${OFICINA_HOMOLOGADA_PATH}`,
        'headers': {
            'Content-Type': 'application/json',
            'Authorization': `${token_type} ${access_token}`
        },
        'maxRedirects': 20
    };

    let json_data = {};
    let response_json_data = {};

    try {

        let promise = new Promise(function (resolve, reject) {

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

            req.setTimeout(10000);

            req.on("timeout", function () {
                req.destroy();
                reject({
                    status: 504,
                    errorCode: "TIMEOUT",
                    errorMessage: "El servicio de homologación no respondió a tiempo"
                });
            });

            req.on("error", function (error) {
                reject({
                    status: 500,
                    errorCode: error.code || "REQUEST_ERROR",
                    errorMessage: error.message
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

        return JSON.stringify(response_json_data);

    } catch (error) {
        console.log(`❌ Error al homologar oficina cobis n°${oficina}`, error);
        throw (error);
    };
};

module.exports = {
    "fn_restHomologacionOficinas": fn_restHomologacionOficinas,
};