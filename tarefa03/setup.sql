-- =====================================================================
-- setup.sql - Tarefa 03 (Docker e SGBD) - Desafio 15
-- Script IDEMPOTENTE: recria do zero o banco `biblioteca`, suas tabelas,
-- restrições, usuários com privilégios e a carga de dados.
-- Pode ser executado quantas vezes for necessário: o resultado final é
-- sempre o mesmo, sem erros de "já existe" e sem dados duplicados.
--
-- Executar como root. Opções:
--   a) CloudBeaver (conexão root): abrir o script no editor SQL e usar
--      "Execute script" (Alt+X).
--   b) Terminal, a partir da pasta tarefa03:
--      docker cp setup.sql lab-mariadb:/tmp/setup.sql
--      docker exec lab-mariadb sh -c 'mariadb -uroot -p$MARIADB_ROOT_PASSWORD < /tmp/setup.sql'
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1. Banco de dados (remove e recria do zero)
-- ---------------------------------------------------------------------
DROP DATABASE IF EXISTS biblioteca;

CREATE DATABASE biblioteca
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE biblioteca;

-- ---------------------------------------------------------------------
-- 2. Tabelas e restrições
-- ---------------------------------------------------------------------
CREATE TABLE autores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  pais VARCHAR(50),
  ano_nascimento INT
);

CREATE TABLE livros (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  ano_publicacao INT,
  preco DECIMAL(10,2),
  autor_id INT,
  FOREIGN KEY (autor_id) REFERENCES autores(id)
);

CREATE TABLE emprestimos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  livro_id INT,
  data_emprestimo DATE,
  devolvido BOOLEAN,
  FOREIGN KEY (livro_id) REFERENCES livros(id)
);

-- ---------------------------------------------------------------------
-- 3. Usuários e privilégios (removidos e recriados para garantir
--    senha e privilégios sempre iguais ao definido aqui)
-- ---------------------------------------------------------------------
DROP USER IF EXISTS 'app_biblioteca'@'%';
DROP USER IF EXISTS 'consulta'@'%';
DROP USER IF EXISTS 'relatorios'@'%';

CREATE USER 'app_biblioteca'@'%' IDENTIFIED BY 'AppBib2026!';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.* TO 'app_biblioteca'@'%';

CREATE USER 'consulta'@'%' IDENTIFIED BY 'Consulta2026!';
GRANT SELECT ON biblioteca.* TO 'consulta'@'%';

-- Usuário do Desafio 12 (somente leitura na tabela livros)
CREATE USER 'relatorios'@'%' IDENTIFIED BY 'Relatorios2026!';
GRANT SELECT ON biblioteca.livros TO 'relatorios'@'%';

FLUSH PRIVILEGES;

-- ---------------------------------------------------------------------
-- 4. Carga de dados
-- ---------------------------------------------------------------------
-- 4.1 Carga inicial (passo 9.1)
INSERT INTO autores (id, nome, pais, ano_nascimento) VALUES
(1, 'Machado de Assis',       'Brasil',     1839),
(2, 'Clarice Lispector',      'Brasil',     1920),
(3, 'Gabriel García Márquez', 'Colômbia',   1927),
(4, 'Jane Austen',            'Inglaterra', 1775);

INSERT INTO livros (titulo, ano_publicacao, preco, autor_id) VALUES
('Dom Casmurro',                    1899, 39.90, 1),
('Memórias Póstumas de Brás Cubas', 1881, 45.00, 1),
('A Hora da Estrela',               1977, 32.50, 2),
('Cem Anos de Solidão',             1967, 59.90, 3),
('Orgulho e Preconceito',           1813, 29.90, 4);

-- 4.2 Povoamento expandido (mesmo conteúdo de povoamento.sql)
INSERT INTO autores (id, nome, pais, ano_nascimento) VALUES
(5,  'George Orwell',            'Inglaterra',      1903),
(6,  'Fiódor Dostoiévski',       'Rússia',          1821),
(7,  'Franz Kafka',              'República Tcheca', 1883),
(8,  'Victor Hugo',              'França',          1802),
(9,  'Chimamanda Ngozi Adichie', 'Nigéria',         1977),
(10, 'Haruki Murakami',          'Japão',           1949),
(11, 'Jorge Amado',              'Brasil',          1912),
(12, 'José Saramago',            'Portugal',        1922),
(13, 'Miguel de Cervantes',      'Espanha',         1547),
(14, 'Mary Shelley',             'Inglaterra',      1797);

INSERT INTO livros (titulo, ano_publicacao, preco, autor_id) VALUES
('Quincas Borba',                      1891, 36.90, 1),
('O Alienista',                        1882, 24.90, 1),
('Perto do Coração Selvagem',          1943, 42.00, 2),
('A Paixão Segundo G.H.',              1964, 44.90, 2),
('O Amor nos Tempos do Cólera',        1985, 64.90, 3),
('Crônica de uma Morte Anunciada',     1981, 38.90, 3),
('Razão e Sensibilidade',              1811, 34.90, 4),
('Emma',                               1815, 39.90, 4),
('1984',                               1949, 49.90, 5),
('A Revolução dos Bichos',             1945, 29.90, 5),
('Crime e Castigo',                    1866, 69.90, 6),
('Os Irmãos Karamázov',                1880, 89.90, 6),
('A Metamorfose',                      1915, 27.90, 7),
('O Processo',                         1925, 44.90, 7),
('Os Miseráveis',                      1862, 84.90, 8),
('O Corcunda de Notre-Dame',           1831, 54.90, 8),
('Hibisco Roxo',                       2003, 52.90, 9),
('Americanah',                         2013, 69.90, 9),
('Norwegian Wood',                     1987, 59.90, 10),
('Kafka à Beira-Mar',                  2002, 74.90, 10),
('Capitães da Areia',                  1937, 46.90, 11),
('Gabriela, Cravo e Canela',           1958, 54.90, 11),
('Ensaio sobre a Cegueira',            1995, 62.90, 12),
('O Evangelho Segundo Jesus Cristo',   1991, 66.90, 12),
('Dom Quixote',                        1605, 79.90, 13),
('Frankenstein',                       1818, 34.90, 14);

-- 4.3 Empréstimos (Desafio 7): dois pendentes e um devolvido
INSERT INTO emprestimos (livro_id, data_emprestimo, devolvido) VALUES
(1, '2026-10-20', FALSE),
(4, '2026-10-27', FALSE),
(2, '2026-10-05', TRUE);

-- ---------------------------------------------------------------------
-- 5. Conferência final
-- ---------------------------------------------------------------------
SELECT
  (SELECT COUNT(*) FROM autores)     AS total_autores,      -- 14
  (SELECT COUNT(*) FROM livros)      AS total_livros,       -- 31
  (SELECT COUNT(*) FROM emprestimos) AS total_emprestimos;  -- 3
