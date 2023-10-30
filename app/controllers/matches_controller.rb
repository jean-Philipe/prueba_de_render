class MatchesController < ApplicationController

    # se tiene que llamar a esta funcion cada vez que un usuario de like a un calcetin
    #para verificar si existe un like de lado contrario y ver si hay match

  def create (user_1, user_2)

    existing_match = Match.find_by(user_1_id: user_1, user_2_id: user_2)

    if existing_match
      # Utiliza el match existente
      @match = existing_match
    else
      # Crea un nuevo match
      @match =  Match.new(user_1, user_2)

      if @match.save
        redirect_to matches_path, notice: 'Hay Match!.'
      else
        puts @match.errors.full_messages
        redirect_to likes_path

    end
    end

    


  end

  def index

    @user = current_user
    @matches = @user.matches
    @matches.each do |match|
    end


    other_user_ids = []

    @matches.each do |match|
      if match.user_1_id == @user.id
        other_user_ids << match.user_2_id
      else
        other_user_ids << match.user_1_id
      end
    end

    @usuarios_matches = User.where(id: other_user_ids)


    render 'index'

  end

end
  