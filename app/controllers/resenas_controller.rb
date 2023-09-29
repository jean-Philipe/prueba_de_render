class ResenasController < ApplicationController
    # Otras acciones del controlador aquí...
  
    def index
      @resenas = current_user.resenas # Esto asume que tienes una asociación "resenas" en tu modelo de usuario.
    end
  
    def new
      @resena = Resena.new
    end
  
    def create
        @resena = current_user.resenas.build(resena_params)
        
        if @resena.save
          redirect_to resenas_url, notice: 'La reseña se ha creado con éxito.'
        else
          render :new
        end
      end
  
    # Otras acciones del controlador aquí...
  
    private
  
    def resena_params
      params.require(:resena).permit(:puntuacion, :comentario)
    end
  end
  