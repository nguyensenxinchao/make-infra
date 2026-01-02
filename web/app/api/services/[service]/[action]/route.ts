import { NextRequest, NextResponse } from 'next/server';
import { executeMakeCommand } from '@/app/lib/make-executor';

export async function POST(
  request: NextRequest,
  { params }: { params: { service: string; action: string } }
) {
  try {
    const { service, action } = params;

    // Validate service and action
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

    const validActions = ['up', 'down', 'restart', 'status', 'logs'];

    if (!validServices.includes(service)) {
      return NextResponse.json(
        { error: `Invalid service: ${service}` },
        { status: 400 }
      );
    }

    if (!validActions.includes(action)) {
      return NextResponse.json(
        { error: `Invalid action: ${action}` },
        { status: 400 }
      );
    }

    const result = await executeMakeCommand(service, action);

    if (result.success) {
      return NextResponse.json({
        success: true,
        message: `Service ${service} ${action} executed successfully`,
        output: result.output,
      });
    } else {
      return NextResponse.json(
        {
          success: false,
          error: result.error || 'Command failed',
          output: result.output,
        },
        { status: 500 }
      );
    }
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    );
  }
}

