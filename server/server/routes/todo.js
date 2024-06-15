const router = require("express").Router();
const todosController = require('../controllers').todos;
const todoItemsController = require('../controllers').todoItems;

router.get('/', (req, res) => res.status(200).send({message: 'Welcome to the Todos API!',}));
router.post('/todos', todosController.create);
router.get('/todos', todosController.list);
router.get('/todos/:todoId', todosController.retrieve);
router.put('/todos/:todoId', todosController.update);
router.delete('/todos/:todoId', todosController.destroy);
router.post('/todos/:todoId/items', todoItemsController.create);
router.put('/todos/:todoId/items/:todoItemId', todoItemsController.update);
router.delete('/todos/:todoId/items/:todoItemId', todoItemsController.destroy);
router.all('/todos/:todoId/items', (req, res) => res.status(405).send({message: 'Method Not Allowed',}));

module.exports = router;