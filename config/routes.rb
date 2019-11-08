Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :exercices, only: [:index, :show] do
    resources :progress_trackers, only: [:create, :update]
  end
end
