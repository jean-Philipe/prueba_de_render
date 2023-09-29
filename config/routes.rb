Rails.application.routes.draw do

  resources :likes, only: [:index] # Define la ruta para la acción 'index' de Likes.
  resources :calcetines, only: [:index]
  devise_for :users

  post '/likes', to: 'likes#index'
  post '/calcetines', to: 'calcetines#index'

  get 'main_view/index'

  root 'main_view#index'

  # config/routes.rb
  get 'users/profile', to: 'users#profile', as: 'user_profile'





  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
