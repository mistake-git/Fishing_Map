class UsersController < ApplicationController
    
    def index
        @users = User.all
        @title="釣り人一覧"
    end
    
    def search
        @title="釣り人一覧"
        @users = User.search(params[:search])
        render('users/index')
    end
    
    def show
        @user = User.find_by(id: params[:id])
        @title="#{@user.name}さんのページ"
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="釣果が登録されていません"
    end   
    
    def likes
        @user = User.find_by(id: params[:id])
        @likes = Like.where(user_id: @user.id)
        @title="#{@user.name}さんのページ"
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="いいねした釣果がありません"
    end  
    
    def comments
        @user = User.find_by(id: params[:id])
        @comments = Comment.where(user_id: @user.id)
        @title="#{@user.name}さんのページ"
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="まだコメントがありません"
    end  
    
    def following
        @user  = User.find_by(id: params[:id])
        @users = @user.following
        @title ="#{@user.name}さんがフォロー中"
        @when_not_text = "フォローしているユーザーがいません"
    end

    def followers
        @user  = User.find_by(id: params[:id])
        @users = @user.followers
        @title ="#{@user.name}さんのフォロワー"
        @when_not_text = "フォロワーがいません"
    end
end
