const catchAsync = require("../util/catchAsync");
const db = require('../db/pgDb');

const videos = [
  {
    id: '1',
    name: "人生副本1",
    videoLen: "360",
    videoUrl:"userId/videos/butterfly.mp4",
    thumbNail: "userId/images/sunset.jpg",
    description: "You only live once ",
    series: ['1','2','3']
  },
  {
    id: '2',
    name: "人生副本2",
    videoLen: "480",
    videoUrl:"userId/videos/butterfly.mp4",
    thumbNail: "userId/images/fuji.jpg",
    description: "Too long too much too long1234567",
    series: ['1','2','3']
  },
  {
    id: '3',
    name: "人生副本3",
    videoLen: "480",
    videoUrl:"userId/videos/butterfly.mp4",
    thumbNail: "userId/images/hill.jpg",
    description: "just nothing",
    series: ['1','2','3']
  },
  {
    id: '4',
    name: "其它",
    videoLen: "480",
    videoUrl:"userId/videos/butterfly.mp4",
    thumbNail: "userId/images/hill.jpg",
    description: "just nothing"
  }];

exports.videoDetail = catchAsync(async (req, res, next) => {
  console.log('videoDetail:' + req.query.Id)
  var id = req.query.Id;
  try {
    const videoDetail = videos[id-1];
    return res.status(200).json({
      code: 200,
      msg: "Success",
      data: videoDetail
    });

  } catch (error) {
    return res.status(500).json({ error: error.message })
  }
});

exports.videoSeriesList = catchAsync(async (req, res, next) => {
  console.log('videoSeriesList:' + req.query.Id)
  try {
    var filteredVideos = videos.filter(video => video.series?.some(seriesItem => seriesItem == req.query.Id))
    return res.status(200).json({
      code: 200,
      msg: "Success",
      data: filteredVideos
    });
  } catch (error) {
    return res.status(500).json({ error: error.message })
  }
});

exports.getVideoList = catchAsync(async (req, res, next) => {
  console.log('getVideoList')
  try {
    return res.status(200).json({
      code: 200,
      msg: "Success",
      data: videos
    });
   
  } catch (error) {
    return res.status(500).json({ error: error.message })
  }
});

exports.test = catchAsync(async (req, res, next) => {
  console.log('test')
  try {
    const result = await db.pool.query('SELECT * FROM users')
    return res.status(200).json("fine")
  } catch (error) {
    return res.status(500).json({ error: error.message })
  }

  // return res.status(400).json({
  //   status: "test status",
  //   message: "test test",
  // });
});

exports.logIn = catchAsync(async (req, res, next) => {
  console.log('logIn')
  try {
    return res.status(200).json({
      userName: req.query.userName,
      avatar: "userId/images/avatar.jpg",
      email: 'didnot use',
      password: req.query.password,
    });
  } catch (error) {
    return res.status(500).json({ error: error.message })
  }
});

exports.register = catchAsync(async (req, res, next)  => {
  const { username, password, email, auth_level } = req.body;
  try {
    const existingUser = await db.pool.query('SELECT * FROM users WHERE username = $1', [username]);
    if (existingUser.rows.length!== 0) {
      return res.status(400).json({ error: "username already exists, no need to register again." });
    }
    const newUser = await db.pool.query('INSERT INTO users (username, password, email, auth_level) VALUES ($1, $2, $3, $4) RETURNING id', [username, password, email, auth_level]);
    if (newUser.rows.length === 0) {
      return res.status(500).json({ error: "Failed to insert new user into the database." });
    }
    
    res.status(200).json({ message: 'User added to database' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error while registering user!" });
  }
});
