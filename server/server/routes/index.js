const todosController = require('../controllers').todos;
const todoItemsController = require('../controllers').todoItems;
const roomsController = require('../controllers').rooms;
const userController = require('../controllers').user;
const authController = require('../controllers').auth;
const videoController = require('../controllers').video;
const path = require('path');

module.exports = (app) => {
  app.get('/api', (req, res) => res.status(200).send({
    message: 'Welcome to the Todos API!',
  }));

  app.post('/api/todos', todosController.create);
  app.get('/api/todos', todosController.list);
  app.get('/api/todos/:todoId', todosController.retrieve);
  app.put('/api/todos/:todoId', todosController.update);
  app.delete('/api/todos/:todoId', todosController.destroy);

  app.post('/api/todos/:todoId/items', todoItemsController.create);
  app.put('/api/todos/:todoId/items/:todoItemId', todoItemsController.update);
  app.delete(
    '/api/todos/:todoId/items/:todoItemId', todoItemsController.destroy
  );
  app.all('/api/todos/:todoId/items', (req, res) => res.status(405).send({
    message: 'Method Not Allowed',
  }));

  // room
  app.post('/api/rooms', roomsController.create);
  app.get('/api/rooms', roomsController.retrieve);
  

  //user
  app.post('/api/user', userController.create);
  app.get('/api/user', userController.retrieve);

  app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../../index.html'));
  });

  //login
  app.post("/login", authController.logIn);
  app.post('/register', authController.register);

  //video
  app.post('/getVideoList', videoController.getVideoList);
  app.post('/videoDetail', videoController.videoDetail);
  app.post('/videoSeriesList', videoController.videoSeriesList);
  
};