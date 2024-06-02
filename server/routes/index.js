const router = require("express").Router();
const allInOneRoute = require("./allInOne");
router.use("/allInOne", allInOneRoute);
module.exports = router;