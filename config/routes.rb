Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  resources :games, only: [:create, :index, :show, :update, :new] do
    resources :pieces, only: [:index, :show, :update]
  end
end
