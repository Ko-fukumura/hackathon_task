Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'users#login_form'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'
  resources :users do
    member do
      get :likes
    end
  end
  resources :posts
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
end
