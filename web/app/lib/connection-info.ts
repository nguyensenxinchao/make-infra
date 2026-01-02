import { exec } from 'child_process';
import { promisify } from 'util';
import { resolve } from 'path';

const execAsync = promisify(exec);

export interface ConnectionInfo {
  service: string;
  host: string;
  port: number | string;
  httpPort?: number | string;
  managementPort?: number | string;
  transportPort?: number | string;
  zookeeperPort?: number | string;
  username?: string | null;
  password?: string | null;
  rootPassword?: string;
  database?: string | null;
  connectionString: string;
  managementUrl?: string | null;
  environment: Record<string, string>;
}

function getProjectRoot(): string {
  const currentDir = process.cwd();
  // If we're in the web directory, go up one level
  if (currentDir.endsWith('web') || currentDir.endsWith('web/')) {
    return resolve(currentDir, '..');
  }
  return currentDir;
}

export async function getConnectionInfo(
  service: string
): Promise<ConnectionInfo> {
  try {
    const projectRoot = getProjectRoot();
    const { stdout } = await execAsync(
      `./scripts/get-connection-info.sh ${service} json`,
      {
        cwd: projectRoot,
        timeout: 10000,
      }
    );

    return JSON.parse(stdout.trim());
  } catch (error: any) {
    throw new Error(
      `Failed to get connection info for ${service}: ${error.message}`
    );
  }
}

export async function getAllConnectionInfo(): Promise<ConnectionInfo[]> {
  const services = [
    'mongodb',
    'nats-jetstream',
    'redis',
    'postgres',
    'mysql',
    'elasticsearch',
    'kafka',
    'rabbitmq',
  ];

  const connectionInfos = await Promise.allSettled(
    services.map((service) => getConnectionInfo(service))
  );

  return connectionInfos
    .filter((result) => result.status === 'fulfilled')
    .map((result) => (result as PromiseFulfilledResult<ConnectionInfo>).value);
}

