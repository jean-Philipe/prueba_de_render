Rails.application.routes.draw do

  resources :likes, only: [:index] # Define la ruta para la acción 'index' de Likes.
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :calcetines, only: [:index, :create]

  post '/likes', to: 'likes#index'
  post '/calcetines', to: 'calcetines#index'

  get 'main_view/index'

  root 'main_view#index'


  get '/calcetines', to: 'calcetines#index'
  
  post '/calcetines', to: 'calcetines#create'


  get 'users/profile', to: 'users#profile', as: 'user_profile'

  # Ruta para ver el perfil de un usuario por su ID
  get 'users/:id', to: 'users#show', as: 'view_user_profile'
  get 'search', to: 'users#search', as: 'user_search'



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
