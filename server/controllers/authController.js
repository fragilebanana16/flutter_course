
const catchAsync = require("../util/catchAsync");
const db = require('../db/pgDb');
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
