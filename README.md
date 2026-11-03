# dct2201-banco-de-dados

Repositório pessoal da disciplina **DCT2201 - Banco de Dados** (Sistemas de Informação - CERES/UFRN, 2026.2).

**Discente:** Franciedson Lucas Linhares da Silva ([@FranciedsonLLS](https://github.com/FranciedsonLLS))

---

## Tarefa 03 - Docker Compose, MariaDB e Administração de SGBD

Todos os arquivos da Tarefa 03 estão na pasta [`tarefa03/`](tarefa03/).
Enunciado: [tarefa-docker-sgbd.md](https://github.com/tacianosilva/bsi-tasks/blob/main/database/tarefas/tarefa-docker-sgbd.md)

### Arquivos

| Arquivo | Finalidade |
|---|---|
| [`tarefa03/docker-compose.yml`](tarefa03/docker-compose.yml) | Orquestra os serviços `mariadb` (imagem `mariadb:11`, contêiner `lab-mariadb`) e `cloudbeaver` (imagem `dbeaver/cloudbeaver:latest`, contêiner `lab-cloudbeaver`), com o volume nomeado `mariadb_data` para persistência. |
| [`tarefa03/.env.example`](tarefa03/.env.example) | Modelo versionado das variáveis de ambiente (contrato de configuração), apenas com valores genéricos. |
| `tarefa03/.env` | Arquivo local com os valores reais. **Não é versionado.** |
| [`tarefa03/.gitignore`](tarefa03/.gitignore) e [`.gitignore`](.gitignore) | Impedem que o arquivo `.env` seja enviado ao GitHub. |
| [`tarefa03/povoamento.sql`](tarefa03/povoamento.sql) | Povoamento expandido (passo 9.2): 10 autores e 26 livros, gerados com IA generativa a partir do prompt do roteiro. |
| [`tarefa03/setup.sql`](tarefa03/setup.sql) | Desafio 15: script idempotente que recria do zero o banco `biblioteca`, as tabelas, as restrições, os usuários com privilégios e a carga de dados. |
| [`tarefa03/sql/`](tarefa03/sql/) | Scripts SQL de cada etapa do laboratório (DDL, usuários, carga, consultas e desafios dos Blocos B e C). |
| [`tarefa03/ambiente2/`](tarefa03/ambiente2/) | Desafio 2: segundo ambiente (contêineres `lab2-*`, portas 3308 e 8979) executado em paralelo ao primeiro. |

### Como executar

```bash
cd tarefa03
cp .env.example .env        # no Windows (PowerShell): Copy-Item .env.example .env
# edite o .env e defina uma senha real em MARIADB_ROOT_PASSWORD
docker compose config       # confere as variáveis resolvidas
docker compose up -d        # sobe MariaDB + CloudBeaver
docker ps                   # ambos devem estar "Up"
```

- CloudBeaver: <http://localhost:8978>
- Conexão com o banco no CloudBeaver: host `mariadb`, porta `3306` (rede interna do Docker), usuário `root`.

Para recriar o banco completo de uma vez:

```bash
docker cp setup.sql lab-mariadb:/tmp/setup.sql
docker exec lab-mariadb sh -c 'mariadb -uroot -p$MARIADB_ROOT_PASSWORD < /tmp/setup.sql'
```

Encerramento: `docker compose down` (mantém os dados) ou `docker compose down -v` (apaga o volume).
