const router = require("express").Router();
const userController = require('../controllers').user;

router.post('/user', userController.create);
router.get('/user', userController.retrieve);

module.exports = router;