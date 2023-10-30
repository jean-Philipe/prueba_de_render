class ChatsController < ApplicationController

    def create (mensaje, user_1_id, user_2_id, match)
        # Lógica para crear un nuevo chat entre dos usuarios
        puts 'Intentando crear el chat'
        user1 = User.find(params[:user_1_id])
        user2 = User.find(params[:user_2_id])
    
        @chat = Chat.create(match_id: match.id, user_1_id: user_1_id, user_2_id: user_2_id)

        if @chat.save
          redirect_to chat_path(@chat)
        else
          # Manejar errores
        end
    end

    def index

        @user = current_user
        @chats = @user.chats
        @chats.each do |chat|

        end
    
        #render 'index'

    end

    def show

      @user = current_user
        @chats = @user.chats
        @chats.each do |chat|

        end
    
      @user_1_id = current_user.id
   
      @user_2_id = params[:id]
 
      @chat = Chat.where(
        "(user_1_id = :user1 AND user_2_id = :user2) OR (user_1_id = :user2 AND user_2_id = :user1)",
        user1: @user_1_id,
        user2: @user_2_id
      ).first


      redirect_to chat_message_path(chat_id: @chat.id)
    end
end
