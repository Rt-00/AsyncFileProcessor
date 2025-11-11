<script lang="ts">
	import { ACCEPTED_FILE_TYPES } from '../constants/upload.constants';

	export let disabled = false;
	export let onChange: (file: File | null) => void;

	function handleChange(event: Event): void {
		const input = event.target as HTMLInputElement;
		const file = input.files?.[0] ?? null;
		onChange(file);
	}
</script>

<div>
	<label for="file-input" class="mb-2 block text-sm font-medium text-gray-300">
		Selecione um arquivo ({ACCEPTED_FILE_TYPES})
	</label>
	<input
		id="file-input"
		type="file"
		class="block w-full cursor-pointer rounded-lg border border-gray-600 bg-gray-700 text-sm
		  text-gray-300 focus:ring-2 focus:ring-blue-500 focus:outline-none"
		on:change={handleChange}
		accept={ACCEPTED_FILE_TYPES}
		{disabled}
		aria-label="Selecionar arquivo"
	/>
</div>
