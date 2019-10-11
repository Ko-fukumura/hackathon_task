Rails.application.routes.draw do
  resources :posts
  get '/', to: 'home#top'
  get 'about', to: 'home#about'
end
