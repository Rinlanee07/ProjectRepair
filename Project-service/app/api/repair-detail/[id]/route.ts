import { NextResponse } from 'next/server';

export const runtime = 'nodejs';

/**
 * Proxy GET /api/repair-detail/:id -> backend /repair-detail/:id
 * Uses NEXT_PUBLIC_API_URL environment variable if set, otherwise defaults to http://localhost:3001
 */
export async function GET(req: Request, { params }: { params: { id: string } }) {
  const { id } = params;

  const backendBase = process.env.NEXT_PUBLIC_API_URL || `http://localhost:3001`;
  const target = `${backendBase.replace(/\/$/, '')}/repair-detail/${encodeURIComponent(id)}`;

  try {
    const headers: Record<string, string> = {};
    const incomingAuth = req.headers.get('authorization');
    if (incomingAuth) headers['authorization'] = incomingAuth;

    const res = await fetch(target, {
      method: 'GET',
      headers,
    });

    const text = await res.text();
    const contentType = res.headers.get('content-type') || 'application/json';

    return new NextResponse(text, {
      status: res.status,
      headers: { 'Content-Type': contentType },
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Proxy error';
    return NextResponse.json({ error: message }, { status: 502 });
  }
}
