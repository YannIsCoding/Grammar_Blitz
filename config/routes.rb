Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/why', to: 'pages#why'
  resources :exercices, only: [:index, :show] do
    resources :progress_trackers, only: [:create, :update]
  end

  resources :user, only: [:edit, :update]

  get 'profile', to: 'pages#profile', as: 'profile'

end
