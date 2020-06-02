Rails.application.routes.draw do
# <<<<<<< HEAD
# =======
#   get 'pages/home'
#   devise_for :users
# >>>>>>> master
  root to: 'pages#home'
  get 'details', to: 'pages#details'

  devise_for :users

  get 'profile', to: 'dashboard#profile' do
    resources :appliances, only: [:create, :edit, :update, :destroy]
    resources :smart_home_systems, only: [:create]
    resources :utility_accounts, only: [:create]
  end

  get 'overview', to: 'dashboard#overview'

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
