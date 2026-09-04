class DeleteTool < RubyLLM::Tool
  description "Elimina una tarea de la agenda"

  param :schedule_id, desc: "El ID de la tarea a eliminar"

  def initialize(user)
    @user = user
  end


  def execute(schedule_id:)
    schedule = @user.schedules.find(schedule_id)

    schedule.destroy!

    {
      success: true,
      message: "Tarea eliminada correctamente",
      schedule_id: schedule_id
    }
  end
end
