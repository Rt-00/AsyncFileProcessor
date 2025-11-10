<script lang="ts">
	import { formatDate } from '$lib/utils/file.utils';
	import type { Upload } from '../types/upload.types';
	import { getStatusColor, getStatusLabel } from '../utils/status.utils';

	export let uploads: Upload[] = [];
</script>

<div class="mt-10">
	<h2 class="mb-4 text-xl font-semibold text-white">Uploads Recentes</h2>

	{#if uploads.length === 0}
		<p class="py-8 text-center text-gray-400">Nenhum upload encontrado.</p>
	{:else}
		<div class="overflow-x-auto rounded-lg shadow">
			<table class="w-full text-left text-sm">
				<thead class="bg-gray-700 text-xs text-gray-300 uppercase">
					<tr>
						<th scope="col" class="px-4 py-3">Arquivo</th>
						<th scope="col" class="px-4 py-3">Status</th>
						<th scope="col" class="px-4 py-3">Data</th>
					</tr>
				</thead>
				<tbody>
					{#each uploads as upload (upload.id)}
						<tr class="border-t border-gray-700 bg-gray-800 transition-colors hover:bg-gray-700">
							<td class="px-4 py-3 font-medium text-gray-200">
								{upload.filename}
							</td>
							<td class="px-4 py-3">
								<span class="font-medium {getStatusColor(upload.status)}">
									{getStatusLabel(upload.status)}
								</span>
							</td>
							<td class="px-4 py-3 text-gray-400">
								{formatDate(upload.created_at)}
							</td>
						</tr>
					{/each}
				</tbody>
			</table>
		</div>
	{/if}
</div>
