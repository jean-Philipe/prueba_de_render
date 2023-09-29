class ResenasController < ApplicationController
    # Otras acciones del controlador aquí...
  
    def index
      @mis_resenas = current_user.resenas # Tus propias reseñas
      @reseñas_sobre_ti = Resena.includes(:user).where(user_id: current_user.id)
    end
  
    def new
      @user = User.find(params[:user_id])
      @resena = @user.resenas.build
    end
  
    def create
      @user = User.find(params[:resena][:user_id])
      @resena = @user.resenas.build(resena_params)
      @resena.titulo = "#{current_user.first_name} #{current_user.last_name}"
  
      if @resena.save
        redirect_to mis_resenas_path, notice: 'La reseña se ha creado con éxito.'
      else
        render :new
      end
    end
  
    # Otras acciones del controlador aquí...
  
    private
  
    def resena_params
      params.require(:resena).permit(:puntuacion, :comentario, :titulo)
    end
  end
  