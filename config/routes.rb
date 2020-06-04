Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'details', to: 'pages#details'
  get 'data', to: 'pages#data'

  get 'profile', to: 'dashboard#profile'
  get 'overview', to: 'dashboard#overview'

  resources :appliances, only: [:create, :edit, :update, :destroy]
  resources :smart_home_systems, only: [:create]
  resources :utility_accounts, only: [:create]
  resources :energy_providers, only: [:create]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :smart_plugs, only: [ :create, :update ]
    end
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
