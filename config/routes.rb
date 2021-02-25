Rails.application.routes.draw do  
  resources :checks , only:[ :index ]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :companies
  resources :employers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'sessions#login'

  get 'sessions/login'
  post '/' => 'sessions#create'

  get 'sessions/show'

  post 'sessions/show' => 'sessions#show'
  post 'checks' => 'checks#index'
  
end
