# frozen_string_literal: true

# Public: Define routes for the application.
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      # Public: Routes for managing users.
      resources :users, only: %i[show create], defaults: { format: 'json' }
      resources :inventory_items, only: %i[index create], defaults: { format: 'json' }
      resources :inventories, only: %i[show create index], defaults: { format: 'json' }
      resources :items, only: %i[index create], defaults: { format: 'json' }
      resources :infecteds, only: %i[create], defaults: { format: 'json' }
      delete '/inventory/:inventory_id/inventory_item/:id', to: 'inventory_items#destroy'
      put '/current_location', to: 'users#current_location', defaults: { format: 'json' }
      get '/uninfected', to: 'users#uninfected', defaults: { format: 'json' }
      get '/infected', to: 'users#infected', defaults: { format: 'json' }
      get '/items_quantity_average', to: 'inventory_items#items_quantity_average', defaults: { format: 'json' }
      get '/lost_score', to: 'users#lost_score', defaults: { format: 'json' }
      post '/trades', to: 'trades#create'
      # Added the route for the check infected action
      get '/check_infected', to: 'infecteds#check_infected'
    end
  end
end
