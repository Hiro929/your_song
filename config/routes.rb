Rails.application.routes.draw do
  root 'home#top'
  get 'overview', to: 'home#overview'
  get 'privacypolicy', to: 'home#privacypolicy'
  get 'terms', to: 'home#terms'

  resources :songs, only: %i[index new create]
  
  resources :results, only: %i[show new create]
  post 'results/analysis', to: 'results#analysis'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'users', to: 'users#new'
  resources :users, only: %i[new create]

  resources :posts do
    collection {get 'search'}
    resources :comments, only: %i[create destroy], shallow: true
  end

  resource :profile, only: %i[show edit update]
  
  namespace :admin do
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
end
