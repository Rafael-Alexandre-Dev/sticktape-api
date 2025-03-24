const sqlite3 = require("sqlite3").verbose();
const path = require("path");

const dbPath = path.resolve(__dirname, "banco.sqlite");
const db = new sqlite3.Database(dbPath, (err) => {
  if (err) {
    console.error("Erro ao conectar no SQLite:", err.message);
  } else {
    console.log("Conectado ao SQLite!");
  }
});

// Adiciona um método query similar ao do MySQL
db.query = (sql, params, callback) => {
  if (/^\s*SELECT/i.test(sql)) {
    db.all(sql, params, callback);
  } else {
    db.run(sql, params, function (err) {
      callback(err, { insertId: this.lastID, affectedRows: this.changes });
    });
  }
};

module.exports = db;
