Rails.application.routes.draw do

  get'/posts/search',to:'posts#search'
  resources :posts
  get '/',to:'home#top',as:'root'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  devise_scope :user do
      post '/users/profile/edit',to:'users/registrations#update'
  end 
  
  resources :relationships, only: [:create, :destroy]
      
  get '/users/search',to:'users#search'
  get '/users',to:'users#index'
  get '/users/:id',to:'users#show'
  get '/users/:id/likes',to:'users#likes'
  get '/users/:id/comments',to:'users#comments'
  get 'users/:id/following',to:'users#following'
  get 'users/:id/followers',to:'users#followers'
  
  
  post '/posts/:post_id/comments',to:'comments#create'
  delete '/posts/:post_id/comments/:comment_id',to:'comments#destroy'
  
  post '/likes/:post_id/create',to:'likes#create'
  post '/likes/:post_id/destroy',to:'likes#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
