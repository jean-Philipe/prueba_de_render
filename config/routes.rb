Rails.application.routes.draw do
  resources :likes, only: [:index] # Define la ruta para la acción 'index' de Likes.

  get 'likes/new', to: 'likes#create', as: 'new_like'

  resources :resenas, only: [:index, :new, :create]

  resources :calcetines do
    member do
      get 'editar' # Ruta y acción para editar un calcetín individual
    end
  end
  

  get 'admin/users', to: 'admin#users'
  get 'admin/user/:id', to: 'admin#show_user', as: 'admin_show_user'
  get 'admin/calcetin/:id/edit', to: 'admin#edit_calcetin', as: 'admin_edit_calcetin'
  delete 'admin/calcetin/:id', to: 'admin#destroy_calcetin', as: 'admin_destroy_calcetin'
  

  post '/likes', to: 'likes#index'

  get 'nuevo_calcetin', to: 'calcetines#new', as: 'new_calcetin'

  # Ruta para la actualización (ejecutada al enviar el formulario de edición)

  patch 'calcetines/:id', to: 'calcetines#update', as: 'update_calcetin'
  get '/calcetines/:id/eliminar', to: 'calcetines#destroy', as: 'destroy_calcetin'

  get '/calcetines/:id/likes', to: 'likes#create', as: 'new_calcetin_like'


  get '/matches', to: 'matches#index', as: 'matches'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'main_view/index'
  root 'main_view#index'

  get '/mis_resenas', to: 'resenas#index', as: 'mis_resenas'
  get 'users/profile', to: 'users#profile', as: 'user_profile'

  # Ruta para ver el perfil de un usuario por su ID
  get 'users/:id', to: 'users#show', as: 'view_user_profile'
  get 'search', to: 'users#search', as: 'user_search'


  
  resources :chats, only: [:show] do
    member do
      get 'messages', to: 'messages#show'
    end
  end

  resources :chats, only: [:show, :create] do
    get 'with/:user_id', action: :show, on: :member, as: 'with'
  end

  resources :chats do
    resources :messages, only: [:show, :create]
  end

  
  
end