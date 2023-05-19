window.addEventListener('online', () =>
	window.location.href="/",
	console.log('Became online')
);
window.addEventListener('offline', () =>
	window.location.href="/noConnection",
	console.log('Became offline')
);