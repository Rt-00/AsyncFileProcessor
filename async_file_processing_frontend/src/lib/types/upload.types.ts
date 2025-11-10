export interface Upload {
	id: string;
	filename: string;
	status: 'pending' | 'processing' | 'completed' | 'failed';
	created_at: string;
}

export interface UploadResponse {
	success: boolean;
	message?: string;
	upload?: Upload;
}

export interface FileValidation {
	valid: boolean;
	error?: string;
}
