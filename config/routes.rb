Rails.application.routes.draw do
  resources :posts
  get '/',to:'home#top'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  devise_scope :user do
      post '/users/profile/edit',to:'users/registrations#update'
  end      
      
  
  get '/users',to:'users#index'
  get '/users/:id',to:'users#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
