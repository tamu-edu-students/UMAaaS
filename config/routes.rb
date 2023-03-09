# frozen_string_literal: true

Rails.application.routes.draw do
  get 'programs', to: 'programs#index'
  get 'reviews/index'
  get 'reviews/leave_review/:id', to: 'reviews#leave_review', as: 'leave_review'
  get 'sessions/create'
  get 'reviews/emergency'
  get '/login', to: redirect('/auth/google_oauth2')
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resource :session, only: %i[create destroy]
  resources :reviews
  resources :users
  resources :programs do
    resources :participants
  end

  # resources :tips
  get 'users/:id/promote', to: 'users#promote'
  get 'users/:id/demote', to: 'users#demote'
  get 'users/:id/ban', to: 'users#ban'
  get 'users/:id/unban', to: 'users#unban'
  get 'programss/:id/enable', to: 'programs#enable'
  get 'programss/:id/disable', to: 'programs#disable'
  get '/programs/:id/flagged', to: 'programs#flagged', as: 'flagged_program'
  get 'p', to: 'portals#index', as: 'portals'
  get 'p/select', to: 'portals#program_select', as: 'program_select'
  get 'p/view', to: 'portals#program_view', as: 'program_view'
  get 'p/:id', to: 'portals#view', as: 'portal'
  get 'p/:id/tips/new', to: 'tips#new', as: 'new_tip'
  post 'p/:id/tips', to: 'tips#create', as: 'tips'
  get 'p/:id/experiences/new', to: 'experiences#new', as: 'new_experience'
  get 'experience/:id', to: 'experiences#view'
  get 'experience/:id/edit', to: 'experiences#edit', as: 'edit_experience'
  put 'experience/:id', to: 'experiences#update', as: 'experience'
  post 'p/:id/experiences', to: 'experiences#create', as: 'experiences'
  post 'experience/:id/comment', to: 'experiences#create_comment'
  post 'experience/yelp_search', to: 'experiences#yelp_search'
  post 'tip/helpful', to: 'tips#helpful'
  post 'tip/flagged', to: 'tips#flagged'
  post 'experience/flagged', to: 'experiences#flagged'
  delete 'experience/:id/delete', to: 'experiences#delete'
  delete 'experience/:id/delete_comment', to: 'experiences#delete_comment'
  delete 'tip/:id/delete', to: 'tips#delete'
  root 'portals#index'
  # unflag an experience
  post 'experience/:id/unflag', to: 'experiences#unflag', as: 'unflag_experience'
  # unflag a tip
  post 'tip/:id/unflag', to: 'tips#unflag', as: 'unflag_tip'
end
