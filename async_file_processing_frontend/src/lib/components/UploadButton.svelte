<script lang="ts">
	import LoadingSpinner from './ui/LoadingSpinner.svelte';

	export let isUploading = false;
	export let disabled = false;
	export let onClick: () => void;
</script>

<button
	type="button"
	class="w-full rounded-lg bg-blue-600 py-3 font-semibold text-white transition-colors
    hover:bg-blue-700 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2
    focus:ring-offset-gray-800 focus:outline-none disabled:cursor-not-allowed disabled:bg-gray-600"
	on:click={onClick}
	{disabled}
	aria-busy={isUploading}
>
	{#if isUploading}
		<span>
			<LoadingSpinner />
			Enviando...
		</span>
	{:else}
		Fazer Upload
	{/if}
</button>
