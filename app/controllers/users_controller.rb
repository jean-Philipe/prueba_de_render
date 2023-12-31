class UsersController < ApplicationController
  def profile
      # Lógica opcional para cargar datos del perfil
    render 'profile'
  end
  def search
    query = params[:query]

      # Realiza la búsqueda de usuarios cuyos nombres de usuario coincidan parcialmente
      # con el criterio de búsqueda
      @search_results = User.where("email LIKE ?", "%#{query}%")
  end
 
  def show
    if params[:id] == "sign_out"
      # Realiza acciones específicas para cerrar sesión, como eliminar la sesión actual, etc.
      sign_out(current_user) # Este es un ejemplo de cómo cerrar sesión con Devise.
      redirect_to root_path, notice: "Has cerrado sesión exitosamente."
    else
      if user_signed_in?
        @user = User.find(params[:id])
      else
        redirect_to root_path, alert: "Usuario no encontrado."
      end
    end
  end
  
  #def profile
   # @user = User.find(params[:id])
  #end  
  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user  # Asegura que el administrador tenga permiso para editar
  end    
# users_controller.rb
  def calcetines
    @user = User.find(params[:id])
    @calcetines = @user.calcetines
  end

end
