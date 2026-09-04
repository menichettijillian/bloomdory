class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard, :schedules]

  def home
  end

  def dashboard
  end

  def schedules
    # Manejo de fechas ara la navegación del mini calendario
    if params[:start_date].present?
      @current_date = Date.parse(params[:start_date])
    elsif params[:month].present? && params[:year].present?
      @current_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    else
      @current_date = Date.current # Siempre actualizado al día real
    end

    # Calcular el inicio y fin de la semana
    start_of_week = @current_date.beginning_of_week(:monday)
    end_of_week = @current_date.end_of_week(:monday)

    # Texto para la barra superior
    @week_range_text = "#{start_of_week.strftime('%d')} - #{end_of_week.strftime('%d %B %Y')}"

    # Días de la semana para grid
    @week_days = (start_of_week..end_of_week).map do |date|
      {
        name: l(date, format: "%a"),
        num: date.day,
        date: date
      }
    end

    # Filtro de eventos por usuario y semana
    base_schedules = current_user.schedules.where(starting_date: start_of_week..end_of_week)

    # Contadores y lista de categorías para la barra lateral
    @all_user_schedules = current_user.schedules.where(starting_date: start_of_week..end_of_week)
    @categories = @all_user_schedules.pluck(:category).compact.uniq

    # Filtro por categoría seleccionada si existe
    if params[:category].present? && params[:category] != "Todas"
      @schedules = base_schedules.where(category: params[:category])
    else
      @schedules = base_schedules
    end
  end
end
