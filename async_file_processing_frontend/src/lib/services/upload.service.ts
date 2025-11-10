import { API_BASE_URL, FETCH_TIMEOUT } from '$lib/constants/upload.constants';
import type { Upload } from '$lib/types/upload.types';

export class UploadService {
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
