<script lang="ts">
	export let type: 'error' | 'success' = 'error';
	export let message: string;

	const styles = {
		error: 'bg-red-900/50 border-red-700 text-red-200',
		success: 'bg-green-900/50 border-green-700 text-green-200'
	};

	const labels = {
		error: 'Erro',
		success: 'Sucesso'
	};
</script>

<div class="rounded-lg border p-4 text-sm {styles[type]}" role="alert">
	<strong class="font-medium">{labels[type]}:</strong>
	{message}
</div>
