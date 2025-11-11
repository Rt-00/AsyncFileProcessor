<script lang="ts">
	import { validateFile } from '$lib/utils/file.utils';
	import FileInput from './FileInput.svelte';

	export let onUploadSuccess: () => void;

	let selectedFile: File | null = null;
	let isUploading = false;
	let errorMessage = '';
	let successMessage = '';

	$: canUpload = selectedFile !== null && !isUploading;

	function clearMessage(): void {
		errorMessage = '';
		successMessage = '';
	}

	function handleFileSelect(file: File | null): void {
		clearMessage();

		if (file) {
			const validation = validateFile(file);

			if (!validation.valid) {
				errorMessage = validation.error!;
				selectedFile = null;

				// Clear input
				const input = document.querySelector('input[type="file"]') as HTMLInputElement;

				if (input) {
					input.value = '';
				}

				return;
			}
		}

		selectedFile = file;
	}
</script>

<div class="space-y-4">
	<FileInput onChange={handleFileSelect} disabled={isUploading} />
</div>
