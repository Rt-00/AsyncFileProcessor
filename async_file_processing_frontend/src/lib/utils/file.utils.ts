export function formatDate(dateString: string): string {
	try {
		return new Date(dateString).toLocaleString('pt-BR', {
			day: '2-digit',
			month: '2-digit',
			year: 'numeric',
			hour: '2-digit',
			minute: '2-digit'
		});
	} catch {
		return dateString;
	}
}
