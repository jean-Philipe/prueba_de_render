class LikesController < ApplicationController

    before_action :authenticate_user! # Asegura que el usuario esté autenticado para dar "like"
  
    # un usuario da like a un calcetin:

    def create
      @calcetin = Calcetin.find(params[:calcetin_id]) #hay que pasarle el calcetin_id
      @like = current_user.likes.build(calcetin: @calcetin)
  
      if @like.save
        flash[:success] = "Has dado 'like' al calcetín."
        redirect_to @calcetin
      else
        flash[:error] = "No se pudo dar 'like' al calcetín."
        redirect_to @calcetin
      end
    end

    # un usuario elimina su like
  
    def destroy
      @like = current_user.likes.find(params[:id])
      @calcetin = @like.calcetin
  
      if @like.destroy
        flash[:success] = "Has retirado tu 'like' del calcetín."
      else
        flash[:error] = "No se pudo retirar el 'like' del calcetín."
      end
  
      redirect_to @calcetin
    end
  end

end
