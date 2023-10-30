
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



      if liked 
        check_for_match(@calcetin, @like, current_user)
      end

      flash[:success] = "Has evaluado al calcetín."
      redirect_to likes_path
    else
      flash[:error] = "No se pudo evaluar al calcetín."
      redirect_to likes_path
    end
  end

  def index 
    @likes = current_user.calcetines_liked #son likes 
    @calcetines_likes = Calcetin.where(id: @likes.pluck(:id_calcetin))
    render 'index'
  end 
  

  private

  def check_for_match(calcetin, like, user)
    @user = user
    @like = like
    @calcetin = calcetin
    @usuarios_likeado_id= @calcetin.id_usuario
    @usuario_likeado = User.find(@usuarios_likeado_id)
    @mis_calcetines = Calcetin.where(id_usuario: @user.id)
    @likes_usuario_likeado = @usuario_likeado.calcetines_liked #son likes 

    matching_calcetines = @mis_calcetines.where(id: @likes_usuario_likeado.pluck(:id_calcetin))

    if matching_calcetines.any?
      @match = Match.create(user_1_id: user.id, user_2_id: @usuarios_likeado_id)
      Chat.create(mensaje: " ", match_id: @match.id, user_1_id: user.id, user_2_id: @usuarios_likeado_id)
    end



  end

  end
  