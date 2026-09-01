Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :chats, only: [:show, :create] do
    resources :messages, only: [:create]
  end


end
