Rails.application.routes.draw do
  resources :posts
  get '/',to:'home#top'
  devise_for :users
  
  get '/users',to:'users#index'
   get '/users/:id',to:'users#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
