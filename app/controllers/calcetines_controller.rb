class CalcetinesController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]

    def index
        @calcetines = Calcetin.all
        @user_calcetines_evaluados = current_user.calcetines_evaluados
        @calcetines_restantes = @calcetines - @user_calcetines_evaluados
    end
  
    def show
      @calcetin = calcetin.find(params[:id])
    end

    def liked_calcetines
        @calcetines_likes = current_user.calcetines_likes # Obtener los calcetines "liked" por el usuario
    end
  
    def new
      @calcetin = Calcetin.new
    end
    
    def create
      @calcetin = Calcetin.new(calcetin_params)
      @calcetin.usuario = current_user
      
    
      if @calcetin.save
        redirect_to calcetines_path, notice: 'El calcetín se ha creado con éxito.'
      else
        puts @calcetin.errors.full_messages
        render 'new'
      end
    end
    
  
    def edit #se abre el formulario para editar pero aun no se edita
      @calcetin = current_user.calcetines.find(params[:id])
    end
  
    def update #ahora si se edita y actualiza
      @calcetin = current_user.calcetines.find(params[:id])
  
      if @calcetin.update(calcetin_params)
        redirect_to @calcetin, notice: 'El calcetín se ha actualizado con éxito.'
        #Esta opción redirigirá al usuario a la página de visualización del calcetín recién creado.

      else
        render 'edit' #si ocurre un error se vuelbe a edit 
      end
    end
  
    def destroy
      @calcetin = current_user.calcetines.find(params[:id])
      @calcetin.destroy
      redirect_to calcetines_path, notice: 'El calcetín se ha eliminado con éxito.'
    end
      
  
    private
  
    def calcetin_params
      params.require(:calcetin).permit(:nombre, :descripcion, :imagen)
    end
  end
  