const app = require('express')();
const http = require('http').createServer(app);

app.get('/', (req, res) => {
  res.send('<h1>Hey Socket.io</h1>');
});

const server = app.listen(5000, function() {
    console.log('server running on port 3001');
});


const io = require('socket.io')(server,{
    cors: {
        origin: "*",
        methods: ["GET", "POST"],
        transports: ['websocket', 'polling'],
        credentials: true
    },
    allowEIO3: true
});

io.on('connection', function(socket) {
    console.log(socket.id)
    socket.on('atualizar', function() {
    	console.log('server running on port 30012');
        io.emit('atualizar')
    });
});