Rails.application.routes.draw do
  
  resources :checks
  resources :companies
  resources :employers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #root 'sessions#table'

  get 'sessions/login'
  post 'sessions/login' => 'sessions#create'

  get 'sessions/show'

  post 'sessions/show' => 'sessions#show'
  post 'checks/index' => 'checks#index'
  
end
