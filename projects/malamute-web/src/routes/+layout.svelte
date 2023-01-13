<script lang="ts">
	import Icon from '@iconify/svelte';
	import '../app.postcss';

	type Option = {
		icon: string;
		name: string;
		path: string;
	};

	const options: Option[] = [
		{
			name: 'Início',
			path: '/',
			icon: 'home'
		},
		{
			name: 'Bot',
			path: '/bot',
			icon: 'robot-happy'
		}
	];
</script>

<nav>
	<div>
		<ul class="bg-red-500 text-white py-10 shadow-lg">
			{#each options as option}
				<li
					class="cursor-pointer px-10 py-3 ease-in-out duration-300 hover:bg-white hover:text-red-500"
				>
					<a href={option.path} class="flex flex-row justify-start items-center">
						<Icon icon="mdi:{option.icon}" class="mr-2" />
						<p>{option.name}</p>
					</a>
				</li>
			{/each}
		</ul>
	</div>
	<main id="slot">
		<slot />
	</main>
</nav>

<style>
	nav {
		display: grid;
		grid-template-columns: 200px 1fr;
		gap: 10px;
	}

	nav ul {
		height: 100vh;
		width: 200px;
	}

	#slot {
		padding: 10px;
		display: flex;
		flex-direction: column;
		flex: 1;
	}
</style>
