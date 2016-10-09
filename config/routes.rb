Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  resources :messages, only: [:index]
  resources :sessions, only: [:new, :create]

  root 'messages#index'
  
  # this is an alternative to connecting to the server in assets/javascripts/cable:
  # mount ActionCable.server => '/cable'
end
