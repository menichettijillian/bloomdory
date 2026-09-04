class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: [:edit, :update, :destroy]

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
    redirect_to schedules_path, alert: "Despejado por aquí. ¡Adiós a este compromiso!"
  end

  private

  def set_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(
      :title,
      :description,
      :category,
      :starting_date,
      :starting_hour,
      :ending_date,
      :ending_hour
    )
  end
end
