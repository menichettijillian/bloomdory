class UpdateTool < RubyLLM::Tool
  description "Modifica una tarea, guardala en la base de datos y muestrala"

  param :schedule_id, desc: "El ID de la tarea a modificar"
  param :title, desc: "El título breve de la tarea", required: false
  param :category, desc: "La categoria de la tarea", required: false
  param :description, desc: "La descripcion de la tarea", required: false
  param :starting_date, desc: "La fecha de inicio de la tarea", required: false
  param :ending_date, desc: "La fecha de conclusion de la tarea", required: false
  param :starting_hour, desc: "La hora de inicio de la tarea", required: false
  param :ending_hour, desc: "La hora de conclusion de la tarea", required: false

  def initialize(user)
    @user = user
  end

  def execute(

    schedule_id:,
    title: nil,
    category: nil,
    description: nil,
    starting_date: nil,
    ending_date: nil,
    starting_hour: nil,
    ending_hour: nil
  )
    schedule = @user.schedules.find(schedule_id)

    updates = {
      title: title,
      category: category,
      description: description,
      starting_date: starting_date,
      ending_date: ending_date,
      starting_hour: starting_hour,
      ending_hour: ending_hour
    }.compact

    schedule.update!(updates)
    {
      success: true,
      message: "Tarea modificada correctamente",
      schedule_id: schedule.id
    }
  end
end
