Rails.application.routes.draw do

  devise_for :users

  get 'main_view/index'

  root 'main_view#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
