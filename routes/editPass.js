// routes/editPass.js
const express = require("express");
const bcrypt = require("bcryptjs");
const router = express.Router();

// Suponha que você tenha um módulo para acessar o banco de dados.
// Ajuste conforme sua implementação.
const db = require("../connection"); // Exemplo: conexão com PostgreSQL, MySQL, etc.

router.put("/edit_pass", async (req, res) => {
  const { id, newPassword } = req.body;

  if (!id || !newPassword) {
    return res
      .status(400)
      .json({ message: "ID do usuário e nova senha são obrigatórios." });
  }

  try {
    // Realiza o hash da nova senha
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Atualiza a senha do usuário no banco de dados
    // A query a seguir é um exemplo. Altere conforme a sintaxe e ORM/driver que você utiliza.
    await db.query("UPDATE users SET pass = ? WHERE id = ?", [
      hashedPassword,
      id,
    ]);

    return res.status(200).json({ message: "Senha alterada com sucesso." });
  } catch (error) {
    console.error("Erro ao alterar senha:", error);
    return res
      .status(500)
      .json({ message: "Erro ao alterar senha.", error: error.message });
  }
});

module.exports = router;
