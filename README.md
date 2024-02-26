# Teste ZSSN/API
Desenvolvimento de uma API para compartilhamento de informações entre indivíduos saudáveis

# Recursos Principais

# Requisitos
  * Ruby 3.2.2
  * Rails 7.1.3
  * PostgreSQL

# Configuração
  * bundle install

* Versão do Ruby
  ruby '3.2.2'

* Configuração
  bundle install

* Criação de banco de dados
  rails db:create

* Inicialização do banco de dados
  rails db:migrate
* Como executar o conjunto de testes

# Uso
# Documentação da API
  * Rotas

  rswag_ui  /api-docs
  rswag_api /api-docs
  POST   /api/v1/users
  GET    /api/v1/users/:id
  GET    /api/v1/inventory_items
  POST   /api/v1/inventory_items
  GET    /api/v1/inventories
  POST   /api/v1/inventories
  GET    /api/v1/inventories/:id
  GET    /api/v1/items
  POST   /api/v1/items
  POST   /api/v1/infecteds
  DELETE /api/v1/inventory/:inventory_id/inventory_item/:id
  PUT    /api/v1/current_location
  GET    /api/v1/uninfected
  GET    /api/v1/infected
  GET    /api/v1/items_quantity_average
  GET    /api/v1/lost_score
  POST   /api/v1/trades
  GET    /api/v1/check_infected

# Teste
  * http://localhost:3000/api-docs/index.html
# Autor
  * Claudiney Veloso
