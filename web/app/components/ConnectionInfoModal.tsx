'use client';

import { useState, useEffect } from 'react';

interface ConnectionInfo {
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

interface ConnectionInfoModalProps {
  service: string;
  isOpen: boolean;
  onClose: () => void;
}

export default function ConnectionInfoModal({
  service,
  isOpen,
  onClose,
}: ConnectionInfoModalProps) {
  const [connectionInfo, setConnectionInfo] = useState<ConnectionInfo | null>(
    null
  );
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [copied, setCopied] = useState<string | null>(null);

  useEffect(() => {
    if (isOpen && service) {
      fetchConnectionInfo();
    }
  }, [isOpen, service]);

  const fetchConnectionInfo = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch(`/api/services/${service}/connection-info`);
      if (!response.ok) {
        throw new Error('Failed to fetch connection info');
      }
      const data = await response.json();
      setConnectionInfo(data);
    } catch (err: any) {
      setError(err.message || 'Failed to load connection info');
    } finally {
      setLoading(false);
    }
  };

  const copyToClipboard = (text: string, label: string) => {
    navigator.clipboard.writeText(text);
    setCopied(label);
    setTimeout(() => setCopied(null), 2000);
  };

  const getServiceDisplayName = (service: string) => {
    const names: Record<string, string> = {
      mongodb: 'MongoDB',
      'nats-jetstream': 'NATS JetStream',
      redis: 'Redis',
      postgres: 'PostgreSQL',
      mysql: 'MySQL',
      elasticsearch: 'Elasticsearch',
      kafka: 'Apache Kafka',
      rabbitmq: 'RabbitMQ',
    };
    return names[service] || service;
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        <div className="sticky top-0 bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 p-4 flex justify-between items-center">
          <h2 className="text-xl font-bold text-gray-900 dark:text-white">
            Connection Info - {getServiceDisplayName(service)}
          </h2>
          <button
            onClick={onClose}
            className="text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200"
          >
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
        </div>

        <div className="p-6">
          {loading && (
            <div className="text-center py-8">
              <div className="text-gray-600 dark:text-gray-400">
                Loading connection info...
              </div>
            </div>
          )}

          {error && (
            <div className="bg-red-100 dark:bg-red-900 border border-red-400 text-red-700 dark:text-red-300 px-4 py-3 rounded mb-4">
              {error}
            </div>
          )}

          {connectionInfo && !loading && (
            <div className="space-y-6">
              {/* Connection String */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Connection String
                </label>
                <div className="flex gap-2">
                  <input
                    type="text"
                    readOnly
                    value={connectionInfo.connectionString}
                    className="flex-1 px-3 py-2 bg-gray-100 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-md text-sm font-mono text-gray-900 dark:text-white"
                  />
                  <button
                    onClick={() =>
                      copyToClipboard(
                        connectionInfo.connectionString,
                        'connection'
                      )
                    }
                    className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors text-sm"
                  >
                    {copied === 'connection' ? 'Copied!' : 'Copy'}
                  </button>
                </div>
              </div>

              {/* Basic Info */}
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                    Host
                  </label>
                  <div className="px-3 py-2 bg-gray-50 dark:bg-gray-700 rounded-md text-sm text-gray-900 dark:text-white">
                    {connectionInfo.host}
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                    Port
                  </label>
                  <div className="px-3 py-2 bg-gray-50 dark:bg-gray-700 rounded-md text-sm text-gray-900 dark:text-white">
                    {connectionInfo.port}
                  </div>
                </div>
                {connectionInfo.httpPort && (
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                      HTTP Port
                    </label>
                    <div className="px-3 py-2 bg-gray-50 dark:bg-gray-700 rounded-md text-sm text-gray-900 dark:text-white">
                      {connectionInfo.httpPort}
                    </div>
                  </div>
                )}
                {connectionInfo.managementPort && (
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                      Management Port
                    </label>
                    <div className="px-3 py-2 bg-gray-50 dark:bg-gray-700 rounded-md text-sm text-gray-900 dark:text-white">
                      {connectionInfo.managementPort}
                    </div>
                  </div>
                )}
                {connectionInfo.username && (
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                      Username
                    </label>
                    <div className="px-3 py-2 bg-gray-50 dark:bg-gray-700 rounded-md text-sm text-gray-900 dark:text-white">
                      {connectionInfo.username}
                    </div>
                  </div>
                )}
                {connectionInfo.password && (
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                      Password
                    </label>
                    <div className="flex gap-2">
                      <input
                        type="password"
                        readOnly
                        value={connectionInfo.password}
                        className="flex-1 px-3 py-2 bg-gray-50 dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-md text-sm font-mono text-gray-900 dark:text-white"
                      />
                      <button
                        onClick={() =>
                          copyToClipboard(
                            connectionInfo.password || '',
                            'password'
                          )
                        }
                        className="px-3 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors text-sm"
                      >
                        {copied === 'password' ? 'Copied!' : 'Copy'}
                      </button>
                    </div>
                  </div>
                )}
                {connectionInfo.database && (
                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                      Database
                    </label>
                    <div className="px-3 py-2 bg-gray-50 dark:bg-gray-700 rounded-md text-sm text-gray-900 dark:text-white">
                      {connectionInfo.database}
                    </div>
                  </div>
                )}
              </div>

              {/* Management URL */}
              {connectionInfo.managementUrl && (
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Management URL
                  </label>
                  <a
                    href={connectionInfo.managementUrl}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-blue-600 dark:text-blue-400 hover:underline"
                  >
                    {connectionInfo.managementUrl}
                  </a>
                </div>
              )}

              {/* Environment Variables */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Environment Variables
                </label>
                <div className="bg-gray-900 rounded-md p-4 overflow-x-auto">
                  <pre className="text-xs text-green-400 font-mono">
                    {Object.entries(connectionInfo.environment)
                      .map(([key, value]) => `${key}=${value}`)
                      .join('\n')}
                  </pre>
                </div>
                <button
                  onClick={() =>
                    copyToClipboard(
                      Object.entries(connectionInfo.environment)
                        .map(([key, value]) => `${key}=${value}`)
                        .join('\n'),
                      'env'
                    )
                  }
                  className="mt-2 px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors text-sm"
                >
                  {copied === 'env' ? 'Copied!' : 'Copy All'}
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

