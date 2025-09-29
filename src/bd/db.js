const mysql = require("mysql2/promise");

const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "mysql",
  database: "abogados_db",
});

module.exports = pool;