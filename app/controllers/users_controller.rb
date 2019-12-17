class UsersController < ApplicationController
    
    def index
        @users = User.all
        @title="釣り人一覧"
    end
    
    def show
        @user = User.find_by(id: params[:id])
        @title="#{@user.name}さんのページ"
    end    
end
