# Store API

Este projeto é um teste técnico para vaga de desenvolvedor backend para a empresa RD Station.

## Tecnologias e ferramentas
- Ruby on Rails
- PostgreSQL
- Redis
- Sidekiq (para jobs em background)
- RSpec + FactoryBot (testes automatizados)
- Docker + docker-compose


## Funcionalidades principais
- CRUD de produtos
- Carrinho de compras com operações:
  - Adicionar produto
  - Atualizar quantidade
  - Remover produto
  - Marcar carrinho como abandonado após inatividade
  - Remover carrinhos abandonados há mais de 7 dias
- Validações customizadas e tratamento de erros

## Como executar localmente (sem Docker)
### Pré-requisitos:
- Ruby 3.3.1
- Rails 7+
- PostgreSQL
- Redis

### Configurações:
1. Clonar o repositório:
   ```bash
   git clone git@github.com:manoeljuniorti/rd_station_test.git
   cd < ./diretório onde o projeto foi salvo >
   ```

2. Configurar o banco localmente, editando config/database.yml se necessário para usar seu usuário/senha/local.

3. Instalar as gems:
   ```bash
   bundle install
   ```

4. Criar, migrar e aplicar as seeds:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. Iniciar o redis.

6. Iniciar o servidor rails:
   ```bash
   rails server ou rails s
   ```

## Como executar com Docker
### Pré-requisitos:
- Docker
- docker-compose

### Configurações:
1. Clonar o repositório:
   ```bash
   git clone git@github.com:manoeljuniorti/rd_station_test.git
   cd < ./diretório onde o projeto foi salvo >
   ```

2. Criar o arquivo .env(opcional), para configurar variáveis, ou edite o docker-compose.yml para definir usuários e senhas.

3. Execute o docker-compose para subir serviços:
   ```bash
   docker-compose up --build
   ```

4. Rodar migrações dentro do container web:
   ```bash
   docker-compose exec web rails db:create db:migrate db:seed
   ```