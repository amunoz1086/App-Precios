function getClientOs(req) {
    let os = req.headers['sec-ch-ua-platform'];
    if (os) {
        os = os.replace(/"/g, '');
    } else {
        const ua = req.headers['user-agent']?.toLowerCase() || '';
        if (ua.includes('windows')) os = 'Windows';
        else if (ua.includes('mac os')) os = 'macOS';
        else if (ua.includes('android')) os = 'Android';
        else if (ua.includes('iphone') || ua.includes('ipad')) os = 'iOS';
        else if (ua.includes('linux')) os = 'Linux';
        else os = 'Desconocido';
    };

    return os;
};

module.exports = getClientOs;






