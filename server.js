const { createServer } = require('http');
const { parse } = require('url');
const next = require('next');
const getClientIp = require('./app/lib/utils/getClientIP');
const getClientDevice = require('./app/lib/utils/getClientDevice');
const getClientOs = require('./app/lib/utils/getClientOS');

const dev = process.env.NODE_ENV !== 'production';
const hostname = process.env.NODE_HOSTNAME || 'localhost';
const port = process.env.PORT || 3000;

const app = next({ dev, hostname, port });
const handle = app.getRequestHandler();

app.prepare().then(() => {
    createServer(async (req, res) => {

        try {
            const parsedUrl = parse(req.url, true);
            const { pathname, query } = parsedUrl;

            const infoClient = {
                "clientIp": getClientIp(req),
                "deviceType": getClientDevice(req),
                "clientOs": getClientOs(req)
            };

            res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains; preload');
            res.setHeader('X-Frame-Options', 'DENY');
            res.setHeader('Permissions-Policy', 'geolocation=(self), microphone=(), camera=(), fullscreen=(self)');

            if (pathname === '/api/client-info') {
                res.setHeader('Content-Type', 'application/json');
                res.statusCode = 200;
                res.end(JSON.stringify(infoClient));
                return;
            };

            if (pathname === '/a') {
                await app.render(req, res, '/a', query);
            } else if (pathname === '/b') {
                await app.render(req, res, '/b', query);
            } else {
                await handle(req, res, parsedUrl);
            };

            console.log(`Request processed: ${req.url}`);

        } catch (err) {
            console.error(`internal server error: ${req.url} - ${err}`);
            res.statusCode = 500;
            res.end(err);
        }
    })
        .once('error', (err) => {
            console.error(`Server error: ${err}`);
            process.exit(1)
        })
        .listen(port, () => {
            console.log(`Server started on http://${hostname}:${port}`);
        })
});