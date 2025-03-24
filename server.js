// Importação de variáveis de ambiente
require("dotenv").config();
const nodemailer = require("nodemailer");
const express = require("express");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const db = require("./connection");
const path = require("path");

// Middlewares para segurança e desempenho
const compression = require("compression");
const helmet = require("helmet");
const morgan = require("morgan");

const app = express();
const PORT = process.env.PORT || 3001;
const SECRET_KEY =
  process.env.SECRET_KEY || "4879615d-c5ae-44f7-82cf-cb7a6cb66de5";

// Middlewares globais
// Serve arquivos estáticos da pasta public e também para a rota /images
app.use(
  express.static(path.join(__dirname, "public"), {
    setHeaders: (res, filePath) => {
      res.set("Access-Control-Allow-Origin", "*");
      if (filePath.match(/\.(png|jpg|jpeg|gif|svg)$/)) {
        res.set("Cross-Origin-Resource-Policy", "cross-origin");
      }
    },
  })
);
app.use("/images", express.static(path.join(__dirname, "public", "images")));

app.use(compression());
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan("dev"));
app.use(
  helmet({
    crossOriginResourcePolicy: false,
  })
);

// Rotas customizadas
const editPassRoute = require("./routes/editPass");
app.use("/", editPassRoute);

const uploadRouter = require("./routes/upload.js");
app.use("/upload", uploadRouter);

// Middleware para verificação de token em rotas protegidas
const verifyToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  if (!authHeader) {
    return res.status(403).json({ message: "Token não fornecido." });
  }
  const token = authHeader.split(" ")[1];
  jwt.verify(token, SECRET_KEY, (err, decoded) => {
    if (err) {
      return res.status(401).json({ message: "Token inválido." });
    }
    req.user = decoded;
    next();
  });
};

// Rota para envio de e-mail via Nodemailer
app.post("/send-email", (req, res) => {
  const { nome, sobrenome, email, telefone, mensagem } = req.body;
  const transporter = nodemailer.createTransport({
    host: "email-ssl.com.br",
    port: 587,
    secure: false,
    auth: {
      user: "leads.site@sticktape.com.br",
      pass: "Sticktape@222300",
    },
    tls: {
      rejectUnauthorized: false,
    },
  });
  const mailOptions = {
    from: "leads.site@sticktape.com.br",
    replyTo: email,
    to: "jefferson@sticktape.com.br",
    subject: "Novo lead do Site!",
    text: `
      Nome: ${nome} ${sobrenome}
      E-mail: ${email}
      Telefone: ${telefone}
      Mensagem: ${mensagem}
    `,
  };
  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.error("Erro ao enviar e-mail:", error);
      return res.status(500).send("Erro ao enviar e-mail.");
    }
    res.send("E-mail enviado com sucesso!");
  });
});

/*-----------------------------------------
  Rotas de ORÇAMENTOS
-----------------------------------------*/
// Listar orçamentos (rota protegida)
app.get("/orcamentos", verifyToken, (req, res) => {
  const query = "SELECT * FROM orcamentos";
  db.query(query, [], (err, results) => {
    if (err) {
      console.error("Erro ao buscar orçamentos:", err);
      return res.status(500).json({ message: "Erro ao buscar orçamentos." });
    }
    res.json(results);
  });
});

// Criar um novo orçamento
app.post("/orcamentos", async (req, res) => {
  const { produtos, nome_cliente, email, telefone } = req.body;
  if (!produtos || !nome_cliente || !email || !telefone) {
    return res.status(400).json({ message: "Todos os campos obrigatórios devem ser preenchidos." });
  }
  const query =
    "INSERT INTO orcamentos (produtos_orcamento, nome_cliente, email_cliente, telefone_cliente) VALUES (?, ?, ?, ?)";
  const produtosJSON = JSON.stringify(produtos);
  db.query(query, [produtosJSON, nome_cliente, email, telefone], (err, result) => {
    if (err) {
      console.error("Erro ao criar orçamento:", err);
      return res.status(500).json({ message: "Erro ao criar orçamento." });
    }
    res.json({
      message: "Orçamento criado com sucesso!",
      id: result.insertId,
    });
  });
});

// Atualizar um orçamento (rota protegida)
app.put("/orcamentos/:id", verifyToken, async (req, res) => {
  const { id } = req.params;
  const { produtos, nome_cliente, email, telefone } = req.body;
  if (!produtos || !nome_cliente || !email || !telefone) {
    return res.status(400).json({ message: "Todos os campos obrigatórios devem ser preenchidos." });
  }
  const produtosJSON = JSON.stringify(produtos);
  const query = `
    UPDATE orcamentos 
    SET produtos_orcamento = ?, nome_cliente = ?, email_cliente = ?, telefone_cliente = ? 
    WHERE id = ?
  `;
  db.query(query, [produtosJSON, nome_cliente, email, telefone, id], (err, result) => {
    if (err) {
      console.error("Erro ao atualizar orçamento:", err);
      return res.status(500).json({ message: "Erro ao atualizar orçamento." });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Orçamento não encontrado." });
    }
    res.json({ message: "Orçamento atualizado com sucesso!" });
  });
});

app.delete("/orcamentos/:id", verifyToken, async (req, res) => {
  const { id } = req.params;
  const query = "DELETE FROM orcamentos WHERE id = ?";
  db.query(query, [id], (err, result) => {
    if (err) {
      console.error("Erro ao deletar orçamento:", err);
      return res.status(500).json({ message: "Erro ao deletar orçamento." });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Orçamento não encontrado." });
    }
    res.json({ message: "Orçamento deletado com sucesso!" });
  });
});

/*-----------------------------------------
  Rotas de USUÁRIOS
-----------------------------------------*/
app.get("/users", verifyToken, (req, res) => {
  const query = "SELECT id, name, email, pass, photo FROM users";
  db.query(query, [], (err, results) => {
    if (err) {
      console.error("Erro ao buscar usuários:", err);
      return res.status(500).json({ message: "Erro ao buscar usuários." });
    }
    res.json(results);
  });
});

app.post("/users", verifyToken, async (req, res) => {
  const { name, email, pass, photo } = req.body;
  if (!name || !email || !pass) {
    return res.status(400).json({ message: "Todos os campos obrigatórios devem ser preenchidos." });
  }
  const hashedPassword = await bcrypt.hash(pass, 10);
  const query = "INSERT INTO users (name, email, pass, photo) VALUES (?, ?, ?, ?)";
  db.query(query, [name, email, hashedPassword, photo || ""], (err, result) => {
    if (err) {
      console.error("Erro ao criar usuário:", err);
      return res.status(500).json({ message: "Erro ao criar usuário." });
    }
    res.json({ message: "Usuário criado com sucesso!", id: result.insertId });
  });
});

app.put("/users/:id", verifyToken, async (req, res) => {
  const { name, email, photo } = req.body;
  const { id } = req.params;


    // Se não houver um valor válido para a senha, não atualiza o campo pass
    const query = "UPDATE users SET name = ?, email = ?, photo = ? WHERE id = ?";
    const params = [name, email, photo, id];

    db.query(query, params, (err, result) => {
      if (err) {
        console.error("Erro ao atualizar usuário:", err);
        return res.status(500).json({ message: "Erro ao atualizar usuário." });
      }
      res.json({ message: "Usuário atualizado com sucesso!" });
    });
  
});


app.delete("/users/:id", verifyToken, (req, res) => {
  const { id } = req.params;
  const query = "DELETE FROM users WHERE id = ?";
  db.query(query, [id], (err, result) => {
    if (err) {
      console.error("Erro ao deletar usuário:", err);
      return res.status(500).json({ message: "Erro ao deletar usuário." });
    }
    res.json({ message: "Usuário deletado com sucesso!" });
  });
});

/*-----------------------------------------
  Rotas de PRODUTOS e IMAGENS
-----------------------------------------*/
// Remover imagem de um produto (rota protegida)
app.delete("/produtos/imagens", verifyToken, (req, res) => {
  const { productId, imagePath } = req.body;
  const query = "DELETE FROM produto_imagens WHERE produto_id = ? AND imagem = ?";
  db.query(query, [productId, imagePath], (err, result) => {
    if (err) {
      console.error("Erro ao remover a imagem:", err);
      return res.status(500).json({ message: "Erro ao remover a imagem." });
    }
    res.json({ message: "Imagem removida com sucesso!" });
  });
});

// Buscar produtos (Admin)
app.get("/produtos/admin", (req, res) => {
  const query = `
    SELECT 
      p.*, 
      GROUP_CONCAT(t.nome) AS tipos
    FROM produto p
    LEFT JOIN produto_tipo pt ON p.id = pt.produto_id
    LEFT JOIN tipo t ON pt.tipo_id = t.id
    GROUP BY p.id
  `;
  db.query(query, [], (err, results) => {
    if (err) {
      console.error("Erro ao buscar produtos (admin):", err);
      return res.status(500).json({ message: "Erro ao buscar produtos." });
    }
    res.json(results);
  });
});

// Buscar produtos para o front
app.get("/produtos", (req, res) => {
  const query = `
    SELECT 
      p.*, 
      GROUP_CONCAT(t.nome) AS tipos
    FROM produto p
    LEFT JOIN produto_tipo pt ON p.id = pt.produto_id
    LEFT JOIN tipo t ON pt.tipo_id = t.id
    GROUP BY p.id
  `;
  db.query(query, [], (err, results) => {
    if (err) {
      console.error("Erro ao buscar produtos:", err);
      return res.status(500).json({ message: "Erro ao buscar produtos." });
    }
    res.json(results);
  });
});

// Buscar produto por id (rota protegida), com imagens
app.get("/produtos/:id", verifyToken, (req, res) => {
  const { id } = req.params;
  const query = `
    SELECT 
      p.*, 
      GROUP_CONCAT(pi.imagem) AS imagens
    FROM produto p
    LEFT JOIN produto_imagens pi ON pi.produto_id = p.id
    WHERE p.id = ?
    GROUP BY p.id
  `;
  db.query(query, [id], (err, results) => {
    if (err) {
      console.error("Erro ao buscar produto:", err);
      return res.status(500).json({ message: "Erro ao buscar produto." });
    }
    if (results.length > 0) {
      const produto = results[0];
      produto.imagens = produto.imagens ? produto.imagens.split(",") : [];
      res.json(produto);
    } else {
      res.status(404).json({ message: "Produto não encontrado." });
    }
  });
});

// Buscar imagens de um produto
app.get("/produtos/:id/imagens", (req, res) => {
  const { id } = req.params;
  const query = "SELECT imagem FROM produto_imagens WHERE produto_id = ? ORDER BY ordem";
  db.query(query, [id], (err, results) => {
    if (err) {
      console.error("Erro ao buscar imagens do produto:", err);
      return res.status(500).json({ message: "Erro ao buscar imagens do produto." });
    }
    const imagens = results.map((row) => row.imagem);
    res.json(imagens);
  });
});

// Adicionar um novo produto (rota protegida)
app.post("/produtos", verifyToken, (req, res) => {
  const {
    nome,
    largura,
    comprimento,
    tipos,
    descricao,
    especificacoes,
    principais_aplicacoes,
    vantagens,
    imagens,
  } = req.body;
  if (!nome || !largura || !comprimento || !tipos || !descricao) {
    return res.status(400).json({ message: "Todos os campos obrigatórios devem ser preenchidos." });
  }
  // Insere também o campo imagem, aqui passando "" como valor padrão
  const queryProduto = `
    INSERT INTO produto (nome, largura, comprimento, descricao, especificacoes, principais_aplicacoes, vantagens, imagem)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
  `;
  db.query(
    queryProduto,
    [nome, largura, comprimento, descricao, especificacoes, principais_aplicacoes, vantagens, ""],
    (err, result) => {
      if (err) {
        console.error("Erro ao adicionar produto:", err);
        return res.status(500).json({ message: "Erro ao adicionar produto." });
      }
      const produtoId = result.insertId;
      // Inserção das associações de tipos:
      const valuesTipos = tipos.map((tipoId) => [produtoId, tipoId]);
      const placeholdersTipos = valuesTipos.map(() => "(?, ?)").join(", ");
      const flattenedTipos = valuesTipos.flat();
      const queryProdutoTipo = `INSERT INTO produto_tipo (produto_id, tipo_id) VALUES ${placeholdersTipos}`;
      db.query(queryProdutoTipo, flattenedTipos, (err2) => {
        if (err2) {
          console.error("Erro ao associar tipos ao produto:", err2);
          return res.status(500).json({ message: "Erro ao associar tipos ao produto." });
        }
        if (imagens && imagens.length > 0) {
          const valuesImagens = imagens.map((img, index) => [produtoId, img, index + 1]);
          const placeholdersImagens = valuesImagens.map(() => "(?, ?, ?)").join(", ");
          const flattenedImagens = valuesImagens.flat();
          const queryImagens = `INSERT INTO produto_imagens (produto_id, imagem, ordem) VALUES ${placeholdersImagens}`;
          db.query(queryImagens, flattenedImagens, (err3) => {
            if (err3) {
              console.error("Erro ao inserir imagens do produto:", err3);
              return res.status(500).json({ message: "Erro ao inserir imagens do produto." });
            }
            res.json({ message: "Produto adicionado com sucesso!", id: produtoId });
          });
        } else {
          res.json({ message: "Produto adicionado com sucesso!", id: produtoId });
        }
      });
    }
  );
});

// Atualizar produto (rota protegida)
app.put("/produtos/:id", verifyToken, (req, res) => {
  const {
    nome,
    largura,
    comprimento,
    tipos,
    descricao,
    especificacoes,
    principais_aplicacoes,
    vantagens,
    imagens,
  } = req.body;
  const { id } = req.params;
  const queryProduto = `
    UPDATE produto 
    SET nome = ?, largura = ?, comprimento = ?, descricao = ?, especificacoes = ?, principais_aplicacoes = ?, vantagens = ?
    WHERE id = ?
  `;
  db.query(queryProduto, [nome, largura, comprimento, descricao, especificacoes, principais_aplicacoes, vantagens, id], (err, result) => {
    if (err) {
      console.error("Erro ao atualizar produto:", err);
      return res.status(500).json({ message: "Erro ao atualizar produto." });
    }
    const queryDeleteAssoc = "DELETE FROM produto_tipo WHERE produto_id = ?";
    db.query(queryDeleteAssoc, [id], (err2) => {
      if (err2) {
        console.error("Erro ao atualizar associações de tipos:", err2);
        return res.status(500).json({ message: "Erro ao atualizar associações de tipos." });
      }
      if (tipos && tipos.length > 0) {
        const valuesTipos = tipos.map((tipoId) => [id, tipoId]);
        const placeholdersTipos = valuesTipos.map(() => "(?, ?)").join(", ");
        const flattenedTipos = valuesTipos.flat();
        const queryInsertAssoc = `INSERT INTO produto_tipo (produto_id, tipo_id) VALUES ${placeholdersTipos}`;
        db.query(queryInsertAssoc, flattenedTipos, (err3) => {
          if (err3) {
            console.error("Erro ao inserir novas associações de tipos:", err3);
            return res.status(500).json({ message: "Erro ao inserir novas associações de tipos." });
          }
          if (imagens && imagens.length > 0) {
            const queryDeleteImagens = "DELETE FROM produto_imagens WHERE produto_id = ?";
            db.query(queryDeleteImagens, [id], (err4) => {
              if (err4) {
                console.error("Erro ao atualizar imagens do produto:", err4);
                return res.status(500).json({ message: "Erro ao atualizar imagens do produto." });
              }
              const valuesImagens = imagens.map((img, index) => [id, img, index + 1]);
              const placeholdersImagens = valuesImagens.map(() => "(?, ?, ?)").join(", ");
              const flattenedImagens = valuesImagens.flat();
              const queryInsertImagens = `INSERT INTO produto_imagens (produto_id, imagem, ordem) VALUES ${placeholdersImagens}`;
              db.query(queryInsertImagens, flattenedImagens, (err5) => {
                if (err5) {
                  console.error("Erro ao inserir novas imagens do produto:", err5);
                  return res.status(500).json({ message: "Erro ao inserir novas imagens do produto." });
                }
                res.json({ message: "Produto atualizado com sucesso!" });
              });
            });
          } else {
            res.json({ message: "Produto atualizado com sucesso!" });
          }
        });
      } else {
        res.json({ message: "Produto atualizado com sucesso!" });
      }
    });
  });
});

// Deletar produto (rota protegida)
app.delete("/produtos/:id", verifyToken, (req, res) => {
  const { id } = req.params;
  const queryDeleteAssoc = "DELETE FROM produto_tipo WHERE produto_id = ?";
  db.query(queryDeleteAssoc, [id], (err, result) => {
    if (err) {
      console.error("Erro ao deletar associações do produto:", err);
      return res.status(500).json({ message: "Erro ao deletar associações do produto." });
    }
    const queryDeleteProduto = "DELETE FROM produto WHERE id = ?";
    db.query(queryDeleteProduto, [id], (err2, result2) => {
      if (err2) {
        console.error("Erro ao deletar produto:", err2);
        return res.status(500).json({ message: "Erro ao deletar produto." });
      }
      res.json({ message: "Produto deletado com sucesso!" });
    });
  });
});

/*-----------------------------------------
  Outras Rotas
-----------------------------------------*/
// Rota para buscar arquivos
app.get("/arquivos", (req, res) => {
  const query = "SELECT * FROM arquivos";
  db.query(query, [], (err, results) => {
    if (err) {
      console.error("Erro ao buscar arquivos:", err);
      return res.status(500).send("Erro ao buscar arquivos.");
    }
    res.json(results);
  });
});

// Rota de login
app.post("/auth/login", (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ message: "Email e senha são obrigatórios." });
  }
  const query = "SELECT * FROM users WHERE email = ?";
  db.query(query, [email], async (err, results) => {
    if (err) {
      console.error("Erro ao buscar usuário:", err);
      return res.status(500).json({ message: "Erro ao buscar usuário." });
    }
    if (results.length === 0) {
      return res.status(401).json({ message: "Email ou senha inválidos." });
    }
    const user = results[0];
    const isMatch = password === user.pass || (await bcrypt.compare(password, user.pass));
    if (!isMatch) {
      return res.status(401).json({ message: "Email ou senha inválidos." });
    }
    const token = jwt.sign({ id: user.id, email: user.email }, SECRET_KEY, { expiresIn: "1h" });
    res.json({
      id: user.id,
      name: user.name,
      email: user.email,
      photo: user.photo,
      token: token,
    });
  });
});

// Iniciar o servidor com tratamento de erros
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
}).on("error", (err) => {
  console.error("Falha ao iniciar o servidor:", err);
});
