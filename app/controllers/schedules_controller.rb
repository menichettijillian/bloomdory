class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: [:edit, :update, :destroy, :move]

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to schedules_path, notice: "¡Ajuste de manecillas! Tu evento ha cambiado de rumbo."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_path, notice: "Despejado por aquí. ¡Adiós a este compromiso!"
  end

  def move
    # Actualizar
    new_date = params[:date]

    if new_date.present? && @schedule.update(starting_date: new_date)
      head :ok
    else
      render json: { errors: @schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:title, :description, :starting_date, :starting_hour, :ending_hour, :category)
  end
end
