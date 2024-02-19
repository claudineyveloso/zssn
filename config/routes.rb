# frozen_string_literal: true

# Public: Define routes for the application.
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Public: Routes for managing users.
      resources :users, only: %i[show create], defaults: { format: 'json' } do
        resources :trades, only: [:create]
        member do
          put :current_location
        end
        resources :inventories, only: %i[show create index], defaults: { format: 'json' } do
          # resources :inventory_items, only: %i[index , create, destroy], defaults: { format: 'json' }
          resources :inventory_items, only: %i[index create destroy], defaults: { format: 'json' }
        end
      end
      resources :items, only: %i[index create], defaults: { format: 'json' }
      resources :infecteds, only: %i[create], defaults: { format: 'json' }
      put '/trades', to: 'trades#create'
      get '/uninfected', to: 'users#uninfected'
      get '/infected', to: 'users#infected'
      get '/items_quantity_average', to: 'inventory_items#items_quantity_average'
      get '/lost_score', to: 'users#lost_score'
      # Added the route for the check infected action
      get '/check_infected', to: 'infecteds#check_infected'
    end
  end
end
