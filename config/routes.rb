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
  resources :users
  get 'users/:id/promote', to: 'users#promote'
  get 'users/:id/demote', to: 'users#demote'
  get 'p', to: 'portals#index', as: "portals"
  get 'p/redirect', to: 'portals#program_redirect', as: 'program_redirect'
  get 'p/:id', to: 'portals#view', as: "portal"
  root 'reviews#index'
end
