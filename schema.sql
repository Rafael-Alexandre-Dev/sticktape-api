-- Habilita foreign keys no SQLite
PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

------------------------------------------
-- Tabela: arquivos
------------------------------------------
CREATE TABLE arquivos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  caminho TEXT NOT NULL
);

INSERT INTO arquivos (id, nome, caminho) VALUES
  (1, 'ACM e Comunicação Visual', '/pdfs/pdf1.pdf'),
  (2, 'Estrutural Glazing', '/pdfs/pdf2.pdf');

------------------------------------------
-- Tabela: orcamentos
------------------------------------------
CREATE TABLE orcamentos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  produtos_orcamento TEXT DEFAULT NULL CHECK (json_valid(produtos_orcamento)),
  nome_cliente TEXT DEFAULT NULL,
  email_cliente TEXT DEFAULT NULL,
  telefone_cliente TEXT DEFAULT NULL
);

INSERT INTO orcamentos (id, produtos_orcamento, nome_cliente, email_cliente, telefone_cliente) VALUES
(5, '[{"id":9,"nome":"Primer para ACM 225ml","descricao":"Promove maior adesão entre a fita adesiva e substratos como ACM, alumínio e vidro. Essencial para fachadas glazing.","especificacoes":null,"principais_aplicacoes":"Utilizado antes da aplicação de fitas em fachadas.","vantagens":"Melhora a afinidade do adesivo, reduz chances de falhas na fixação.","imagem":"/images/acessorio1.png","tipos":"COMPLEMENTO, ACM","quantity":4},{"id":10,"nome":"Álcool Isopropílico (1 litro)","descricao":"Limpa superfícies, removendo óleos, poeira e outros contaminantes para garantir uma adesão ideal.","especificacoes":null,"principais_aplicacoes":"Limpeza de substratos metálicos, vidros e plásticos.","vantagens":"Evita problemas de aderência causados por impurezas.","imagem":"/images/acessorio2.png","tipos":"COMPLEMENTO","quantity":6},{"id":13,"nome":"Primer Silano Fachada Glazing","descricao":"Promove alta adesão em vidros, tornando a superfície hidrofóbica. Indicado para fachadas glazing.","especificacoes":null,"principais_aplicacoes":"Indústria de vidros, fachadas de alto padrão.","vantagens":"Evita descolamentos causados por umidade.","imagem":"/images/acessorio5.png","tipos":"COMPLEMENTO","quantity":6}]', 'teste', 'teste@gmail.com', '(19) 98881-0189'),
(6, '[{"id":26,"nome":"Fita Dupla Face de Espuma Acrílica Branca Estrutural Glazing (2,0mm)","descricao":"Produto desenvolvido para aplicações estruturais, oferecendo alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing.","especificacoes":"Espessura: 2,0mm; espuma acrílica; cor branca; alta resistência à tração, cisalhamento e intempéries, adequada para aplicações estruturais em glazing.","principais_aplicacoes":"Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing.","vantagens":"Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.","imagem":"/images/produto5.png","tipos":"ESTRUTURAL GLAZING","quantity":8},{"id":28,"nome":"Fita Dupla Face de Espuma Acrílica Preto Estrutural Glazing (2,0mm)","descricao":"Produto desenvolvido para aplicações estruturais, proporcionando alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing, com acabamento em preto para um visual sofisticado.","especificacoes":"Espessura: 2,0mm; espuma acrílica; cor preto; alta resistência à tração, cisalhamento e intempéries, projetada para aplicações estruturais em glazing.","principais_aplicacoes":"Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing que requerem acabamento sofisticado.","vantagens":"Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.","imagem":"/images/produto7.png","tipos":"ESTRUTURAL GLAZING","quantity":8}]', 'Camily', 'camily@gmail.com', '(19) 91111-1111'),
(7, '[{"id":18,"nome":"Fita Dupla Face de Espuma Acrílica Branca (1,1mm)","descricao":"Uma solução com foco em fixação de espelhos.","especificacoes":"Espessura de 3,0mm, cor branca, com alta resistência atração, cisalhamento e intempéries (raios UV, umidade e alta temperatura). É especificada para fixação de espelhos considerando a regra de 55cm2 de Fita ST3,0B por kg de espelho.","principais_aplicacoes":"Desenvolvida para fixação de espelhos em superfícies\ncomo porcelanato, paredes de Drywall pintadas, vidros (indoor), etc.","vantagens":"Facilidade de aplicação, não danifica superfícies.","imagem":"/images/produto2.png","tipos":"ACM","quantity":1150}]', 'Laureano', 'teste@gmail.com', '(19) 99151-5181'),
(8, '[{"id":18,"nome":"Fita Dupla Face de Espuma Acrílica Branca (1,1mm)","descricao":"Uma solução com foco em fixação de espelhos.","especificacoes":"Espessura de 1,1mm, cor branca, com alta resistência atração, cisalhamento e intempéries (raios UV, umidade e alta temperatura). É especificada para fixação de espelhos considerando a regra de 55cm2 de Fita ST3,0B por kg de espelho.","principais_aplicacoes":"Desenvolvida para fixação de espelhos em superfícies\ncomo porcelanato, paredes de Drywall pintadas, vidros (indoor), etc.","vantagens":"Facilidade de aplicação, não danifica superfícies.","imagem":"/images/produto2.png","largura":"12MM | 15MM | 19MM","comprimento":"20MT''s","tipos":"ACM","quantity":1},{"id":14,"nome":"Rolete de Pressão para Fita Dupla Face Acrílica Glazing","descricao":"Equipamento que garante adesão uniforme ao eliminar bolhas de ar durante a aplicação da fita.","especificacoes":null,"principais_aplicacoes":"Fachadas glazing, montagens industriais.","vantagens":"Reduz o tempo de instalação e garante acabamento perfeito.","imagem":"/images/acessorio6.png","largura":null,"comprimento":null,"tipos":"COMPLEMENTO, ACM","quantity":2}]', 'rafael', 'teste@gmail.com', '(19) 98881-0189'),
(9, '[{"id":22,"nome":"Fita Dupla Face de Massa Acrílica Transparente (0,5mm)","descricao":"Produto voltado para aplicações onde se requer uma adesão discreta e alta performance, com formulação à base de massa acrílica que alia transparência e flexibilidade.","especificacoes":"Espessura: 0,5mm; composição à base de massa acrílica; transparente; alta resistência à tração, cisalhamento e intempéries.","principais_aplicacoes":"Fixação de elementos decorativos, aplicações em painéis de vidro e superfícies lisas, montagem de itens em ambientes internos.","vantagens":"Aplicação simples e prática, não danifica a superfície, estética discreta e alta performance em condições adversas.","imagem":"/images/produto3.png","largura":"09MM | 12MM | 15MM | 19MM","comprimento":"20MT''s","tipos":"COMUNICAÇÃO VISUAL","quantity":100}]', 'teste', 'teste@gmail.com', '(19) 98881-0899');

------------------------------------------
-- Tabela: produto
------------------------------------------
CREATE TABLE produto (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  descricao TEXT NOT NULL,
  especificacoes TEXT,
  principais_aplicacoes TEXT,
  vantagens TEXT,
  imagem TEXT NOT NULL,
  largura TEXT,
  comprimento TEXT
);

INSERT INTO produto (id, nome, descricao, especificacoes, principais_aplicacoes, vantagens, imagem, largura, comprimento) VALUES
(9, 'Primer para ACM 225ml', 'Promove maior adesão entre a fita adesiva e substratos como ACM, alumínio e vidro. Essencial para fachadas glazing.', NULL, 'Utilizado antes da aplicação de fitas em fachadas.', 'Melhora a afinidade do adesivo, reduz chances de falhas na fixação.', '/images/acessorio1.png', NULL, NULL),
(10, 'Álcool Isopropílico (1 litro)', 'Limpa superfícies, removendo óleos, poeira e outros contaminantes para garantir uma adesão ideal.', NULL, 'Limpeza de substratos metálicos, vidros e plásticos.', 'Evita problemas de aderência causados por impurezas.', '/images/acessorio2.png', NULL, NULL),
(11, 'Alicate de Pressão para Fita Dupla Face Acrílica Glazing', 'Ferramenta indispensável para aplicação uniforme de pressão durante a colagem.', NULL, 'Indústrias de vidro e fachadas.', 'Garante aderência total da fita, reduzindo falhas.', '/images/acessorio3.png', NULL, NULL),
(12, 'Primer para ACM em Fachadas Glazing e Comunicação Visual (960ml)', 'Produto essencial para aumentar a adesão em fachadas de ACM e painéis publicitários.', NULL, 'Pré-tratamento de substratos antes da colagem.', 'Garante fixação confiável em ambientes desafiadores.', '/images/acessorio4.png', NULL, NULL),
(13, 'Primer Silano Fachada Glazing', 'Promove alta adesão em vidros, tornando a superfície hidrofóbica. Indicado para fachadas glazing.', NULL, 'Indústria de vidros, fachadas de alto padrão.', 'Evita descolamentos causados por umidade.', '/images/acessorio5.png', NULL, NULL),
(14, 'Rolete de Pressão para Fita Dupla Face Acrílica Glazing', 'Equipamento que garante adesão uniforme ao eliminar bolhas de ar durante a aplicação da fita.', NULL, 'Fachadas glazing, montagens industriais.', 'Reduz o tempo de instalação e garante acabamento perfeito.', '/images/acessorio6.png', NULL, NULL),
(18, 'Fita Dupla Face de Espuma Acrílica Branca (1,1mm)', 'Fita Dupla Face de Espuma Acrílica com adesivo acrílico de alta performance desenvolvida para fixação em aplicações de longa duração, em revestimentos arquitetônicos e em fachadas de ACM (indoor e outdoor).', 'Espessura de 1,1mm, cor branca.', 'Aplicações de longa duração, tanto interna como externa e revestimentos em ACM.', 'Possui alta resistência aos raios UV, umidade e altas temperaturas.', '/images/produto2.png', '12MM | 15MM | 19MM', '20MT''s'),
(19, 'Fita Dupla Face de Espuma Acrílica Branca (1,6mm)', 'Uma solução versátil para diversas aplicações industriais e domésticas. Com excelente adesão e resistência ao descolamento.', 'Espessura de 1,6mm, cor branca, resistente a temperaturas elevadas.', 'Fixação de placas decorativas, letras de sinalização e pequenos componentes.', 'Facilidade de aplicação, não danifica superfícies.', '/images/produto2.png', '12MM | 15MM | 19MM', '20MT''s'),
(20, 'Fita Dupla Face de Espuma Acrílica Branca (2,4mm)', 'Uma solução versátil para diversas aplicações industriais e domésticas. Com excelente adesão e resistência ao descolamento.', 'Espessura de 2,4mm, cor branca, resistente a temperaturas elevadas.', 'Fixação de placas decorativas, letras de sinalização e pequenos componentes.', 'Facilidade de aplicação, não danifica superfícies.', '/images/produto2.png', '12MM | 15MM | 19MM', '20MT''s'),
(21, 'Fita Dupla Face de Espuma Acrílica Branca (3,0mm)', 'Uma solução versátil para diversas aplicações industriais e domésticas. Com excelente adesão e resistência ao descolamento.', 'Espessura de 3,0mm, cor branca, com alta resistência atração, cisalhamento e intempéries (raios UV, umidade e alta temperatura). É especificada para fixação de espelhos considerando a regra de 55cm2 de Fita ST300B por kg de espelho.', 'Fixação de placas decorativas, letras de sinalização e pequenos componentes.', 'Facilidade de aplicação, não danifica superfícies.', '/images/produto2.png', '12MM | 15MM | 19MM', '20MT''s'),
(22, 'Fita Dupla Face de Massa Acrílica Transparente (0,5mm)', 'Produto voltado para aplicações onde se requer uma adesão discreta e alta performance, com formulação à base de massa acrílica que alia transparência e flexibilidade.', 'Espessura: 0,5mm; composição à base de massa acrílica; transparente; alta resistência à tração, cisalhamento e intempéries.', 'Fixação de elementos decorativos, aplicações em painéis de vidro e superfícies lisas, montagem de itens em ambientes internos.', 'Aplicação simples e prática, não danifica a superfície, estética discreta e alta performance em condições adversas.', '/images/produto3.png', '09MM | 12MM | 15MM | 19MM', '20MT''s'),
(23, 'Fita Dupla Face de Massa Acrílica Transparente (0,9mm)', 'Produto voltado para aplicações onde se requer uma adesão discreta e alta performance, com formulação à base de massa acrílica que alia transparência e flexibilidade.', 'Espessura: 0,9mm; composição à base de massa acrílica; transparente; alta resistência à tração, cisalhamento e intempéries.', 'Fixação de elementos decorativos, aplicações em painéis de vidro e superfícies lisas, montagem de itens em ambientes internos.', 'Aplicação simples e prática, não danifica a superfície, estética discreta e alta performance em condições adversas.', '/images/produto3.png', '09MM | 12MM | 15MM | 19MM', '20MT''s'),
(24, 'Fita Dupla Face de Massa Acrílica Transparente (1,0mm)', 'Produto voltado para aplicações onde se requer uma adesão discreta e alta performance, com formulação à base de massa acrílica que alia transparência e flexibilidade.', 'Espessura: 1,0mm; composição à base de massa acrílica; transparente; alta resistência à tração, cisalhamento e intempéries.', 'Fixação de elementos decorativos, aplicações em painéis de vidro e superfícies lisas, montagem de itens em ambientes internos.', 'Aplicação simples e prática, não danifica a superfície, estética discreta e alta performance em condições adversas.', '/images/produto3.png', '09MM | 12MM | 15MM | 19MM', '20MT''s'),
(25, 'Fita Dupla Face de Massa Acrílica Poliéster Transparente (0,02mm)', 'Produto de alta performance que combina massa acrílica com poliéster, proporcionando uma adesão robusta e discreta, ideal para aplicações que requerem transparência.', 'Espessura: 0,02mm; composto por massa acrílica e poliéster; transparente; alta resistência à tração, cisalhamento e intempéries.', 'Fixação de itens decorativos, montagem de painéis de vidro e aplicações em superfícies lisas onde a estética é essencial.', 'Fácil aplicação, não danifica superfícies e oferece alta performance em ambientes desafiadores.', '/images/produto4.png', '09MM | 12MM | 15MM | 19MM', '20MT''s'),
(26, 'Fita Dupla Face de Espuma Acrílica Branca Estrutural Glazing (2,0mm)', 'Produto desenvolvido para aplicações estruturais, oferecendo alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing.', 'Espessura: 2,0mm; espuma acrílica; cor branca; alta resistência à tração, cisalhamento e intempéries, adequada para aplicações estruturais em glazing.', 'Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing.', 'Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.', '/images/produto5.png', '19MM | 25MM', '20MT''s'),
(27, 'Fita Dupla Face de Espuma Acrílica Cinza Estrutural Glazing (2,0mm)', 'Produto desenvolvido para aplicações estruturais, oferecendo alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing, agora na cor cinza para um acabamento discreto.', 'Espessura: 2,0mm; espuma acrílica; cor cinza; alta resistência à tração, cisalhamento e intempéries, adequada para aplicações estruturais em glazing.', 'Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing com acabamento em cinza.', 'Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.', '/images/produto6.png', '19MM | 25MM', '20MT''s'),
(28, 'Fita Dupla Face de Espuma Acrílica Preta Estrutural Glazing (2,0mm)', 'Produto desenvolvido para aplicações estruturais, proporcionando alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing, com acabamento em preto para um visual sofisticado.', 'Espessura: 2,0mm; espuma acrílica; cor preto; alta resistência à tração, cisalhamento e intempéries, projetada para aplicações estruturais em glazing.', 'Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing que requerem acabamento sofisticado.', 'Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.', '/images/produto7.png', '19MM | 25MM', '20MT''s'),
(29, 'Fita Dupla Face de Espuma Acrílica Branca Estrutural Glazing (3,5mm)', 'Produto desenvolvido para aplicações estruturais, oferecendo alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing.', 'Espessura: 3,5mm; espuma acrílica; cor branca; alta resistência à tração, cisalhamento e intempéries, adequada para aplicações estruturais em glazing.', 'Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing.', 'Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.', '/images/produto5.png', '19MM | 25MM', '20MT''s'),
(30, 'Fita Dupla Face de Espuma Acrílica Cinza Estrutural Glazing (3,5mm)', 'Produto desenvolvido para aplicações estruturais, oferecendo alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing, agora na cor cinza para um acabamento discreto.', 'Espessura: 3,5mm; espuma acrílica; cor cinza; alta resistência à tração, cisalhamento e intempéries, adequada para aplicações estruturais em glazing.', 'Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing com acabamento em cinza.', 'Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.', '/images/produto6.png', '19MM | 25MM', '20MT''s'),
(31, 'Fita Dupla Face de Espuma Acrílica Preta Estrutural Glazing (3,5mm)', 'Produto desenvolvido para aplicações estruturais, oferecendo alta adesão e resistência, ideal para fixação de vidros e montagem de painéis em projetos de glazing, agora na cor preta para um acabamento discreto.', 'Espessura: 3,5mm; espuma acrílica; cor preta; alta resistência à tração, cisalhamento e intempéries, adequada para aplicações estruturais em glazing.', 'Fixação de vidros, montagem de painéis estruturais e aplicações em fachadas e projetos de glazing com acabamento em preta.', 'Fácil aplicação, desempenho estrutural superior, não danifica as superfícies e garante alta durabilidade mesmo sob condições adversas.', '/images/produto6.png', '19MM | 25MM', '20MT''s');

------------------------------------------
-- Tabela: produto_imagens
------------------------------------------
CREATE TABLE produto_imagens (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  produto_id INTEGER NOT NULL,
  imagem TEXT NOT NULL,
  ordem INTEGER DEFAULT 0,
  FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE CASCADE
);

INSERT INTO produto_imagens (id, produto_id, imagem, ordem) VALUES
(33, 9, '/images/files-1740401730977-942871733.png', 1),
(34, 10, '/images/files-1740401740160-519178090.png', 1),
(35, 11, '/images/files-1740401756836-347090385.png', 1),
(36, 12, '/images/files-1740401774603-420166220.png', 1),
(37, 13, '/images/files-1740401788373-563023524.png', 1),
(38, 14, '/images/files-1740401799382-455996461.png', 1),
(217, 19, '/images/files-1740012794815-539128340.jpg', 1),
(218, 19, '/images/files-1740012794909-686256600.jpg', 2),
(219, 19, '/images/files-1740012794989-593622768.jpg', 3),
(220, 19, '/images/files-1740012795033-913381316.jpg', 4),
(221, 20, '/images/files-1740012785062-335407460.jpg', 1),
(222, 20, '/images/files-1740012785190-138421960.jpg', 2),
(223, 20, '/images/files-1740012785239-482678777.jpg', 3),
(224, 20, '/images/files-1740012785299-748267162.jpg', 4),
(229, 22, '/images/files-1740403272430-835203080.jpg', 1),
(230, 22, '/images/files-1740403272463-408893665.jpg', 2),
(231, 22, '/images/files-1740403272511-301077835.jpg', 3),
(232, 22, '/images/files-1740403272566-356124222.jpg', 4),
(233, 22, '/images/files-1740403272608-858847476.jpg', 5),
(234, 23, '/images/files-1740402515219-529084938.jpg', 1),
(235, 23, '/images/files-1740402515248-808350049.jpg', 2),
(236, 23, '/images/files-1740402515286-45789153.jpg', 3),
(237, 23, '/images/files-1740402515340-925843138.jpg', 4),
(238, 23, '/images/files-1740402515385-757855552.jpg', 5),
(239, 24, '/images/files-1740402534210-956912978.jpg', 1),
(240, 24, '/images/files-1740402534248-721963114.jpg', 2),
(241, 24, '/images/files-1740402534289-944044917.jpg', 3),
(242, 24, '/images/files-1740402534359-293586494.jpg', 4),
(243, 24, '/images/files-1740402534411-36774242.jpg', 5),
(244, 25, '/images/files-1740592745230-22434884.jpg', 1),
(245, 25, '/images/files-1740592745277-920830205.jpg', 2),
(246, 25, '/images/files-1740592745325-777574797.jpg', 3),
(247, 25, '/images/files-1740592745369-756515613.jpg', 4),
(248, 25, '/images/files-1740592745415-77584634.jpg', 5),
(249, 25, '/images/files-1740592745471-118043637.jpg', 6),
(250, 25, '/images/files-1740592745525-159722107.jpg', 7),
(251, 26, '/images/files-1740593957466-157626285.jpg', 1),
(252, 26, '/images/files-1740593957527-788902853.jpg', 2),
(253, 26, '/images/files-1740593957571-1546965.jpg', 3),
(254, 26, '/images/files-1740593957601-180177439.jpg', 4),
(255, 26, '/images/files-1740593957646-339250263.jpg', 5),
(256, 26, '/images/files-1740593957700-824572286.jpg', 6),
(257, 26, '/images/files-1740593957724-761812839.jpg', 7),
(258, 27, '/images/files-1740594058570-217518631.jpg', 1),
(259, 27, '/images/files-1740594058631-630623455.jpg', 2),
(260, 27, '/images/files-1740594058725-386936660.jpg', 3),
(261, 27, '/images/files-1740594058819-573149003.jpg', 4),
(262, 27, '/images/files-1740594058869-168861968.jpg', 5),
(263, 27, '/images/files-1740594058932-963570512.jpg', 6),
(264, 28, '/images/files-1740594165091-395288101.jpg', 1),
(265, 28, '/images/files-1740594165201-496730625.jpg', 2),
(266, 28, '/images/files-1740594165277-847816797.jpg', 3),
(267, 28, '/images/files-1740594165369-304690469.jpg', 4),
(268, 28, '/images/files-1740594165440-401657098.jpg', 5),
(269, 28, '/images/files-1740594165525-273236206.jpg', 6),
(270, 29, '/images/files-1740594021356-956588494.jpg', 1),
(271, 29, '/images/files-1740594021417-257955368.jpg', 2),
(272, 29, '/images/files-1740594021454-587621823.jpg', 3),
(273, 29, '/images/files-1740594021503-5386333.jpg', 4),
(274, 29, '/images/files-1740594021561-332205267.jpg', 5),
(275, 29, '/images/files-1740594021602-531017760.jpg', 6),
(276, 29, '/images/files-1740594021641-825932146.jpg', 7),
(277, 29, '/images/files-1740594021668-390284326.jpg', 8),
(278, 30, '/images/files-1740594098595-754530086.jpg', 1),
(279, 30, '/images/files-1740594098649-274780923.jpg', 2),
(280, 30, '/images/files-1740594098710-848217054.jpg', 3),
(281, 30, '/images/files-1740594098753-628539949.jpg', 4),
(282, 30, '/images/files-1740594098783-922755192.jpg', 5),
(283, 30, '/images/files-1740594098823-391320486.jpg', 6),
(284, 31, '/images/files-1740594204926-861129999.jpg', 1),
(285, 31, '/images/files-1740594205002-777662440.jpg', 2),
(286, 31, '/images/files-1740594205042-451240588.jpg', 3),
(287, 31, '/images/files-1740594205091-96014580.jpg', 4),
(288, 31, '/images/files-1740594205156-710188731.jpg', 5),
(289, 31, '/images/files-1740594205213-611564063.jpg', 6),
(294, 21, '/images/files-1740012770351-694680588.jpg', 1),
(295, 21, '/images/files-1740012770456-772236402.jpg', 2),
(296, 21, '/images/files-1740012770499-119773080.jpg', 3),
(297, 21, '/images/files-1740012770549-974982397.jpg', 4),
(306, 18, '/images/files-1740012803789-125623270.jpg', 1),
(307, 18, '/images/files-1740012803847-740058834.jpg', 2),
(308, 18, '/images/files-1740012803892-703866859.jpg', 3),
(309, 18, '/images/files-1740012803925-638787588.jpg', 4);

------------------------------------------
-- Tabela: tipo
------------------------------------------
CREATE TABLE tipo (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL
);

INSERT INTO tipo (id, nome) VALUES
  (1, 'COMPLEMENTO'),
  (2, 'ACM'),
  (3, 'COMUNICAÇÃO VISUAL'),
  (4, 'ESTRUTURAL GLAZING');

------------------------------------------
-- Tabela: produto_tipo
------------------------------------------
CREATE TABLE produto_tipo (
  produto_id INTEGER NOT NULL,
  tipo_id INTEGER NOT NULL,
  PRIMARY KEY (produto_id, tipo_id),
  FOREIGN KEY (produto_id) REFERENCES produto(id),
  FOREIGN KEY (tipo_id) REFERENCES tipo(id)
);

INSERT INTO produto_tipo (produto_id, tipo_id) VALUES
(9, 1),
(9, 2),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(14, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 4),
(27, 4),
(28, 4),
(29, 4),
(30, 4),
(31, 4);

------------------------------------------
-- Tabela: users
------------------------------------------
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  pass TEXT NOT NULL,
  photo TEXT
);

INSERT INTO users (id, name, email, pass, photo) VALUES
  (4, 'Rafael Alexandre Jesus', 'rafaeljesusalexandre@gmail.com', '$2a$10$vaoyRE6dnAbDAOpvnHtyCOCIor.FAB7MeDtKkBKIWNO5ek7aaUKwK', '/images/file-1738617254107-327302657.jpeg'),
  (12, 'teste', 'teste@gmail.com', '$2a$10$xCBRbBy8oLmY7Zmjm5g2m.bQmR7NJHlGSM7r7gM65M4QM2ejnvtmq', '/images/file-1738616142788-934804164.jpg');

------------------------------------------
-- Índices extras
------------------------------------------
CREATE INDEX idx_produto_imagens_produto_id ON produto_imagens(produto_id);
CREATE INDEX idx_produto_tipo_tipo_id ON produto_tipo(tipo_id);

COMMIT;
