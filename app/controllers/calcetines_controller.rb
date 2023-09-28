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
  
    def new #utilizar cuando el usuario quiera crear un nuevo calcetín. Esto inicia la intancia pero todavia no lo crea. (fatan los datos)
      @calcetin = current_user.calcetines.build
    end
  
    def create #aca ya se recibieron los datos y ahora si se crea el calcetín

      @calcetin = current_user.calcetines.build(calcetin_params)
  
      if @calcetin.save
        redirect_to @calcetin, notice: 'El calcetín se ha creado con éxito.'
      else
        render 'new' #como hay errores se vuelve a la funcion new que deberia mostrar un formulario para que el usuario vuelva a ingresar los datos
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
  