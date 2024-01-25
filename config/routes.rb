# frozen_string_literal: true

# Public: Define routes for the application.
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Public: Routes for managing users.
      resources :users, defaults: { format: 'json' } do
        member do
          put :current_location
        end
      end
      # resources :items, only: %i[create destroy], defaults: { format: 'json' }
      resources :infecteds, only: %i[create destroy], defaults: { format: 'json' }
      resources :inventories, defaults: { format: 'json' }
    end
  end
end
