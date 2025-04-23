Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users,
        path: '',
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          registration: 'signup'
        },
        controllers: {
          sessions: "api/v1/users/sessions",
          registrations: "api/v1/users/registrations"
        }

      resources :users, only: [:index, :show]

      resources :products, only: [:index, :show, :update, :destroy]

      namespace :api do
        resources :carts, only: [:show, :create, :update, :destroy] do
          resources :cart_items, only: [:index, :create, :update, :destroy]
        end
      end

      resources :orders, only: [:index, :create, :show] do
        resources :order_items, only: [:index, :show]
      end
    end
  end
end
