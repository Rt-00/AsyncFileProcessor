import { ACCEPTED_FILE_TYPES, MAX_FILE_SIZE } from '$lib/constants/upload.constants';
import type { FileValidation } from '$lib/types/upload.types';

export function validateFile(file: File | null): FileValidation {
	if (!file) {
		return { valid: false, error: 'Nenhum arquivo selecionado.' };
	}

	if (file.size > MAX_FILE_SIZE) {
		return {
			valid: false,
			error: `Arquivo muito grande. Tamanho máximo: ${MAX_FILE_SIZE / 1024 / 1024}MB`
		};
	}

	const extension = file.name.split('.').pop()?.toLowerCase();
	const allowedExtensions = ACCEPTED_FILE_TYPES.split(',').map((ext) => ext.replace('.', ''));

	if (!extension || !allowedExtensions.includes(extension)) {
		return {
			valid: false,
			error: `Tipo de arquivo não permitido. Use ${ACCEPTED_FILE_TYPES}`
		};
	}

	return { valid: true };
}

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
