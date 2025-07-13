Rails.application.routes.draw do
  root to: "books#index"

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
  }

  resources :books, only: %i[show] do
    resources :having_books, only: %i[create destroy], module: :books
    resources :interests, only: %i[create destroy], module: :books
    resources :comments, only: %i[create destroy], module: :books
  end
  resources :having_books do
    resources :ratings, only: %i[create update], module: :having_books
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
