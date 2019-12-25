class UsersController < ApplicationController
    before_action :authenticate_user, only: %i[index show edit update]
    before_action :forbid_login_user, only: %i[new create login_form login]
    before_action :ensure_correct_user, only: %i[edit update]
    PER = 8
    
    def index
        @users = User.page(params[:page]).per(PER)
        @title="釣り人一覧"
    end
    
    def search
        @title="検索結果"
        @users = User.search(params[:search]).page(params[:page]).per(PER)
        render('users/index')
    end
    
    def show
        @user = User.find_by(id: params[:id])
        if current_user.id == @user.id
            @title = "あなたのページ"
        else
            @title = "#{@user.name}さんのページ"
        end
        @posts = @user.posts.page(params[:page]).per(PER)
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="釣果が登録されていません"
    end   
    
    def likes
        @user = User.find_by(id: params[:id])
        @likes = Like.where(user_id: @user.id).page(params[:page]).per(PER)
        @title="#{@user.name}さんのページ"
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="いいねした釣果がありません"
    end  
    
    def comments
        @user = User.find_by(id: params[:id])
        @comments = Comment.where(user_id: @user.id).page(params[:page]).per(PER)
        @title="#{@user.name}さんのページ"
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="まだコメントがありません"
    end  
    
    def following
        @user  = User.find_by(id: params[:id])
        @users = @user.following.page(params[:page]).per(PER)
        @title ="#{@user.name}さんがフォロー中"
        @when_not_text = "フォローしているユーザーがいません"
    end

    def followers
        @user  = User.find_by(id: params[:id])
        @users = @user.followers.page(params[:page]).per(PER)
        @title ="#{@user.name}さんのフォロワー"
        @when_not_text = "フォロワーがいません"
    end
    
    def ensure_correct_user
        if current_user.id != params[:id].to_i
          flash[:notice] = '権限がありません'
          redirect_to('/posts')
        end
    end
end
