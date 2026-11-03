-- Passo 8.1 e 8.2 - Usuários e privilégios
-- Executar como: root

CREATE USER 'app_biblioteca'@'%' IDENTIFIED BY 'AppBib2026!';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.* TO 'app_biblioteca'@'%';

CREATE USER 'consulta'@'%' IDENTIFIED BY 'Consulta2026!';
GRANT SELECT ON biblioteca.* TO 'consulta'@'%';

FLUSH PRIVILEGES;

-- 8.2 Inspeção (copie as duas saídas para o relatório)
SHOW GRANTS FOR 'app_biblioteca'@'%';
SHOW GRANTS FOR 'consulta'@'%';
