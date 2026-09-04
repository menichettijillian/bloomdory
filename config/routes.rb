Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :schedules, only: [:edit, :update, :destroy]

  resources :chats, only: [:show, :create, :destroy] do
    resources :messages, only: [:create]
  end

  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  get 'schedules', to: 'pages#schedules', as: :schedules

  get 'profile', to: 'pages#profile', as: :profile

end
