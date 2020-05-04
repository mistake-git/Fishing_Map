Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/create'
    devise_scope :user do
        post '/users/profile/edit',to:'users/registrations#update'
    end 
    resources :fish,except: [:show]
    get '/fishing.map',to:'posts#fishing_map',as:'fmap_path'
    
    resources :posts do
        resources :comments,except: [:index, :show]
        resources :likes,only: [:create, :destroy]
    end
    
    get '/posts/:tag_id/tag',to:'posts#same_tag'
    
    get '/',to:'home#top',as:'root'
    get '/rule',to:'home#rule'
    get '/policy',to:'home#policy'
    
    devise_for :users, controllers: { registrations: 'users/registrations',
                                      omniauth_callbacks: 'users/omniauth_callbacks' 
    }
    resources :relationships, only: [:create, :destroy]
    resources :notifications, only: [:index]
    resources :contacts, only: [:new, :create]
    
    get 'ranking/:id/fish_size',to:'ranking#fish_size_ranking'
    get '/users/search',to:'users#search'
    get '/users',to:'users#index'
    get '/users/:id',to:'users#show'
    get '/users/:id/following',to:'users#following'
    get '/users/:id/followers',to:'users#followers'
    post '/users/profile.img/update',to:'users#img_update'
    post '/users/bg.img/update',to:'users#bg_img_update'
    post '/users/profile.img/delete',to:'users#img_delete'
    post '/users/bg.img/delete',to:'users#bg_img_delete'
    
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    end
