-- Desafios 12 a 14 - Bloco C: Administração e Privilégios
-- Atenção ao usuário indicado em cada parte.
-- Conexão do usuário relatorios no CloudBeaver:
--   host mariadb, porta 3306, banco biblioteca,
--   usuário relatorios, senha Relatorios2026!

-- =====================================================================
-- Desafio 12 - executar como: root
-- =====================================================================
CREATE USER 'relatorios'@'%' IDENTIFIED BY 'Relatorios2026!';
GRANT SELECT ON biblioteca.livros TO 'relatorios'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'relatorios'@'%';

-- =====================================================================
-- Desafio 13 - executar como: relatorios
-- =====================================================================
SELECT * FROM biblioteca.livros;    -- funciona
SELECT * FROM biblioteca.autores;   -- deve FALHAR
-- Erro esperado: SQL Error [1142] [42000]: SELECT command denied to user
--   'relatorios'@'...' for table `biblioteca`.`autores`

-- =====================================================================
-- Desafio 14 - parte 1, executar como: root
-- =====================================================================
GRANT INSERT ON biblioteca.livros TO 'relatorios'@'%';
SHOW GRANTS FOR 'relatorios'@'%';

-- Desafio 14 - parte 2, executar como: relatorios (deve FUNCIONAR)
INSERT INTO biblioteca.livros (titulo, ano_publicacao, preco, autor_id)
VALUES ('Livro Teste Relatorios 1', 2026, 10.00, 1);

-- Desafio 14 - parte 3, executar como: root
REVOKE INSERT ON biblioteca.livros FROM 'relatorios'@'%';
SHOW GRANTS FOR 'relatorios'@'%';

-- Desafio 14 - parte 4, executar como: relatorios (deve FALHAR)
INSERT INTO biblioteca.livros (titulo, ano_publicacao, preco, autor_id)
VALUES ('Livro Teste Relatorios 2', 2026, 10.00, 1);
-- Erro esperado: SQL Error [1142] [42000]: INSERT command denied to user
--   'relatorios'@'...' for table `biblioteca`.`livros`

-- Desafio 14 - limpeza opcional, executar como: root
-- DELETE FROM biblioteca.livros WHERE titulo = 'Livro Teste Relatorios 1';
