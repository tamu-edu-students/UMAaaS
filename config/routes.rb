Rails.application.routes.draw do
  get 'programs', to: 'programs#index'
  get 'reviews/index'
  get 'reviews/leave_review/:id', to: 'reviews#leave_review', as: 'leave_review'
  get 'sessions/create'
  get 'reviews/emergency'
  get "/login", to: redirect("/auth/google_oauth2")
  get "/auth/google_oauth2/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resource :session, only: [:create, :destroy]
  resources :reviews
  resources :programs
  root 'reviews#index'
end
