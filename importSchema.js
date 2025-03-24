const sqlite3 = require('sqlite3').verbose();
const fs = require('fs');
const path = require('path');

// Abre (ou cria) o arquivo banco.sqlite
const db = new sqlite3.Database('banco.sqlite', (err) => {
  if (err) {
    console.error("Erro ao abrir o banco:", err.message);
  } else {
    console.log("Banco SQLite aberto com sucesso.");
  }
});

// Lê o conteúdo do seu arquivo schema.sql
const schemaPath = path.join(__dirname, 'schema.sql');
fs.readFile(schemaPath, 'utf8', (err, data) => {
  if (err) {
    console.error("Erro ao ler o arquivo schema.sql:", err.message);
    return;
  }
  
  // Executa o schema no banco
  db.exec(data, (err) => {
    if (err) {
      console.error("Erro ao importar o schema:", err.message);
    } else {
      console.log("Schema importado com sucesso.");
    }
    // Fecha a conexão com o banco
    db.close((err) => {
      if (err) {
        console.error("Erro ao fechar o banco:", err.message);
      } else {
        console.log("Banco fechado.");
      }
    });
  });
});
