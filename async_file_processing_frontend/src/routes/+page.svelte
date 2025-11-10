<script lang="ts">
	import UploadsTable from '$lib/components/UploadsTable.svelte';
	import { POLLING_INTERVAL } from '$lib/constants/upload.constants';
	import { UploadService } from '$lib/services/upload.service';
	import type { Upload } from '$lib/types/upload.types';
	import { onDestroy, onMount } from 'svelte';

	let uploads: Upload[] = [];
	let pollingIntervalId: ReturnType<typeof setInterval> | null = null;

	async function loadUploads(): Promise<void> {
		try {
			uploads = await UploadService.fetchUploads();
		} catch (error) {
			console.error('Error loading uploads: ', error);
		}
	}

	function startPolling(): void {
		pollingIntervalId = setInterval(loadUploads, POLLING_INTERVAL);
	}

	function stopPolling(): void {
		if (pollingIntervalId) {
			clearInterval(pollingIntervalId);
			pollingIntervalId = null;
		}
	}

	onMount(async () => {
		await loadUploads();
		startPolling();
	});

	onDestroy(() => {
		stopPolling();
	});
</script>

<div class="flex min-h-screen flex-col items-center bg-gray-900 px-4 py-10">
	<div class="w-full max-w-2xl rounded-2xl bg-gray-800 p-6 shadow-lg">
		<h1 class="mb-6 text-center text-3xl font-bold text-white">Upload de Arquivos</h1>

		<UploadsTable {uploads} />
	</div>
</div>
