/* MP: funcion para conectarse con la API consultarClienteJuridico para consultar Personas Juridicas */

const https = require('https');
const fs = require('fs');
const bearerToken = require('../cognito/fn_restCognito');


async function fn_restConsultarClientePj(dataReques) {

    console.log('dataReques PJ:', dataReques);

    const rawData = await bearerToken.fn_restCognito();
    console.log('cognito puro PJ:', rawData);
    const access_token = JSON.parse(rawData).rawData;
    console.log('cognito Parse PJ:', access_token);

    const CLIENTEPJ_HOST = process.env.URL_HOST_CLIENTEPJ;
    const CLIENTEPJ_PORT = process.env.URL_PORT_CLIENTEPJ;
    const CLIENTEPJ_path = process.env.URL_PATH_CLIENTEPJ;

    console.log('CLIENTEPJ_HOST:', CLIENTEPJ_HOST);
    console.log('CLIENTEPJ_PORT:', CLIENTEPJ_PORT);
    console.log('CLIENTEPJ_path:', CLIENTEPJ_path);


    const options = {
        'method': 'POST',
        'hostname': `${CLIENTEPJ_HOST}`,
        'port': `${CLIENTEPJ_PORT}`,
        'path': `${CLIENTEPJ_path}`,
        'headers': {
            'Content-Type': 'application/json',
            'Authorization': `${JSON.parse(access_token).token_type} ${JSON.parse(access_token).access_token}`
        },
        'maxRedirects': 20
    };

    console.log('options PJ:', options);

    let json_data = {};
    let response_json_data;

    let promise = new Promise(function (resolve, reject) {
        const req = https.request(options, function (res) {
            let chunks = [];
            json_data.status = res.statusCode;

            if (res.statusCode === 200) {
                res.on("data", function (chunk) {
                    chunks.push(chunk);
                });
                res.on("end", function (chunk) {
                    let body = Buffer.concat(chunks);
                    console.log('respuesta buffer:', body);
                    json_data.status = res.statusCode;
                    json_data.rawData = body.toString();
                    resolve(json_data);
                });
            } else {
                res.on('data', function (chunk) {
                    json_data.status = res.statusCode;
                    json_data.message = 'error en la estructura json';
                    reject(json_data);
                });
            };
        }).on('error', (error) => {
            console.log('error reject PJ:', error);
            json_data.status = error.errno;
            json_data.code = error.code;
            json_data.message = error.message;
            reject(json_data);
        });

        let postData = JSON.stringify({
            "I_NUMEROIDENTIFICACION": dataReques.numDocumento,
            "I_TIPOCLIENTE": 1,
            "I_TIPOIDENTIFICACION": 3
        });

        console.log('postData PJ:', postData);

        req.write(postData);
        req.end();
    });

    await promise
        .finally(() => console.log(`integration consultarClienteJuridico status: ${json_data.status}`))
        .then(result => {
            response_json_data = JSON.stringify(result);
        })
        .catch(error => {
            console.log('error Pj:', error);
            response_json_data = JSON.stringify(error);
        });

    return response_json_data;
};

module.exports = {
    "fn_restConsultarClientePj": fn_restConsultarClientePj,
};