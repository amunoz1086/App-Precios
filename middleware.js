
import { NextResponse } from 'next/server'

export function middleware(request) {
    const dev = process.env.NODE_ENV !== 'production';
    const nonce = Buffer.from(crypto.randomUUID()).toString('base64')

    const cspHeader = `
      default-src 'self';
      script-src 'self' 'nonce-${nonce}' ${dev ? `'unsafe-eval'` : ""};
      style-src 'self' ${dev ? "" : `'unsafe-inline'`};
      img-src 'self';
      media-src 'self';
      font-src 'self';
      object-src 'none';
      base-uri 'self';
      form-action 'self';
      frame-ancestors 'self';
      frame-src 'self' blob:;
      ${dev ? "" : 'upgrade-insecure-requests;'}
      report-uri /csp-report;
  `
    const contentSecurityPolicyHeaderValue = cspHeader
        .replace(/\s{2,}/g, ' ')
        .trim()

    const requestHeaders = new Headers(request.headers)
    requestHeaders.set('x-nonce', nonce)
    requestHeaders.set(
        'Content-Security-Policy',
        contentSecurityPolicyHeaderValue
    )

    const response = NextResponse.next({
        request: {
            headers: requestHeaders,
        },
    });
    response.headers.set(
        'Content-Security-Policy',
        contentSecurityPolicyHeaderValue
    )

    return response
};