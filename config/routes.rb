Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # get 'exercice', to: 'pages#exercice', as: :exercice
  resources :exercices, only: [:index, :show]
end
