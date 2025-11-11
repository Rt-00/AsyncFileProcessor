import { API_BASE_URL, FETCH_TIMEOUT, UPLOAD_TIMEOUT } from '$lib/constants/upload.constants';
import type { Upload, UploadResponse } from '$lib/types/upload.types';

export class UploadService {
	static async uploadFile(file: File): Promise<UploadResponse> {
		const formData = new FormData();
		formData.append('file', file);

		const response = await fetch(`${API_BASE_URL}/uploads`, {
			method: 'POST',
			body: formData,
			signal: AbortSignal.timeout(UPLOAD_TIMEOUT)
		});

		if (!response.ok) {
			const errorData = await response.json().catch(() => ({}));
			throw new Error(errorData.message || `Erro no upload: ${response.status}`);
		}

		return response.json();
	}

	static async fetchUploads(): Promise<Upload[]> {
		const response = await fetch(`${API_BASE_URL}/uploads`, {
			signal: AbortSignal.timeout(FETCH_TIMEOUT)
		});

		if (!response.ok) {
			throw new Error(`Erro ao carregar uploads: ${response.status}`);
		}

		return response.json();
	}
}
