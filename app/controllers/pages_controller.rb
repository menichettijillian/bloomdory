class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end

  def dashboard
    @chats = current_user.chats.order(created_at: :desc)

    @chat = if params[:chat_id].present?
              @chats.find(params[:chat_id])
            else
              @chats.first
            end

    @message = Message.new if @chat
  end

  def myweek
  end
end
