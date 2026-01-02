import { NextResponse } from 'next/server';
import { getAllConnectionInfo } from '@/app/lib/connection-info';

export async function GET() {
  try {
    const connectionInfos = await getAllConnectionInfo();
    return NextResponse.json({ services: connectionInfos });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to get connection info' },
      { status: 500 }
    );
  }
}

