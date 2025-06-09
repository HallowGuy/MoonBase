/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  reactStrictMode: true,
  basePath: '/app',
  assetPrefix: '/app',
  experimental: {
    appDir: true
  }
};

module.exports = nextConfig;
