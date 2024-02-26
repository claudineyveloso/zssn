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

  api_v1_user_trades POST   /api/v1/users/:user_id/trades(.:format)                                                           api/v1/trades#create {:format=>"json"}
current_location_api_v1_user PUT    /api/v1/users/:id/current_location(.:format)                                                      api/v1/users#current_location {:format=>"json"}
api_v1_user_inventory_inventory_items GET    /api/v1/users/:user_id/inventories/:inventory_id/inventory_items(.:format)                        api/v1/inventory_items#index {:format=>"json"}
                     POST   /api/v1/users/:user_id/inventories/:inventory_id/inventory_items(.:format)                        api/v1/inventory_items#create {:format=>"json"}
api_v1_user_inventory_inventory_item DELETE /api/v1/users/:user_id/inventories/:inventory_id/inventory_items/:id(.:format)                    api/v1/inventory_items#destroy {:format=>"json"}
api_v1_user_inventories GET    /api/v1/users/:user_id/inventories(.:format)                                                      api/v1/inventories#index {:format=>"json"}
                     POST   /api/v1/users/:user_id/inventories(.:format)                                                      api/v1/inventories#create {:format=>"json"}
api_v1_user_inventory GET    /api/v1/users/:user_id/inventories/:id(.:format)                                                  api/v1/inventories#show {:format=>"json"}
        api_v1_users POST   /api/v1/users(.:format)                                                                           api/v1/users#create {:format=>"json"}
         api_v1_user GET    /api/v1/users/:id(.:format)                                                                       api/v1/users#show {:format=>"json"}
        api_v1_items GET    /api/v1/items(.:format)                                                                           api/v1/items#index {:format=>"json"}
                     POST   /api/v1/items(.:format)                                                                           api/v1/items#create {:format=>"json"}
    api_v1_infecteds POST   /api/v1/infecteds(.:format)                                                                       api/v1/infecteds#create {:format=>"json"}
       api_v1_trades PUT    /api/v1/trades(.:format)                                                                          api/v1/trades#create
   api_v1_uninfected GET    /api/v1/uninfected(.:format)                                                                      api/v1/users#uninfected
     api_v1_infected GET    /api/v1/infected(.:format)                                                                        api/v1/users#infected
api_v1_items_quantity_average GET    /api/v1/items_quantity_average(.:format)                                                          api/v1/inventory_items#items_quantity_average
   api_v1_lost_score GET    /api/v1/lost_score(.:format)                                                                      api/v1/users#lost_score
api_v1_check_infected GET    /api/v1/check_infected(.:format)                                                                  api/v1/infecteds#check_infected


# Teste
  * http://localhost:3000/api-docs/index.html
# Autor
  * Claudiney Veloso
