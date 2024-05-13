const { Pool } = require('pg')
var conString = "postgres://postgres:jaydean@localhost:5432/WebHomeManager";
const pool = new Pool({
    connectionString: conString
})

module.exports = {
    pool
}