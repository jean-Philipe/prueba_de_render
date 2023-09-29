
class LikesController < ApplicationController
    before_action :authenticate_user! # Asegura que el usuario esté autenticado para dar "like"
  
    # Un usuario evalua a un calcetín
    def create
      @calcetin = Calcetin.find(params[:id_calcetin])
      liked = params[:liked] == 'true' # Convierte el parámetro liked en un booleano
  
      @like = current_user.likes.build(
        id_calcetin: @calcetin.id,
        id_usuario_like: current_user.id,
        liked: liked
      )
  
      if @like.save
        # Actualiza la lista de calcetines_evaluados
        current_user.calcetines_evaluados << @calcetin unless current_user.calcetines_evaluados.include?(@calcetin)
        flash[:success] = "Has evaluado al calcetín."
        redirect_to @calcetin
      else
        flash[:error] = "No se pudo evaluar al calcetín."
        redirect_to @calcetin
      end
    end

    def index 
      @likes = current_user.calcetines_likes
      render 'index'
    end 
  
    # Un usuario elimina su like
    def destroy
      @like = current_user.likes.find(params[:id])
      @calcetin = @like.calcetin
  
      if @like.destroy
        # Elimina el calcetín de la lista de calcetines_evaluados
        current_user.calcetines_evaluados.delete(@calcetin)
        flash[:success] = "Has retirado tu 'like' del calcetín."
      else
        flash[:error] = "No se pudo retirar el 'like' del calcetín."
      end
  
      redirect_to @calcetin
    end
  end
  