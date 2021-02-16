Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :checks
  resources :companies
  resources :employers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #root 'sessions#login'

  get 'sessions/login'
  post 'sessions/login' => 'sessions#create'
  
end
