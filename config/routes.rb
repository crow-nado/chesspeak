Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  scope shallow_path: 'games' do
    resources :games, only: [:create, :index, :show, :update, :new] do
      resources :board_state, only: [:show, :update], shallow: true
    end
  end
end
