const router = require("express").Router();
const videoController = require('../controllers').video;

router.post('/getVideoList', videoController.getVideoList);
router.post('/videoDetail', videoController.videoDetail);
router.post('/videoSeriesList', videoController.videoSeriesList);

module.exports = router;