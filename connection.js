const mysql = require("mysql");

const db = mysql.createConnection({
  host: "localhost",
  user: "root", // Alterar se necessário
  password: "", // Alterar se necessário
  database: "sticktape",
  multipleStatements: true
});

// Conectar ao banco de dados
db.connect((err) => {
  if (err) {
    console.error("Erro ao conectar ao banco de dados:", err);
    setTimeout(connectDB, 5000); // Tenta reconectar após 5 segundos
  } else {
    console.log("Conectado ao banco de dados MySQL");
  }
});

// Função para reconectar em caso de erro na conexão
db.on("error", (err) => {
  console.error("Erro na conexão do banco de dados:", err);
  if (err.code === "PROTOCOL_CONNECTION_LOST") {
    connectDB();
  } else {
    throw err;
  }
});

function connectDB() {
  db.connect((err) => {
    if (err) {
      console.error("Erro ao reconectar ao banco de dados:", err);
      setTimeout(connectDB, 5000);
    } else {
      console.log("Reconectado ao banco de dados MySQL");
    }
  });
}

module.exports = db;
