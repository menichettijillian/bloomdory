class MessagesController < ApplicationController
  before_action :set_chat, only: %i[create]

  def create
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.ask(@message.content)
      # response = ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
