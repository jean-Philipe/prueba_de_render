class MatchesController < ApplicationController

    # se tiene que llamar a esta funcion cada vez que un usuario de like a un calcetin
    #para verificar si existe un like de lado contrario y ver si hay match

  def create (user_1, user_2)
    @match =  Match.new(user_1, user_2)

    if @match.save
      redirect_to matches_path, notice: 'Hay Match!.'
    else
      puts @match.errors.full_messages
      redirect_to likes_path

    end

  end

  def index

    @user = current_user
    @matches = @user.matches
    
    render 'index'

  end

end
  