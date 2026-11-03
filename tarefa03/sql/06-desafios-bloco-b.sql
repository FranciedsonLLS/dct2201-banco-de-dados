-- Desafios 6 a 11 - Bloco B: Modelagem e Consultas SQL Básicas
-- Executar como: root (o Desafio 6 é DDL; app_biblioteca não tem esse privilégio)

USE biblioteca;

-- Desafio 6: tabela de empréstimos com chave estrangeira para livros
CREATE TABLE IF NOT EXISTS emprestimos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  livro_id INT,
  data_emprestimo DATE,
  devolvido BOOLEAN,
  FOREIGN KEY (livro_id) REFERENCES livros(id)
);

-- Desafio 7: três empréstimos (dois pendentes e um devolvido)
INSERT INTO emprestimos (livro_id, data_emprestimo, devolvido) VALUES
(1, '2026-10-20', FALSE),  -- Dom Casmurro (pendente)
(4, '2026-10-27', FALSE),  -- Cem Anos de Solidão (pendente)
(2, '2026-10-05', TRUE);   -- Memórias Póstumas de Brás Cubas (devolvido)

SELECT * FROM emprestimos;

-- Desafio 8: empréstimos pendentes com título, data e autor
SELECT l.titulo, e.data_emprestimo, a.nome AS autor
FROM emprestimos e
JOIN livros  l ON e.livro_id = l.id
JOIN autores a ON l.autor_id = a.id
WHERE e.devolvido = FALSE;

-- Desafio 9: autores com mais de 1 livro (HAVING)
SELECT a.nome AS autor, COUNT(*) AS total_livros
FROM autores a
JOIN livros l ON l.autor_id = a.id
GROUP BY a.id, a.nome
HAVING COUNT(*) > 1;

-- Desafio 10: reajuste de 10% no preço de um livro (Dom Casmurro, id 1)
SELECT id, titulo, preco FROM livros WHERE id = 1;   -- antes: 39.90
UPDATE livros SET preco = ROUND(preco * 1.10, 2) WHERE id = 1;
SELECT id, titulo, preco FROM livros WHERE id = 1;   -- depois: 43.89

-- Desafio 11: autor sem livros, depois removido
INSERT INTO autores (nome, pais, ano_nascimento)
VALUES ('Autor Teste Sem Livros', 'Brasil', 2000);
SELECT * FROM autores WHERE nome = 'Autor Teste Sem Livros';

DELETE FROM autores WHERE nome = 'Autor Teste Sem Livros';
SELECT * FROM autores WHERE nome = 'Autor Teste Sem Livros';  -- 0 linhas
