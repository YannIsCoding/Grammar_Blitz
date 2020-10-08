Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :exercices, only: [:index, :show, :new, :create]

  resources :exercices, only: [] do
    get 'verb_practice', to: 'verb_practices#new'
    put 'verb_practice/:id', to: 'verb_practices#update', as: :update_verb
    resources :practice_sessions, only: :new
    resources :edicts, only:  [:index, :create, :update, :destroy]
  end

  # this double resource/scope is necessary because the trials is nested in the routes
  # and also in the folder hierarichy
  resources :practice_sessions, only: [] do
    scope module: 'practice_sessions' do
      resource :trial, only: :create
      resource :result, only: :show
    end
  end

  get 'verb_result/:id', to: 'verb_practices#result', as: :verb_result

  get '/why', to: 'pages#why'
  get 'profile', to: 'pages#profile', as: 'profile'
  # get 'sentence_result/:id', to: 'sentences#result', as: :sentence_result

end
