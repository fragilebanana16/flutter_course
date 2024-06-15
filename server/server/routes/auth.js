const router = require("express").Router();
const authController = require('../controllers').auth;

router.post("/login", authController.logIn);
router.post('/register', authController.register);

module.exports = router;