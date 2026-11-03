-- Passo 8.3 - Demonstração do menor privilégio (erro 1142)
-- Executar como: app_biblioteca  (nova conexão no CloudBeaver:
--   host mariadb, porta 3306, banco biblioteca,
--   usuário app_biblioteca, senha AppBib2026!)

DROP TABLE autores;

-- Erro esperado (copie a mensagem exata para o relatório):
-- SQL Error [1142] [42000]: DROP command denied to user 'app_biblioteca'@'...' for table `biblioteca`.`autores`
