<script lang="ts">
	import { UploadService } from '../services/upload.service';
	import { validateFile } from '../utils/file.utils';
	import FileInput from './FileInput.svelte';
	import UploadButton from './UploadButton.svelte';
	import Alert from './ui/Alert.svelte';

	export let onUploadSuccess: () => void;

	let selectedFile: File | null = null;
	let isUploading = false;
	let errorMessage = '';
	let successMessage = '';

	$: canUpload = selectedFile !== null && !isUploading;

	function clearMessages(): void {
		errorMessage = '';
		successMessage = '';
	}

	function handleFileSelect(file: File | null): void {
		clearMessages();

		if (file) {
			const validation = validateFile(file);
			if (!validation.valid) {
				errorMessage = validation.error!;
				selectedFile = null;

				// Clear input
				const input = document.querySelector('input[type="file"]') as HTMLInputElement;
				if (input) input.value = '';

				return;
			}
		}

		selectedFile = file;
	}

	async function handleUpload(): Promise<void> {
		clearMessages();

		if (!selectedFile) {
			errorMessage = 'Por favor, selecione um arquivo.';
			return;
		}

		const validation = validateFile(selectedFile);
		if (!validation.valid) {
			errorMessage = validation.error!;
			return;
		}

		isUploading = true;

		try {
			const data = await UploadService.uploadFile(selectedFile);
			successMessage = data.message || 'Arquivo enviado com sucesso!';

			// Clear file input
			selectedFile = null;
			const fileInput = document.querySelector('input[type="file"]') as HTMLInputElement;
			if (fileInput) fileInput.value = '';

			// Notify parent
			onUploadSuccess();
		} catch (error) {
			if (error instanceof Error) {
				if (error.name === 'TimeoutError') {
					errorMessage = 'Tempo limite excedido. Tente novamente.';
				} else if (error.name === 'TypeError') {
					errorMessage = 'Erro de conexão. Verifique sua internet.';
				} else {
					errorMessage = error.message;
				}
			} else {
				errorMessage = 'Erro desconhecido ao fazer upload.';
			}
			console.error('Upload error:', error);
		} finally {
			isUploading = false;
		}
	}
</script>

<div class="space-y-4">
	<FileInput onChange={handleFileSelect} disabled={isUploading} />

	<UploadButton {isUploading} disabled={!canUpload} onClick={handleUpload} />

	{#if errorMessage}
		<Alert type="error" message={errorMessage} />
	{/if}

	{#if successMessage}
		<Alert type="success" message={successMessage} />
	{/if}
</div>
