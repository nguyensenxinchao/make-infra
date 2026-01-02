import { NextRequest, NextResponse } from 'next/server';
import { getConnectionInfo } from '@/app/lib/connection-info';

export async function GET(
  request: NextRequest,
  { params }: { params: { service: string } }
) {
  try {
    const { service } = params;

    const validServices = [
      'mongodb',
      'nats-jetstream',
      'redis',
      'postgres',
      'mysql',
      'elasticsearch',
      'kafka',
      'rabbitmq',
    ];

    if (!validServices.includes(service)) {
      return NextResponse.json(
        { error: `Invalid service: ${service}` },
        { status: 400 }
      );
    }

    const connectionInfo = await getConnectionInfo(service);
    return NextResponse.json(connectionInfo);
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to get connection info' },
      { status: 500 }
    );
  }
}

