# frozen_string_literal: true

# Public: Define routes for the application.
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Public: Routes for managing users.
      resources :users, defaults: { format: 'json' } do
        resources :trades, only: [:create]
        member do
          put :current_location
        end
        resources :inventories, only: %i[index create destroy], defaults: { format: 'json' } do
          collection do
            put :item_exchange, path: '/item_exchange/user_receiver/:user_receiver_id'
            # /api/v1/users/1/inventories/item_exchange/user_receiver/2
          end
        end
        get 'inventory_items', to: 'inventories#inventory_items'
      end
      resources :inventory_items, defaults: { format: 'json' }
      resources :items, only: %i[index create destroy], defaults: { format: 'json' }
      resources :infecteds, only: %i[create destroy], defaults: { format: 'json' }

      # Added the route for the check infected action
      get '/check_infected', to: 'infecteds#check_infected'
    end
  end
end
