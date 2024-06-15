const fileController = require('../controllers').file;
const router = require("express").Router();
const multer = require('multer');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    return cb(null, "./public/upload")
  },
  filename: function (req, file, cb) {
    return cb(null, `${Date.now()}_${file.originalname}`)
  }
})
const upload = multer({ storage })

router.post('/uploadImage', upload.single("img"), fileController.receiveFile)

module.exports = router;