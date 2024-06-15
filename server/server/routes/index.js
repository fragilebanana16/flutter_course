const router = require("express").Router();
const authRoute = require("./auth");
const chatRoute = require("./chat");
const userRoute = require("./user");
const todoListRoute = require("./todo");
const videoRoute = require("./video");

router.use("/auth", authRoute);
router.use("/chat", chatRoute);
router.use("/user", userRoute);
router.use("/todoList", todoListRoute);
router.use("/video", videoRoute);

module.exports = router;
