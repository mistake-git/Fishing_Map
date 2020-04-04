class UsersController < ApplicationController
    before_action :set_user,only: [:show, :likes, :comments, :following, :followers]
    before_action :authenticate_user!, only: [ :edit, :update]
    before_action :forbid_login_user, only: [:new, :create,]
    before_action :ensure_correct_user, only: [:edit, :update]
    before_action :set_data, only:[:show, :likes, :comments]
    
    PER = 16
    
    def index
        @users = User.order(created_at: :desc).page(params[:page]).per(PER)
        @title ="釣り人一覧"
    end
    
    def search
        @title="検索結果"
        @users = User.search(params[:search]).order(created_at: :desc).page(params[:page]).per(PER)
        render('users/index')
    end
    
    def show
        if current_user && current_user.id == @user.id
            @title = "あなたのページ"
        else
            @title = "#{@user.name}さんのページ"
        end
        @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(PER)
        @when_not_text ="釣果が登録されていません"
    end   
    
    def likes
        @likes = @user.likes
        @posts = @user.likes_posts.order(created_at: :desc).page(params[:page]).per(PER)
        @title="#{@user.name}さんのページ"
        @when_not_text ="いいねした釣果がありません"
    end  
    
    def comments
        @posts = @user.posts
        @comments = Comment.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(5)
        @title="#{@user.name}さんのページ"
        @when_not_text ="まだコメントがありません"
    end  
    
    def following
        @users = @user.following.page(params[:page]).per(PER)
        @title ="#{@user.name}がフォロー中"
        @when_not_text = "フォローしているユーザーがいません"
    end

    def followers
        @users = @user.followers.page(params[:page]).per(PER)
        @title ="#{@user.name}のフォロワー"
        @when_not_text = "フォロワーがいません"
    end
    
    def ensure_correct_user
        if current_user.id != params[:id].to_i
          flash[:alert] = '権限がありません'
          redirect_to('/posts')
        end
    end
    
    private
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def set_data
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @fish = @user.posts
        @user_data = @fish.group(:name).sum(:number)
    end
    
end
