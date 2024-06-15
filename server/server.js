const app = require('./app'); // The express app we just created
var ioServer = require('./socket')(app);
const port = parseInt(process.env.PORT, 10) || 8000;

ioServer.listen(port, () => console.log('Server started on port ' + port))


// var io = require("socket.io")(server);

// var clients = {};

// io.on("connection", (socket) => {
//   console.log("connetetd");
//   console.log(socket.id, "has joined");

//   console.log(socket.id);
//   clients[socket.id] = socket;
//   console.log(clients.length);

//   // socket.on("signin", (id) => {
//   //   console.log("signin");
//   //   console.log(id);
//   //   clients[id] = socket;
//   //   console.log(clients);
//   // });

//   socket.on("message", (msg) => {
//     console.log(msg);
//     let targetId = msg.targetId;
//     console.log(clients);
//     if (clients[targetId]) {
//       console.log("To:" + clients[targetId]);
//       clients[targetId].emit("message", msg);
//     }
//   });
// });

