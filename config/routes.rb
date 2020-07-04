Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :exercices, only: [:index, :show]
  resources :sentences, only: [:new, :create, :update]
  resources :edicts, only:  [:index, :create, :update, :destroy]
  resources :structures, only:  [:new, :create]

  get '/why', to: 'pages#why'
  get 'profile', to: 'pages#profile', as: 'profile'
  get 'exercice_setup/:id', to: 'exercices#setup', as: :exercice_setup
  patch 'sentences_setup/:id', to: 'sentences#save_setup', as: :sentence_setup
  get 'sentence_result/:id', to: 'sentences#result', as: :sentence_result

end
