Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'conversations#index'
  resources :users, only: [:index]
  resources :private_messages, only: [:new, :create]
  resources :conversations, only: [:index, :show]
end
