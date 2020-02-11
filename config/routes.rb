Rails.application.routes.draw do
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # post 'authenticate', to: 'authentication#authenticate'
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'

end
