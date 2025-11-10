export const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';
export const ACCEPTED_FILE_TYPES = '.csv,.json';
export const POLLING_INTERVAL = 5000;
export const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
export const UPLOAD_TIMEOUT = 30000; // 30s
export const FETCH_TIMEOUT = 10000; // 10s
