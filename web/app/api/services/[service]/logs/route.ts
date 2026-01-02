import { NextRequest, NextResponse } from 'next/server';
import { getServiceLogs } from '@/app/lib/make-executor';

export async function GET(
  request: NextRequest,
  { params }: { params: { service: string } }
) {
  try {
    const { service } = params;
    const searchParams = request.nextUrl.searchParams;
    const lines = parseInt(searchParams.get('lines') || '100', 10);

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

    const logs = await getServiceLogs(service, lines);

    return NextResponse.json({ service, logs });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to get service logs' },
      { status: 500 }
    );
  }
}

