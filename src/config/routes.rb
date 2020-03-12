Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [:index, :update, :destroy, :show, :create] do
        collection do
          post 'sign_in'
          get 'me' # debug
        end
      end
      resources :account_activations, only: [:edit]
      resources :authorizations, only: [:index, :create, :update, :destroy, :show]
      resources :ideas, only: [:index, :create, :update, :destroy, :show]
      resources :multi_ideas, only: [:index, :create, :update, :destroy, :show]
      resources :genre_tags, only: [:index, :create, :update, :destroy, :show]
      resources :idea_tags, only: [:index, :create, :update, :destroy, :show]
    end
  end
  scope module: :api do
    scope module: :v1 do
      match '/auth/:provider/callback', to: 'account_activations#create', via: [:get, :post]
    end
  end
end
