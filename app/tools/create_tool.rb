class CreateTool < RubyLLM::Tool
  description "Crea una tarea, guardala en la base de datos y muestrala"
  param :title, desc: "El título breve de la tarea"
  param :category, desc: "La categoria de la tarea"
  param :description, desc: "La descripcion de la tarea"
  param :starting_date, desc: "La fecha de inicio de la tarea"
  param :ending_date, desc: "La fecha de conclusion de la tarea"
  param :starting_hour, desc: "La hora de inicio de la tarea"
  param :ending_hour, desc: "La hora de conclusion de la tarea"

  def initialize(user)
    @user = user
  end



  def execute(title:, category:, description:, starting_date:, ending_date:, starting_hour:, ending_hour:)
    schedule = @user.schedules.create!(
      title: title,
      category: category,
      description: description,
      starting_date: starting_date,
      ending_date: ending_date,
      starting_hour: starting_hour,
      ending_hour: ending_hour
    )
    {
      success: true,
      message: "Tarea creada correctamente",
      schedule_id: schedule.id
    }
  end
end
