import { NextResponse } from 'next/server';
import { getAllServicesStatus } from '@/app/lib/make-executor';

export async function GET() {
  try {
    const statuses = await getAllServicesStatus();
    return NextResponse.json({ services: statuses });
  } catch (error: any) {
    return NextResponse.json(
      { error: error.message || 'Failed to get service statuses' },
      { status: 500 }
    );
  }
}

