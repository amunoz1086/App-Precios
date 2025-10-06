/**
 * @type {import('next').NextConfig} 
 */

const nextConfig = {
  reactStrictMode: false,
  swcMinify: false,
  eslint: {
    ignoreDuringBuilds: true,
  },
  async redirects() {
    return [
      {
        source: '/',
        destination: '/login', 
        permanent: true, // Cambiar a true si es una redirección permanente
      },
    ];
  },
};

module.exports = nextConfig;