'use client';

import { useEffect, useState } from 'react';
import ServiceCard from './ServiceCard';

interface ServiceStatus {
  service: string;
  status: 'running' | 'stopped' | 'unknown';
}

export default function ServiceList() {
  const [services, setServices] = useState<ServiceStatus[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchServices = async () => {
    try {
      const response = await fetch('/api/services/status');
      const data = await response.json();
      setServices(data.services || []);
    } catch (error) {
      console.error('Failed to fetch services:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchServices();
    // Auto-refresh every 5 seconds
    const interval = setInterval(fetchServices, 5000);
    return () => clearInterval(interval);
  }, []);

  const handleAction = async (service: string, action: string) => {
    setRefreshing(true);
    try {
      const response = await fetch(`/api/services/${service}/${action}`, {
        method: 'POST',
      });
      const data = await response.json();

      if (data.success) {
        // Refresh services after action
        setTimeout(() => {
          fetchServices();
        }, 2000);
      } else {
        alert(`Failed: ${data.error || 'Unknown error'}`);
      }
    } catch (error: any) {
      alert(`Error: ${error.message || 'Failed to execute action'}`);
    } finally {
      setRefreshing(false);
    }
  };

  const handleRefresh = () => {
    setRefreshing(true);
    fetchServices();
  };

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-screen">
        <div className="text-xl text-gray-600 dark:text-gray-400">Loading services...</div>
      </div>
    );
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
          Infrastructure Services
        </h2>
        <button
          onClick={handleRefresh}
          disabled={refreshing}
          className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          {refreshing ? 'Refreshing...' : 'Refresh'}
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {services.map((service) => (
          <ServiceCard
            key={service.service}
            service={service.service}
            status={service.status}
            onAction={handleAction}
          />
        ))}
      </div>
    </div>
  );
}

