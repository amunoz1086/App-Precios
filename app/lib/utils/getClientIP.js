function getClientIp(req) {
    // Si está detrás de proxy o load balancer
    let ip = req.headers["x-forwarded-for"]?.split(",")[0];

    if (!ip) {
        ip = req.socket.remoteAddress || null;
    }

    // Normalizar IPv6 mapeado a IPv4 (ej: ::ffff:192.168.1.10 → 192.168.1.10)
    if (ip) {
        if (ip.startsWith("::ffff:")) {
            ip = ip.replace("::ffff:", "");
        } else if (ip === "::1") {
            ip = "127.0.0.1"
        }
    };

    return ip;
};

module.exports = getClientIp;