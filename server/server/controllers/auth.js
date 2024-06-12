
const db = require('../../db/pgDb');
module.exports = {
  logIn(req, res) {
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
  },

  register(req, res) {
    console.log('register')
    const { username, password, email, auth_level } = req.body;
    try {
      // const existingUser = await db.pool.query('SELECT * FROM users WHERE username = $1', [username]);
      // if (existingUser.rows.length!== 0) {
      //   return res.status(400).json({ error: "username already exists, no need to register again." });
      // }
      // const newUser = await db.pool.query('INSERT INTO users (username, password, email, auth_level) VALUES ($1, $2, $3, $4) RETURNING id', [username, password, email, auth_level]);
      // if (newUser.rows.length === 0) {
      //   return res.status(500).json({ error: "Failed to insert new user into the database." });
      // }
      
      res.status(200).json({ message: 'User added to database' });
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: "Database error while registering user!" });
    }
  }
}