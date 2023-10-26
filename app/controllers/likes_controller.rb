
class LikesController < ApplicationController
  before_action :authenticate_user! # Asegura que el usuario esté autenticado para dar "like"
  
    # Un usuario evalua a un calcetín
  def create
    puts "estoy en create"
    @calcetin = Calcetin.find(params[:id])
    liked = params[:liked] # Convierte el parámetro liked en un booleano

    @like = current_user.likes.build(
      id_calcetin: @calcetin.id,
      id_usuario_like: current_user.id,
      liked: liked
    )

    if @like.save
      # Actualiza la lista de calcetines_evaluados
      current_user.calcetines_evaluados << @calcetin unless current_user.calcetines_evaluados.include?(@calcetin)
      @calcetines_evaluados = current_user.calcetines_evaluados

      flash[:success] = "Has evaluado al calcetín."
      redirect_to likes_path
    else
      flash[:error] = "No se pudo evaluar al calcetín."
      redirect_to likes_path
    end
  end

  def index 
    @likes = current_user.calcetines_likes #son likes 
    @calcetines_likes = Calcetin.where(id: @likes.pluck(:id_calcetin))
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
  