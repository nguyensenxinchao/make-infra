'use client';

interface StatusIndicatorProps {
  status: 'running' | 'stopped' | 'unknown';
  size?: 'sm' | 'md' | 'lg';
}

export default function StatusIndicator({ status, size = 'md' }: StatusIndicatorProps) {
  const sizeClasses = {
    sm: 'w-2 h-2',
    md: 'w-3 h-3',
    lg: 'w-4 h-4',
  };

  const statusColors = {
    running: 'bg-green-500',
    stopped: 'bg-red-500',
    unknown: 'bg-gray-500',
  };

  const statusLabels = {
    running: 'Running',
    stopped: 'Stopped',
    unknown: 'Unknown',
  };

  return (
    <div className="flex items-center gap-2">
      <div
        className={`${sizeClasses[size]} ${statusColors[status]} rounded-full animate-pulse`}
      />
      <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
        {statusLabels[status]}
      </span>
    </div>
  );
}

