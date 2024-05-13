const router = require("express").Router();

const authController = require("../controllers/authController");

// router.route("/login").post(authController.login);
// router.post("/register", authController.register);
// router.post("/forgot-password", authController.forgotPassword);
// router.post("/reset-password", authController.resetPassword);
router.post("/test", authController.test);

module.exports = router;