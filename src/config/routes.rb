Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [:index, :create, :update, :destroy, :show]
      resources :authorizations, only: [:index, :create, :update, :destroy, :show]
      resources :ideas, only: [:index, :create, :update, :destroy, :show]
      resources :multi_ideas, only: [:index, :create, :update, :destroy, :show]
      resources :genre_tags, only: [:index, :create, :update, :destroy, :show]
      resources :idea_tags, only: [:index, :create, :update, :destroy, :show]
    end
  end
end
