# Datos de ejemplo para desarrollo. Ejecutar con: bin/rails db:seed
# Se pueden cargar varias veces sin duplicar registros ni borrar datos existentes.
if Rails.env.development?
  ActiveRecord::Base.transaction do
    [
      { email: "demo@bloomdory.test", name: "Camila", last_name: "Rojas", city: "Santiago", country: "Chile" },
      { email: "alex@bloomdory.test", name: "Alex", last_name: "Soto", city: "Valparaíso", country: "Chile" }
    ].each do |attributes|
      user = User.find_or_create_by!(email: attributes[:email]) do |record|
        record.assign_attributes(attributes)
        record.password = "Bloomdory123!"
        record.password_confirmation = "Bloomdory123!"
      end

      [
        {
          title: "Organizar mi semana",
          messages: [
            ["user", "Quiero organizar mi semana y dejar tiempo para estudiar y descansar."],
            ["assistant", "Podemos empezar con tres bloques: estudio por la mañana, una caminata por la tarde y lectura antes de dormir."],
            ["user", "Me gustaría dedicar una hora al proyecto Bloomdory."],
            ["assistant", "Reserva una hora para una tarea concreta del proyecto y termina anotando el siguiente paso."]
          ]
        },
        {
          title: "Crear una rutina de lectura",
          messages: [
            ["user", "Quiero retomar el hábito de leer."],
            ["assistant", "Empieza con veinte minutos al día. Elige un libro que te interese y un horario fácil de mantener."]
          ]
        }
      ].each do |example|
        chat = user.chats.find_or_create_by!(title: example[:title])
        example[:messages].each do |role, content|
          chat.messages.find_or_create_by!(role: role, content: content)
        end
      end

      [
        { title: "Estudiar Ruby on Rails", category: "Estudio", description: "Repasar asociaciones y practicar con los modelos de Bloomdory.", offset: 0, start: "09:00", finish: "10:00" },
        { title: "Caminar al aire libre", category: "Bienestar", description: "Dar una caminata de treinta minutos.", offset: 0, start: "18:00", finish: "18:30" },
        { title: "Avanzar en Bloomdory", category: "Proyecto", description: "Trabajar en una tarea del proyecto y revisar el resultado.", offset: 1, start: "10:00", finish: "11:00" },
        { title: "Leer un libro", category: "Personal", description: "Dedicar veinte minutos a la lectura.", offset: 2, start: "20:00", finish: "20:20" }
      ].each do |example|
        user.schedules.find_or_create_by!(title: example[:title]) do |schedule|
          schedule.category = example[:category]
          schedule.description = example[:description]
          schedule.starting_date = Date.current + example[:offset]
          schedule.ending_date = schedule.starting_date
          schedule.starting_hour = example[:start]
          schedule.ending_hour = example[:finish]
        end
      end
    end
  end

  puts "Datos de ejemplo listos: 2 usuarios, 4 chats, 12 mensajes y 8 actividades."
  puts "Cuentas de ejemplo: demo@bloomdory.test y alex@bloomdory.test"
  puts "Contraseña inicial de las cuentas nuevas: Bloomdory123!"
else
  puts "Se omiten los datos de ejemplo fuera del entorno de desarrollo."
end
