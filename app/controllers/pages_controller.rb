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

  def schedules
    @schedules = current_user.schedules

    base_date = Date.new(2025, 5, 12)
    start_of_week = base_date.beginning_of_week(:monday)

    @week_days = (0..6).map do |i|
      day = start_of_week + i.days
      {
        name: day.strftime("%a").upcase,
        num: day.strftime("%d"),
        date: day
      }
    end

    @week_range_text = "#{start_of_week.strftime("%d")} - #{(start_of_week + 6.days).strftime("%d %B")}"
  end
end
