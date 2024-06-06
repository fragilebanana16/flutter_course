const router = require("express").Router();

const authController = require("../controllers/allInOneController");

// router.route("/login").post(authController.login);
// router.post("/register", authController.register);
// router.post("/forgot-password", authController.forgotPassword);
// router.post("/reset-password", authController.resetPassword);
router.post("/test", authController.test);
router.post("/login", authController.logIn);
router.post('/register', authController.register);
router.post('/getVideoList', authController.getVideoList);
router.post('/videoDetail', authController.videoDetail);
router.post('/videoSeriesList', authController.videoSeriesList);
module.exports = router;