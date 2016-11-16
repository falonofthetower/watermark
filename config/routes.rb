Rails.application.routes.draw do
  # root to: 'sessions#new'
  root to: 'images#new'
  # get 'auth/google_oauth2/callback', to: 'oauth2#redirect'
  get 'auth/google_oauth2/callback', to: 'sessions#create', as: :sign_in
  delete '/sign_out', to: 'sessions#destroy', as: 'sign_out'
  get 'auth/failure', to: redirect('/')
  get '/auth/google_oauth2', as: 'google_oauth2'
  resources :pdfs
  # get '/sign_in', to: 'sessions#new'
  resources :sessions, only: [:create, :destroy]
  # post '/sign_in', to: 'sessions#create', as: 'sessions'
  post 'apply_watermark', to: 'watermarker#apply', as: 'apply_watermark'
  get 'progress/:job_id', to: 'watermarker#percentage_done'

  resources :users, only: [:new, :create]
  resources :images, only: [:new, :create, :show, :index]
  resources :projects, only: [:new, :create, :index, :show] do
    resources :pdfs, only: [:create]
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
