const express = require("express");
const bcrypt = require("bcryptjs");
const router = express.Router();
const db = require("../connection");

router.put("/edit_pass", async (req, res) => {
  const { id, newPassword } = req.body;

  if (!id || !newPassword) {
    return res.status(400).json({ message: "ID do usuário e nova senha são obrigatórios." });
  }

  try {
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    db.query("UPDATE users SET pass = ? WHERE id = ?", [hashedPassword, id], (err, result) => {
      if (err) {
        console.error("Erro ao alterar senha:", err);
        return res.status(500).json({ message: "Erro ao alterar senha.", error: err.message });
      }
      return res.status(200).json({ message: "Senha alterada com sucesso." });
    });
  } catch (error) {
    console.error("Erro ao alterar senha:", error);
    return res.status(500).json({ message: "Erro ao alterar senha.", error: error.message });
  }
});

module.exports = router;
