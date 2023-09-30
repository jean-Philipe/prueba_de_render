class MatchesController < ApplicationController

    # se tiene que llamar a esta funcion cada vez que un usuario de like a un calcetin
    #para verificar si existe un like de lado contrario y ver si hay match

  def create
    user_1 = current_user
    user_2 = User.find(params[:user_id]) # Supongamos que aquí recibes el ID del usuario a verificar

    # Lógica para verificar la coincidencia
    if user_1.likes.any? { |like| user_2.likes.exists?(calcetin_id: like.calcetin_id) }

      # Si hay una coincidencia, crea un registro en la tabla de Matches
      Match.create(user_1_id: user_1.id, user_2_id: user_2.id)

      # Notificar a los usuarios aquí
      flash[:notice] = "¡Tienes una coincidencia!"
    else
      flash[:notice] = "No hay coincidencia aún."
    end

    redirect_to root_path # Redirige a donde corresponda
  end


  end
  