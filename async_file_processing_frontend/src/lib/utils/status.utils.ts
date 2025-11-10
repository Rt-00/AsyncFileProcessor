import type { Upload } from '../types/upload.types';

export function getStatusColor(status: Upload['status']): string {
	const colors = {
		pending: 'text-yellow-500',
		processing: 'text-blue-500',
		completed: 'text-green-500',
		failed: 'text-red-500'
	};

	return colors[status] || 'text-gray-400';
}

export function getStatusLabel(status: Upload['status']): string {
	const labels = {
		pending: 'Pendente',
		processing: 'Processando',
		completed: 'Concluído',
		failed: 'Falhou'
	};

	return labels[status] || status;
}
