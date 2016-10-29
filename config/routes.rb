Rails.application.routes.draw do
  root to: 'projects#new'
  get 'auth/google_oauth2/callback', to: 'oauth2#redirect'
  get '/auth/google_oauth2', as: 'google_oauth2'
  resources :pdfs
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create', as: 'sessions'
  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'
  post 'pdf_flatten', to: 'pdf_flatten#flatten', as: 'pdf_flatten'
  get 'progress/:job_id', to: 'pdf_flatten#percentage_done'

  resources :users, only: [:new, :create]
  resources :projects, only: [:new, :create, :index, :show] do
    resources :pdfs, only: [:create]
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
