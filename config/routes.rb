Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :exercices, only: [:index, :show, :new, :create]
  resources :sentences, only: [:new, :update]
  resources :edicts, only:  [:index, :create, :update, :destroy]
  resources :structures, only:  [:new, :create]

  resources :exercices, only: [] do
    # resources :sentences, only: [:new, :create]
    get 'verb_practice', to: 'verb_practices#new'
    put 'verb_practice/:id', to: 'verb_practices#update', as: :update_verb
  end



  get '/why', to: 'pages#why'
  get 'profile', to: 'pages#profile', as: 'profile'
  get 'exercice_setup/:id', to: 'exercices#setup', as: :exercice_setup
  # get 'sentence_start', to: 'sentences#generate', as: :sentence_start
  # patch 'generate_sentence/:id', to: 'sentences#generate', as: :generate_sentence
  get 'sentence_result/:id', to: 'sentences#result', as: :sentence_result

end
