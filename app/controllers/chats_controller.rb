class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @chat = Chat.new
    @chat.user = current_user
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render "pages/home"
    end
  end

  # private

  # def chat_params
  #   params.require(:chat).permit(:title)
  # end
end
