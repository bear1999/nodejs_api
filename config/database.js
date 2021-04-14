require("dotenv").config();

const { createPool } = require("mysql");
const pool = createPool({
    port: process.env.DB_PORT,
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    database: process.env.MYSQL_DB,
    password: process.env.DB_PASSWORD,
});

module.exports = pool;