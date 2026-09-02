Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  resources :schedules, only: [:edit, :update, :destroy]
  get 'dashboard', to: 'pages#dashboard'

end
