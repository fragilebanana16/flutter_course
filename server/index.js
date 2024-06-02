const express = require('express')
const app = express()
const path = require('path');
const cors = require("cors");
app.use(cors());
app.use(express.json())
app.use(express.static(path.join(__dirname, 'public')));
const routes = require("./routes/index");
app.use(routes);

const port = 8080
app.listen(port, () => console.log('Server started on port ' + port))