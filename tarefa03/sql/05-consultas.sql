-- Passo 10 - Consultas obrigatórias
-- Executar como: root, app_biblioteca ou consulta
-- Execute uma por vez (Ctrl+Enter com o cursor na consulta).

USE biblioteca;

-- Consulta 1: todos os livros
SELECT * FROM livros;

-- Consulta 2: título e ano, do mais recente para o mais antigo
SELECT titulo, ano_publicacao
FROM livros
ORDER BY ano_publicacao DESC;

-- Consulta 3: livros publicados antes de 1900
SELECT *
FROM livros
WHERE ano_publicacao < 1900;

-- Consulta 4: título, autor e preço (INNER JOIN)
SELECT l.titulo, a.nome AS autor, l.preco
FROM livros l
JOIN autores a ON l.autor_id = a.id;

-- Consulta 5: preço médio por autor (GROUP BY + AVG)
SELECT a.nome AS autor, AVG(l.preco) AS preco_medio
FROM autores a
JOIN livros l ON a.id = l.autor_id
GROUP BY a.id, a.nome;

-- Consulta 6: livros acima da média geral de preço (subconsulta)
SELECT *
FROM livros
WHERE preco > (SELECT AVG(preco) FROM livros);

-- Pergunta 4: teste de integridade referencial (deve FALHAR com erro 1452)
INSERT INTO livros (titulo, ano_publicacao, preco, autor_id)
VALUES ('Livro de Autor Inexistente', 2020, 10.00, 999);
