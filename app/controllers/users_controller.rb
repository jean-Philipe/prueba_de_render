class UsersController < ApplicationController
    def profile
        # Lógica opcional para cargar datos del perfil
        render 'profile'
    end
    def show
        @user = User.find(params[:id])
    end
   
    def search
        query = params[:query]

        # Realiza la búsqueda de usuarios cuyos nombres de usuario coincidan parcialmente
        # con el criterio de búsqueda
        @search_results = User.where("email LIKE ?", "%#{query}%")
    end
end
