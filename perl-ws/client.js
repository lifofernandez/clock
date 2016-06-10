var ws = new WebSocket('ws://localhost:8080');

ws.onopen = function() {
		console.log('Connection is established!');
};

ws.onclose = function() {
		console.log('Connection is closed');
};

ws.onmessage = function(e) {
		var message = e.data;
		console.log('Got new message: ' + message);

		// Visual blik
		document.body.style.background = '#FFF';
		setTimeout(
			function() {
				document.body.style.background = '#000';
			},
			100
		);
};

setTimeout(
  function(){
    ws.send('Hello, world!');
  },
  1000
);
