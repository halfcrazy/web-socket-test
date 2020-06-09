#!/bin/sh

cat << EOF > server.js
console.log("Server started");
const WebSocket = require('ws');
 
const wss = new WebSocket.Server({ port: 8010 });
 
wss.on('connection', function connection(ws, req) {
  const ip = req.socket.remoteAddress;
  ws.on('message', function incoming(data) {
    console.log('Received from client %s: %s', ip, data);
    wss.clients.forEach(function each(client) {
      if (client.readyState === WebSocket.OPEN) {
        client.send('Server received from client ' + ip + ': ' + data);
      }
    });
  });
});


EOF

node server.js
