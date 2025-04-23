Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Auth with Devise + JWT
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

      # Public product endpoints
      resources :products, only: [:index, :show]

      # Cart (1 per user)
      resource :cart, only: [:show, :update, :destroy] do
        resources :cart_items, only: [:create, :update, :destroy]
      end

      # Orders
      resources :orders, only: [:index, :create, :show] do
        resources :order_items, only: [:index, :show]
      end
    end
  end
end



