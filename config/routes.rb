Rails.application.routes.draw do
  # Optional health check
  get "up" => "rails/health#show", as: :rails_health_check

  # API namespace
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      
      # Devise routes (login, logout, signup)
      devise_for :users,
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        },
        controllers: {
          sessions: 'api/v1/users/sessions',
          registrations: 'api/v1/users/registrations'
        }

      # User-related endpoints
      resources :users, only: [:index, :show]

      # Product listing and management
      resources :products, only: [:index, :show, :update, :destroy]

      # Cart and nested cart items
      resource :cart, only: [:show, :create, :update, :destroy] do
        resources :cart_items, only: [:index, :create, :update, :destroy]
      end

      # Orders and their items
      resources :orders, only: [:index, :create, :show] do
        resources :order_items, only: [:index, :show]
      end
    end
  end
end
