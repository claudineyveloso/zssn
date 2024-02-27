# Teste ZSSN/API
Desenvolvimento de uma API para compartilhamento de informações entre indivíduos saudáveis

# Recursos Principais

# Requisitos
  * Ruby 3.2.2
  * Rails 7.1.3
  * PostgreSQL

# Configuração
  * git clone git@github.com:claudineyveloso/zssn.git
  * bundle install

* Criação de banco de dados
  - rails db:create

* Inicialização do banco de dados

  rails db:migrate

  * Foi criado um seed com o cadastro de 100 usuário.

    Execute rails:seed

  * Foi criado uma rake para cadastrar os itens.

    bundle exec rake seed_data:insert_items

  * Foi criado uma rake para cadastrar os itens.

    bundle exec rake seed_data:insert_inventory_items



# Documentação da API
  * Rotas
    =====

  * rswag_ui  /api-docs
  * rswag_api /api-docs
  * POST   /api/v1/users
  * GET    /api/v1/users/:id
  * GET    /api/v1/inventory_items
  * POST   /api/v1/inventory_items
  * GET    /api/v1/inventories
  * POST   /api/v1/inventories
  * GET    /api/v1/inventories/:id
  * GET    /api/v1/items
  * POST   /api/v1/items
  * POST   /api/v1/infecteds
  * DELETE /api/v1/inventory/:inventory_id/inventory_item/:id
  * PUT    /api/v1/current_location
  * GET    /api/v1/uninfected
  * GET    /api/v1/infected
  * GET    /api/v1/items_quantity_average
  * GET    /api/v1/lost_score
  * POST   /api/v1/trades
  * GET    /api/v1/check_infected

# Teste
  rspec spec/models

  Foi adicionado a gem rswag para a documentação da API, as
  rotas podem ser testadas no link abaixo.

  * http://localhost:3000/api-docs/index.html

# Autor
  * Claudiney Veloso
