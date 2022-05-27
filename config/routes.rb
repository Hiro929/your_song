Rails.application.routes.draw do
  root 'home#top'

  resources :songs, only: %i[index]
  resources :results, only: %i[new create]
end
