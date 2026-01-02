import { exec } from 'child_process';
import { promisify } from 'util';
import { join, resolve } from 'path';

const execAsync = promisify(exec);

// Get project root directory (parent of web directory)
function getProjectRoot(): string {
  const currentDir = process.cwd();
  // If we're in the web directory, go up one level
  if (currentDir.endsWith('web') || currentDir.endsWith('web/')) {
    return resolve(currentDir, '..');
  }
  return currentDir;
}

export interface ServiceAction {
  service: string;
  action: 'up' | 'down' | 'restart' | 'status' | 'logs';
}

export interface ServiceStatus {
  service: string;
  status: 'running' | 'stopped' | 'unknown';
  container?: string;
}

export async function executeMakeCommand(
  service: string,
  action: string
): Promise<{ success: boolean; output: string; error?: string }> {
  const makeTarget = `${service}-${action}`;

  try {
    const projectRoot = getProjectRoot();

    const { stdout, stderr } = await execAsync(`make ${makeTarget}`, {
      cwd: projectRoot,
      timeout: 60000, // 60 seconds timeout
    });

    return {
      success: true,
      output: stdout || stderr || 'Command executed successfully',
    };
  } catch (error: any) {
    return {
      success: false,
      output: error.stdout || '',
      error: error.stderr || error.message,
    };
  }
}

export async function getServiceStatus(service: string): Promise<ServiceStatus> {
  try {
    const projectRoot = getProjectRoot();
    // Use docker-compose ps directly for more reliable status
    const { stdout } = await execAsync(
      `cd services/${service} && docker-compose ps`,
      {
        cwd: projectRoot,
        timeout: 10000,
      }
    );

    // Check if container is running
    const isRunning = stdout.includes('Up') ||
                      stdout.includes('running') ||
                      (stdout.includes(service) && !stdout.includes('Exit'));

    return {
      service,
      status: isRunning ? 'running' : 'stopped',
    };
  } catch (error) {
    return {
      service,
      status: 'unknown',
    };
  }
}

export async function getAllServicesStatus(): Promise<ServiceStatus[]> {
  const services = [
    'mongodb',
    'nats-jetstream',
    'redis',
    'postgres',
    'mysql',
    'elasticsearch',
    'kafka',
    'rabbitmq',
    'minio',
    'prometheus',
    'grafana',
    'influxdb',
    'cassandra',
    'neo4j',
    'memcached',
    'consul',
    'vault',
    'nginx',
    'traefik',
    'jaeger',
    'zipkin',
    'clickhouse',
    'couchdb',
  ];

  const statuses = await Promise.all(
    services.map((service) => getServiceStatus(service))
  );

  return statuses;
}

export async function getServiceLogs(
  service: string,
  lines: number = 100
): Promise<string> {
  try {
    const projectRoot = getProjectRoot();
    const { stdout } = await execAsync(
      `cd services/${service} && docker-compose logs --tail=${lines}`,
      {
        cwd: projectRoot,
        timeout: 10000,
      }
    );

    return stdout;
  } catch (error: any) {
    return error.stderr || error.message || 'Failed to fetch logs';
  }
}

