const router = require("express").Router();
const roomsController = require('../controllers').rooms;

router.post('/rooms', roomsController.create);
router.get('/rooms', roomsController.retrieve);

module.exports = router;