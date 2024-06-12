// var redis 	= require('redis').createClient;
// var adapter = require('socket.io-redis');

const { stringify } = require('querystring');
var Room = require('./server/models/room');

/**
 * Encapsulates all code for emitting and listening to socket events
 *
 */
var clients = {};
const rooms = { }
var ioEvents = function(io) {
    io.on('connection', (socket) => {
		console.log("connetetd");
		console.log(socket.id, "has joined");
		socket.on("/test", (msg) => {
		  console.log(msg.id);
		  let user_id = msg.id;
		  socket.user_id = user_id;
		  console.log(socket.user_id, "has joined");
		  clients[user_id] = socket;
		});
		socket.on("message", (e) => {
		  let targetId = e.targetId;
		  console.log(clients);
		  // console.log(targetId);
		  // console.log(e.message);
	  
		  if (clients[targetId]) {
			console.log(e.message);
			console.log(e.targetId);
	  
			clients[targetId].emit("message", e);
		  }
		});






        // console.log('a user connected');
        // socket.on('disconnect', () => {
        //   console.log('user disconnected');
        // });

        // // socket.on('chat message', (msg) => {
        // //     console.log('message: ' + msg);
        // //   });

        //   socket.on('chat message', (roomName, message) => {
        //     console.log('roomName' + roomName + ',message: ' + message);
        //     const matchingUsers = rooms[roomName].users.filter(user => user.sid === socket.id);
        //     if (matchingUsers && matchingUsers.length == 1) {
        //         console.log("to room broadcast")
        //         console.log(matchingUsers[0].uid + " says " + message)
        //     socket.to(roomName).emit('chat-message-incoming', { message: message, sendUserName: matchingUsers[0].uid})
        //     }
        //   })
        // //   socket.on('new-user', (room, name) => {
        // //     socket.join(room)
        // //     rooms[room].users[socket.id] = name
        // //   })

        //   socket.on('create or join room', (roomName, username) => {
        //     if (rooms[roomName] != null) {
        //         console.log('room exists...');
        //       }

        //       if (!rooms[roomName]) {
        //         rooms[roomName] = { users: [] };
        //     }
              
        //       if (!rooms[roomName].users.some(user => user.sid === socket.id)) {

        //         socket.join(roomName)
        //         let newUser = { sid: socket.id, uid: username }; 
        //         rooms[roomName].users.push(newUser);

        //       socket.to(roomName).emit('user-connected', username)
        //       console.log('room ' + roomName + ' has ' + JSON.stringify(rooms));

        //     }
         
        //   })
      });

	// Rooms namespace
	// io.of('/rooms').on('connection', function(socket) {
    //     console.log('a user connected rooms namespace');

	// 	// Create a new room
    //     socket.on('createRoom', function (title) {
    //         Room.findOne({ where: { title: title } })
    //             .then((room) => {
    //                 if (!room) {
    //                     console.log("room create here")
    //                 }
    //                 else {
    //                     console.log("room already here")
    //                 }
    //             })

	// 		// Room.findOne({'title': new RegExp('^' + title + '$', 'i')}, function(err, room){
	// 		// 	if(err) throw err;
	// 		// 	if(room){
	// 		// 		socket.emit('updateRoomsList', { error: 'Room title already exists.' });
	// 		// 	} else {
	// 		// 		Room.create({ 
	// 		// 			title: title
	// 		// 		}, function(err, newRoom){
	// 		// 			if(err) throw err;
	// 		// 			socket.emit('updateRoomsList', newRoom);
	// 		// 			socket.broadcast.emit('updateRoomsList', newRoom);
	// 		// 		});
	// 		// 	}
	// 		// });
	// 	});
	// });

	// // Chatroom namespace
	// io.of('/chatroom').on('connection', function(socket) {

	// 	// Join a chatroom
	// 	// socket.on('join', function(roomId) {
	// 	// 	Room.findById(roomId, function(err, room){
	// 	// 		if(err) throw err;
	// 	// 		if(!room){
	// 	// 			// Assuming that you already checked in router that chatroom exists
	// 	// 			// Then, if a room doesn't exist here, return an error to inform the client-side.
	// 	// 			socket.emit('updateUsersList', { error: 'Room doesnt exist.' });
	// 	// 		} else {
	// 	// 			// Check if user exists in the session
	// 	// 			if(socket.request.session.passport == null){
	// 	// 				return;
	// 	// 			}

	// 	// 			Room.addUser(room, socket, function(err, newRoom){

	// 	// 				// Join the room channel
	// 	// 				socket.join(newRoom.id);

	// 	// 				Room.getUsers(newRoom, socket, function(err, users, cuntUserInRoom){
	// 	// 					if(err) throw err;
							
	// 	// 					// Return list of all user connected to the room to the current user
	// 	// 					socket.emit('updateUsersList', users, true);

	// 	// 					// Return the current user to other connecting sockets in the room 
	// 	// 					// ONLY if the user wasn't connected already to the current room
	// 	// 					if(cuntUserInRoom === 1){
	// 	// 						socket.broadcast.to(newRoom.id).emit('updateUsersList', users[users.length - 1]);
	// 	// 					}
	// 	// 				});
	// 	// 			});
	// 	// 		}
	// 	// 	});
	// 	// });

	// 	// When a socket exits
	// 	socket.on('disconnect', function() {
    //         console.log("chatroom disconnect")

            
	// 		// Check if user exists in the session
	// 		// if(socket.request.session.passport == null){
	// 		// 	return;
	// 		// }

	// 		// Find the room to which the socket is connected to, 
	// 		// and remove the current user + socket from this room
	// 		// Room.removeUser(socket, function(err, room, userId, cuntUserInRoom){
	// 		// 	if(err) throw err;

	// 		// 	// Leave the room channel
	// 		// 	socket.leave(room.id);

	// 		// 	// Return the user id ONLY if the user was connected to the current room using one socket
	// 		// 	// The user id will be then used to remove the user from users list on chatroom page
	// 		// 	if(cuntUserInRoom === 1){
	// 		// 		socket.broadcast.to(room.id).emit('removeUser', userId);
	// 		// 	}
	// 		// });
	// 	});

	// 	// // When a new message arrives
	// 	// socket.on('newMessage', function(roomId, message) {

	// 	// 	// No need to emit 'addMessage' to the current socket
	// 	// 	// As the new message will be added manually in 'main.js' file
	// 	// 	// socket.emit('addMessage', message);
			
	// 	// 	socket.broadcast.to(roomId).emit('addMessage', message);
	// 	// });

	// });
}

/**
 * Initialize Socket.io
 * Uses Redis as Adapter for Socket.io
 *
 */
var init = function(app){
	var server 	= require('http').Server(app);
	var io 		= require('socket.io')(server, {
        // cors: {
        //   origin: "http://localhost:8000",
        //   methods: ["GET", "POST"],
        //   transports: ['websocket', 'polling'],
        //   credentials: true
        // },
      });

	// Force Socket.io to ONLY use "websockets"; No Long Polling.
	// io.set('transports', ['websocket']);

	// Using Redis
	// let port = config.redis.port;
	// let host = config.redis.host;
	// let password = config.redis.password;
	// let pubClient = redis(port, host, { auth_pass: password });
	// let subClient = redis(port, host, { auth_pass: password, return_buffers: true, });
	// io.adapter(adapter({ pubClient, subClient }));

	// Allow sockets to access session data
	// io.use((socket, next) => {
	// 	require('../session')(socket.request, {}, next);
	// });

	// Define all Events
	ioEvents(io);

	// The server object will be then used to list to a port number
	return server;
}

module.exports = init;