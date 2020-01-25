class UsersController < ApplicationController
    before_action :authenticate_user, only: %i[index show edit update]
    before_action :forbid_login_user, only: %i[new create login_form login]
    before_action :ensure_correct_user, only: %i[edit update]
    PER = 8
    
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
        @user = User.find_by(id: params[:id])
        if current_user.id == @user.id
            @title = "あなたのページ"
        else
            @title = "#{@user.name}さんのページ"
        end
        @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(PER)
        @fishes = @user.posts
        @user_data = @fishes.group(:name).sum(:number)
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="釣果が登録されていません"
    end   
    
    def likes
        @user = User.find_by(id: params[:id])
        @fishes = @user.posts
        @user_data = @fishes.group(:name).sum(:number)
        @likes = @user.likes
        @posts = @user.likes_posts.order(created_at: :desc).page(params[:page]).per(PER)
        @title="#{@user.name}さんのページ"
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="いいねした釣果がありません"
    end  
    
    def comments
        @user = User.find_by(id: params[:id])
        @posts = @user.posts
        @user_data = @posts.group(:name).sum(:number)
        @comments = Comment.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(5)
        @title="#{@user.name}さんのページ"
        @user_posts_count = Post.where(user_id: @user.id).count
        @user_likes_count = Like.where(user_id: @user.id).count
        @user_comments_count = Comment.where(user_id: @user.id).count
        @when_not_text ="まだコメントがありません"
    end  
    
    def following
        @user  = User.find_by(id: params[:id])
        @users = @user.following.page(params[:page]).per(PER)
        @title ="#{@user.name}がフォロー中"
        @when_not_text = "フォローしているユーザーがいません"
    end

    def followers
        @user  = User.find_by(id: params[:id])
        @users = @user.followers.page(params[:page]).per(PER)
        @title ="#{@user.name}のフォロワー"
        @when_not_text = "フォロワーがいません"
    end
    
    def ensure_correct_user
        if current_user.id != params[:id].to_i
          flash[:notice] = '権限がありません'
          redirect_to('/posts')
        end
    end
end
