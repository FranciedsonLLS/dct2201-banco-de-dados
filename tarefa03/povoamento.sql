-- =====================================================================
-- povoamento.sql - Tarefa 03 (Docker e SGBD)
-- Povoamento expandido do banco `biblioteca` (passo 9.2 do roteiro),
-- gerado com ferramenta de IA generativa a partir do prompt do roteiro.
--
-- Pré-requisito: carga inicial do passo 9.1 já executada
-- (autores 1 a 4 e livros 1 a 5).
-- Execute UMA única vez (rodar de novo gera erro de chave duplicada
-- nos autores e duplica os livros).
--
-- Resultado esperado: 14 autores e 31 livros no total.
-- =====================================================================

SET NAMES utf8mb4;
USE biblioteca;

-- 10 novos autores (IDs 5 a 14) informados de forma explícita para que
-- os livros abaixo apontem sempre para o autor correto.
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

-- 26 novos livros (novos autores e também os autores 1 a 4).
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

-- Conferência:
SELECT COUNT(*) AS total_autores FROM autores;  -- esperado: 14
SELECT COUNT(*) AS total_livros  FROM livros;   -- esperado: 31
