const app = require('express')();
const http = require('http').createServer(app);

app.get('/', (req, res) => {
  res.send('<h1>Hey Socket.io</h1>');
});

http.listen(5000, () => {
  console.log('listeninghttp on *:3000');
});

const io = require('socket.io');

io.on('connection', function(socket) {
    console.log(socket.id)
    socket.on('atualizar', function() {
      console.log('server running on port 3001');
        io.emit('atualizar')
    });
});