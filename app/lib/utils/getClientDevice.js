function getClientDevice(req) {
    const userAgent = req.headers['user-agent']?.toLowerCase() || '';

    // Detección básica de tipo de dispositivo
    if (/mobile|android|iphone|ipod|blackberry|iemobile|opera mini/.test(userAgent)) {
        return 'mobile';
    }

    if (/ipad|tablet/.test(userAgent)) {
        return 'tablet';
    }

    // Si no coincide con ninguno, asumimos escritorio
    return 'desktop';
}

module.exports = getClientDevice;
