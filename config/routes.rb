Rails.application.routes.draw do
  root 'home#top'

  resources :songs, only: %i[index new create] do
    collection {get 'search'}
  end
  resources :results, only: %i[show new create]
  post 'results/analysis', to: 'results#analysis'
end
