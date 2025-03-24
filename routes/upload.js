// uploadMultiple.js
const express = require("express");
const multer = require("multer");
const path = require("path");
const router = express.Router();

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    // Supondo que o arquivo esteja na pasta "routes", suba um nível para acessar "public/images"
    cb(null, path.join(__dirname, "..", "public", "images"));
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, file.fieldname + "-" + uniqueSuffix + ext);
  },
});

// Aqui indicamos que o multer deve aceitar um array de arquivos com o nome "files"
const upload = multer({ storage });
router.post("/multiple", upload.array("files", 20), (req, res) => {
  if (!req.files || req.files.length === 0) {
    return res.status(400).json({ error: "Nenhum arquivo enviado." });
  }
  const imagePaths = req.files.map((file) => `/images/${file.filename}`);
  return res.status(200).json({ paths: imagePaths });
});

module.exports = router;
