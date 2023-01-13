<script lang="ts">
	type Message = {
		avatar: string;
		context: object;
		from: 'user' | 'assistant';
		text: string;
	};

	let messages: Message[] = [];
	let text: string = '';

	const websocket = new WebSocket('ws://localhost:4000/ws');

	const addMessage = (message: Message) => {
		messages = [...messages, message];

		window.scrollBy(0, 300);
	};

	const createMessage = (from: 'user' | 'assistant', text: string): Message => ({
		avatar:
			from === 'user'
				? 'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png'
				: 'https://static.vecteezy.com/ti/vetor-gratis/p3/199370-robo-alegre-isolado-na-ilustracao-do-conceito-de-fundo-azul-gratis-vetor.jpg',
		context: {},
		from,
		text
	});

	websocket.onopen = () => {
		websocket.onmessage = (event) => {
			const response: Message = JSON.parse(event.data);
			const assistantMessage = createMessage('assistant', response?.text ?? 'F');

			addMessage(assistantMessage);
		};
	};

	const onUserTyping = (event: any) => {
		if (event.which === 13) {
			const message = createMessage('user', text);
			addMessage(message);
			text = '';
			websocket.send(JSON.stringify({ text: message.text }));
		}
	};
</script>

<ol>
	{#each messages as message}
		<li>
			<div
				class="flex items-center justify-start {message.from === 'user'
					? 'flex-row-reverse'
					: 'flex-row'}"
			>
				<img
					class="w-8 h-8 {message.from === 'user' ? 'ml-2' : 'mr-2'} rounded-full"
					src={message.avatar}
					alt={message.from}
				/>
				<div
					class="py-2 px-4 rounded-md shadow-lg {message.from === 'user'
						? 'bg-red-500 text-white'
						: 'bg-white text-red-500 border-red-500'}"
				>
					<p>{@html message.text}</p>
					<!-- <time>
						{new Date().toISOString().substring(11, 5)}
					</time> -->
				</div>
			</div>
		</li>
	{/each}
</ol>
<input
	on:keydown={onUserTyping}
	bind:value={text}
	class="absolute bottom-0 left-0 right-0 border-1 border-gray-300 outline-none"
	type="text"
	placeholder="Digite aqui..."
	id="type"
/>
<div class="emojis" />

<style>
	li div div {
		max-width: 300px;
	}
</style>
