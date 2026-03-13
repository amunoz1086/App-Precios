/**
 * fn_restKeycloak.js
 * ------------------
 * Cliente de tokens Keycloak con flujo client_credentials.
 * Soporta bypass completo cuando OAUTH_ENABLED=false:
 *   → no realiza ninguna solicitud de red a Keycloak
 *   → retorna null para que los consumidores omitan la autenticación
 */

const https = require('https');
const qs = require('querystring');
const appConfig = require('@/app/lib/config/appConfig');

/**
 * Solicita un access_token a Keycloak usando client_credentials.
 *
 * @returns {Promise<string|null>}
 *   - string JSON con { data: { access_token, expires_in, token_type } }
 *     cuando OAuth está habilitado y la solicitud es exitosa.
 *   - null cuando OAUTH_ENABLED=false (bypass).
 */
async function fn_restKeycloak() {

    // ------------------------------------------------------------------
    // BYPASS: si OAuth está desactivado, no contactamos Keycloak en absoluto
    // ------------------------------------------------------------------
    if (!appConfig.oauthEnabled) {
        console.log('[fn_restKeycloak] OAuth DESACTIVADO – bypass de solicitud de token.');
        return null;
    }

    // ------------------------------------------------------------------
    // Configuración del endpoint – tomada exclusivamente de appConfig
    // para evitar lecturas dispersas de process.env
    // ------------------------------------------------------------------
    const { host, port, path, grantType, clientId, clientSecret } = appConfig.keycloak;

    // Suspender validación de certificado si la variable lo indica
    if (!appConfig.tlsRejectUnauthorized) {
        process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
        console.log('[fn_restKeycloak] Validación TLS suspendida (configuración NODE_TLS_REJECT_UNAUTHORIZED=0).');
    }

    let json_data = {};
    let response_json_data = {};

    try {

        const options = {
            method: 'POST',
            hostname: host,
            port: port,        // puede ser undefined si no se especifica
            path: path,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            maxRedirects: 20,
        };

        // Construcción del cuerpo en formato form-urlencoded
        const postData = qs.stringify({
            grant_type: grantType,
            client_id: clientId,
            client_secret: clientSecret,   // nunca se imprime en logs
        });

        const promise = new Promise((resolve, reject) => {

            const req = https.request(options, (res) => {
                const chunks = [];
                json_data.status = res.statusCode;

                res.on('data', (chunk) => chunks.push(chunk));
                res.on('end', () => {
                    json_data.data = Buffer.concat(chunks).toString();
                    resolve(json_data);
                });
                res.on('error', (err) => reject(err));
            });

            req.on('error', reject);
            req.write(postData);
            req.end();
        });

        await promise
            // Log de estado sin revelar token
            .finally(() => console.log(`[fn_restKeycloak] Keycloak status: ${json_data.status}`))
            .then((result) => {
                response_json_data.data = JSON.parse(result.data);
            })
            .catch((err) => { throw err; });

        return JSON.stringify(response_json_data);

    } catch (error) {
        // Loguear el error sin incluir clientSecret
        console.error('[fn_restKeycloak] Error al solicitar token:', error.message ?? error);
    } finally {
        // Restaurar validación TLS al finalizar
        if (!appConfig.tlsRejectUnauthorized) {
            process.env.NODE_TLS_REJECT_UNAUTHORIZED = '1';
            console.log('[fn_restKeycloak] Validación TLS restaurada.');
        }
    }
}

module.exports = { fn_restKeycloak };