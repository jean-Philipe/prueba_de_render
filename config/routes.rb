Rails.application.routes.draw do
  resources :likes, only: [:index] # Define la ruta para la acción 'index' de Likes.

  resources :resenas, only: [:index, :new, :create]

  resources :calcetines do
    member do
      get 'editar' # Ruta y acción para editar un calcetín individual
      delete 'eliminar' # Ruta y acción para eliminar un calcetín individual
    end
  end

  post '/likes', to: 'likes#index'

  get 'nuevo_calcetin', to: 'calcetines#new', as: 'new_calcetin'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'main_view/index'
  root 'main_view#index'

  get '/mis_resenas', to: 'resenas#index', as: 'mis_resenas'
  get 'users/profile', to: 'users#profile', as: 'user_profile'

  # Ruta para ver el perfil de un usuario por su ID
  get 'users/:id', to: 'users#show', as: 'view_user_profile'
  get 'search', to: 'users#search', as: 'user_search'
end