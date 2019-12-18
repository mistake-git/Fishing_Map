class UsersController < ApplicationController
    
    def index
        @users = User.all
        @title="釣り人一覧"
    end
    
    def search
        @title="釣り人一覧"
        @users = User.search(params[:search])
        redirect_to('/users')
    end
    
    def show
        @user = User.find_by(id: params[:id])
        @title="#{@user.name}さんのページ"
    end   
    
    def likes
        @user = User.find_by(id: params[:id])
        @likes = Like.where(user_id: @user.id)
        @title="#{@user.name}さんのページ"
    end  
    
    def comments
        @user = User.find_by(id: params[:id])
        @title="#{@user.name}さんのページ"
    end  
end
