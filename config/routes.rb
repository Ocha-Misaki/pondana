Rails.application.routes.draw do
  root to: "books#index"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
  }

  resources :ownerships, only: %i[create destroy]

  resources :books, only: %i[show] do
    resources :comments, only: %i[create destroy], module: :books
  end

  resources :ownerships, only: [:index, :show, :new, :edit, :create, :update, :destroy] do
    resources :ratings, only: %i[create update], module: :ownerships
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "up" => "rails/health#show", as: :rails_health_check
end
