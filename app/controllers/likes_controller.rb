
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

      check_for_match(@calcetin, @like, current_user)

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


  private

  def check_for_match(calcetin, like, user)
    @user = user
    @like = like
    @calcetin = calcetin
    @usuarios_likeado_id= @calcetin.id_usuario
    @usuario_likeado = User.find(@usuarios_likeado_id)
    @mis_calcetines = Calcetin.where(id_usuario: @user.id)
    @likes_usuario_likeado = @usuario_likeado.calcetines_likes #son likes 

    matching_calcetines = @mis_calcetines.where(id: @likes_usuario_likeado.pluck(:id_calcetin))

    if matching_calcetines.any?
      Match.create(user_1_id: user.id, user_2_id: @usuarios_likeado_id)
    end



  end

  end
  