'use client';

import ServiceList from './components/ServiceList';

export default function Home() {
  return (
    <main className="min-h-screen bg-gray-50 dark:bg-gray-900 p-8">
      <div className="max-w-7xl mx-auto">
        <div className="mb-8">
          <h1 className="text-4xl font-bold text-gray-900 dark:text-white mb-2">
            Infrastructure Management Dashboard
          </h1>
          <p className="text-gray-600 dark:text-gray-400">
            Manage your infrastructure services with ease. Start, stop, restart, and monitor all your services from one place.
          </p>
        </div>

        <ServiceList />
      </div>
    </main>
  );
}

