Rails.application.routes.draw do
  get '/', to: 'home#top'
  get 'about', to: 'home#about'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users
  resources :posts
end
