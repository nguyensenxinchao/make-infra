'use client';

import { useState } from 'react';
import StatusIndicator from './StatusIndicator';

interface ServiceCardProps {
  service: string;
  status: 'running' | 'stopped' | 'unknown';
  onAction: (service: string, action: string) => Promise<void>;
}

export default function ServiceCard({ service, status, onAction }: ServiceCardProps) {
  const [loading, setLoading] = useState(false);
  const [showLogs, setShowLogs] = useState(false);
  const [logs, setLogs] = useState<string>('');

  const handleAction = async (action: string) => {
    setLoading(true);
    try {
      await onAction(service, action);
    } finally {
      setLoading(false);
    }
  };

  const handleViewLogs = async () => {
    if (showLogs) {
      setShowLogs(false);
      return;
    }

    setLoading(true);
    try {
      const response = await fetch(`/api/services/${service}/logs?lines=50`);
      const data = await response.json();
      setLogs(data.logs || 'No logs available');
      setShowLogs(true);
    } catch (error) {
      setLogs('Failed to fetch logs');
      setShowLogs(true);
    } finally {
      setLoading(false);
    }
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

  const getServiceIcon = (service: string) => {
    const icons: Record<string, string> = {
      mongodb: '🍃',
      'nats-jetstream': '🚀',
      redis: '🔴',
      postgres: '🐘',
      mysql: '🗄️',
      elasticsearch: '🔍',
      kafka: '⚡',
      rabbitmq: '🐰',
    };
    return icons[service] || '📦';
  };

  return (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6 border border-gray-200 dark:border-gray-700">
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center gap-3">
          <span className="text-3xl">{getServiceIcon(service)}</span>
          <div>
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
              {getServiceDisplayName(service)}
            </h3>
            <p className="text-sm text-gray-500 dark:text-gray-400">{service}</p>
          </div>
        </div>
        <StatusIndicator status={status} />
      </div>

      <div className="flex gap-2 flex-wrap">
        {status === 'stopped' || status === 'unknown' ? (
          <button
            onClick={() => handleAction('up')}
            disabled={loading}
            className="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            {loading ? 'Starting...' : 'Start'}
          </button>
        ) : (
          <>
            <button
              onClick={() => handleAction('down')}
              disabled={loading}
              className="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              {loading ? 'Stopping...' : 'Stop'}
            </button>
            <button
              onClick={() => handleAction('restart')}
              disabled={loading}
              className="px-4 py-2 bg-yellow-600 text-white rounded-md hover:bg-yellow-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              {loading ? 'Restarting...' : 'Restart'}
            </button>
          </>
        )}
        <button
          onClick={handleViewLogs}
          disabled={loading}
          className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          {showLogs ? 'Hide Logs' : 'View Logs'}
        </button>
      </div>

      {showLogs && (
        <div className="mt-4 p-4 bg-gray-900 rounded-md">
          <pre className="text-xs text-green-400 font-mono overflow-x-auto max-h-48 overflow-y-auto">
            {logs || 'Loading logs...'}
          </pre>
        </div>
      )}
    </div>
  );
}

