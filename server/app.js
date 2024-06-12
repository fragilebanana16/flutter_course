const express = require('express')
const logger = require('morgan');
const bodyParser = require('body-parser');
const app = express()
var http = require("http");
const path = require('path');
const cors = require("cors");


app.use(logger('dev'));
app.use(cors());
app.use(express.json())
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// const routes = require("./routes/index");
// app.use(routes);



module.exports = app;