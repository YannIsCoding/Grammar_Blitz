Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/why', to: 'pages#why'
  resources :exercices, only: [:index, :show]

  get 'profile', to: 'pages#profile', as: 'profile'
  post 'exercice_try/:id', to: 'exercices#show', as: :exercice_try
  post 'exercice_setup/:id', to: 'exercices#setup', as: :exercice_setup

end
