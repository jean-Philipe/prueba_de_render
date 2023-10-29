class AdminController < ApplicationController
    before_action :authenticate_user! # Este es el filtro de autenticación para usuarios
    before_action :check_admin # Asegurarse de que solo los administradores puedan acceder
    def check_admin
        unless current_user.admin?
          redirect_to root_path, alert: "No tienes permiso para acceder a esta página."
        end
      end
    def update
        @record = SomeModel.find(params[:id])
        authorize! :update, @record
        # Resto de la lógica de actualización
      end
    def users
      @users = User.all
    end
  
    def show_user
      @user = User.find(params[:id])
      @calcetines = @user.calcetines
    end
  
    def edit_calcetin
      @calcetin = Calcetin.find(params[:id])
      # Lógica de edición
    end
  
    def destroy_calcetin
      @calcetin = Calcetin.find(params[:id])
      @calcetin.destroy
      # Lógica de eliminación
    end
  
    # Otras acciones
  end
  