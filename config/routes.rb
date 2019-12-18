Rails.application.routes.draw do
  get'/posts/search',to:'posts#search'
  resources :posts
  get '/',to:'home#top'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  devise_scope :user do
      post '/users/profile/edit',to:'users/registrations#update'
  end      
      
  get '/users/search',to:'users#search'
  get '/users',to:'users#index'
  get '/users/:id',to:'users#show'
  get "users/:id/likes" => "users#likes"
  
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
