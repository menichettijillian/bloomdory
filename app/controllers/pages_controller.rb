class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end

  def dashboard
    # Carga los chats del usuario actual (o un array vacío si aún no tienes el modelo Chat)
    @chats = current_user.chats rescue []
  end

  def myweek
  end
end
