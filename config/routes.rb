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
  # resources :tips
  get 'users/:id/promote', to: 'users#promote'
  get 'users/:id/demote', to: 'users#demote'
  get 'users/:id/ban', to: 'users#ban'
  get 'users/:id/unban', to: 'users#unban'
  get 'programss/:id/enable', to: 'programs#enable'
  get 'programss/:id/disable', to: 'programs#disable'
  get 'p', to: 'portals#index', as: 'portals'
  get 'p/select', to: 'portals#program_select', as: 'program_select'
  get 'p/view', to: 'portals#program_view', as: 'program_view'
  get 'p/:id', to: 'portals#view', as: 'portal'
  get 'p/:id/tips/new', to: 'tips#new', as: 'new_tip'
  post 'p/:id/tips', to: 'tips#create', as: 'tips'
  root 'reviews#index'
end
