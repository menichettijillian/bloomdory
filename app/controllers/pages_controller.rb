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
    # Manejo seguro de fechas para la navegación del mini calendario
    if params[:start_date].present?
      begin
        @current_date = Date.parse(params[:start_date])
      rescue ArgumentError
        @current_date = Date.current
      end
    elsif params[:month].present? && params[:year].present?
      begin
        @current_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
      rescue ArgumentError
        @current_date = Date.current
      end
    else
      @current_date = Date.current
    end

    # Calcular el inicio y fin de la semana
    start_of_week = @current_date.beginning_of_week(:monday)
    end_of_week = @current_date.end_of_week(:monday)

    # Barra semanal
    # Diccionario de meses en español
    spanish_months = {
      1 => "Enero", 2 => "Febrero", 3 => "Marzo", 4 => "Abril",
      5 => "Mayo", 6 => "Junio", 7 => "Julio", 8 => "Agosto",
      9 => "Septiembre", 10 => "Octubre", 11 => "Noviembre", 12 => "Diciembre"
    }

    # Texto para la barra semanal
    start_month_name = spanish_months[start_of_week.month]
    end_month_name = spanish_months[end_of_week.month]

    if start_of_week.month == end_of_week.month
      @week_range_text = "#{start_of_week.strftime('%d')} - #{end_of_week.strftime('%d')} #{end_month_name} #{end_of_week.year}"
    else
      @week_range_text = "#{start_of_week.strftime('%d')} #{start_month_name} - #{end_of_week.strftime('%d')} #{end_month_name} #{end_of_week.year}"
    end

    # Días
    spanish_days = {
      1 => "LUN",
      2 => "MAR",
      3 => "MIÉ",
      4 => "JUE",
      5 => "VIE",
      6 => "SÁB",
      7 => "DOM"
    }

    # Acomodarlos
    @week_days = (start_of_week..end_of_week).map do |date|
      {
        name: spanish_days[date.cwday],
        num: date.day,
        date: date
      }
    end

    # Filtrado de eventos por usuario y semana
    base_schedules = current_user.schedules.where(starting_date: start_of_week..end_of_week)

    # Contadores y lista de categorías para la barra lateral
    @all_user_schedules = current_user.schedules.where(starting_date: start_of_week..end_of_week)
    @categories = @all_user_schedules.pluck(:category).compact.uniq

    # Filtrar por categoría seleccionada si existe
    if params[:category].present? && params[:category] != "Todas"
      @schedules = base_schedules.where(category: params[:category])
    else
      @schedules = base_schedules
    end
  end

  def objectives
    # Pendiente
  end

  def construction
    
  end
       # Pendiente
  def profile
    
  end
end
