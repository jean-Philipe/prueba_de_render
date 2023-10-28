class MessagesController < ApplicationController

    before_action :authenticate_user!

    def create
      @chat = Chat.find(params[:chat_id])
      puts 'parametros aca'
      @chat_id = params[:chat_id]
      @content = params[:content]
      @new_message = @chat.messages.build(content: @content , user_id: current_user.id, chat_id: @chat_id)
      @new_message.user = current_user
  
      if @new_message.save
        # Mensaje enviado con éxito
        redirect_to chat_message_path(@chat, @new_message), notice: 'Mensaje enviado con éxito.'
      else
        # Manejar errores
      end
    end

    def show
      @chat = Chat.find(params[:chat_id])
    
      @messages = @chat.messages
      if User.find(@chat.user_1_id) == current_user
        @usuario = User.find(@chat.user_2_id)
      else
        @usuario = User.find(@chat.user_1_id)
      end

    end
  
    private
  
    def message_params
      params.require(:new_message).permit(:content, :chat_id)
      
    end

    
end
