Rails.application.routes.draw do
    resources :fish,except: [:show]
    get '/fishing.map',to:'posts#fishing_map',as:'fmap_path'
    get '/posts/search_fishing_map',to:'posts#search_fishing_map'
    get '/posts/search',to:'posts#search'
    
    resources :posts do
        resource :comments,except: [:index, :show]
    end
    
    get '/',to:'home#top',as:'root'
    get '/rule',to:'home#rule'
    get '/policy',to:'home#policy'
    devise_for :users, controllers: { registrations: 'users/registrations' }
    devise_scope :user do
        post '/users/profile/edit',to:'users/registrations#update'
        post '/users/profile.img/edit',to:'users/registrations#img_update'
        post '/users/bg.img/edit',to:'users/registrations#bg_img_update'
        post '/users/profile.img/delete',to:'users/registrations#img_delete'
        post '/users/bg.img/delete',to:'users/registrations#bg_img_delete'
    end 
    
    resources :relationships, only: [:create, :destroy]
    resources :notifications, only: [:index]
    
    get 'ranking/:id/fish_size',to:'ranking#fish_size_ranking'
    get '/users/search',to:'users#search'
    get '/users',to:'users#index'
    get '/users/:id',to:'users#show'
    get '/users/:id/likes',to:'users#likes'
    get '/users/:id/comments',to:'users#comments'
    get '/users/:id/following',to:'users#following'
    get '/users/:id/followers',to:'users#followers'
    
    post '/likes/:post_id/create',to:'likes#create'
    post '/likes/:post_id/destroy',to:'likes#destroy'
    
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
