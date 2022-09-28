Rails.application.routes.draw do
  root 'home#top'
  get 'overview', to: 'home#overview'
  get 'privacypolicy', to: 'home#privacypolicy'
  get 'terms', to: 'home#terms'

  resources :songs, only: %i[index new create] do
    collection {get 'search'}
  end
  resources :results, only: %i[show new create]
  post 'results/analysis', to: 'results#analysis'
end
