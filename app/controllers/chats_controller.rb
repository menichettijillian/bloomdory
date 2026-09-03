class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @chat = Chat.new
    @chat.user = current_user
    if @chat.save
      redirect_to dashboard_path(chat_id: @chat.id), status: :see_other
    else
      render "pages/home"
    end
  end

  def destroy
    chat = current_user.chats.find(params[:id])
    chat.destroy

    redirect_to dashboard_path, status: :see_other, notice: "Conversación eliminada."
  end

  # private

  # def chat_params
  #   params.require(:chat).permit(:title)
  # end
end
