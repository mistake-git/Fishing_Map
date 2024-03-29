class UsersController < ApplicationController
    before_action :set_user,only: [:show, :likes, :comments, :following, :followers]
    before_action :authenticate_user!, only: [ :edit, :update]
    before_action :forbid_login_user, only: [:new, :create,]
    before_action :ensure_correct_user, only: [:edit, :update]
    
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
        @likes_posts = @user.likes_posts.order(created_at: :desc).page(params[:page]).per(PER)
        @comments = @user.comments.order(created_at: :desc).page(params[:page]).per(5)
        @fish = @user.posts
        @user_data = @fish.group(:name).sum(:number)
        @likes = @user.likes
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
    
    def img_update
       @user = current_user
       if params[:user] && params[:user][:image]
            @user.image.purge
            @user.image.attach(params[:user][:image])
       end
       flash[:notice] = "プロフィール画像を変更しました"
       redirect_to("/users/#{current_user.id}")
    end
   
   def bg_img_update
       @user = current_user
       if params[:user] && params[:user][:bg_image]
            @user.bg_image.purge
            @user.bg_image.attach(params[:user][:bg_image])
       end
       flash[:notice] = "背景画像を変更しました"
       redirect_to("/users/#{current_user.id}")
   end
   
   
   def img_delete
       @user = current_user
       if @user.image.attached?
            @user.image.purge
       end
       flash[:notice] = "プロフィール画像を削除しました"
       redirect_to("/users/#{current_user.id}")
   end
   
   def bg_img_delete
       @user = current_user
       if @user.bg_image.attached?
            @user.bg_image.purge
       end
       flash[:notice] = "背景画像を削除しました"
       redirect_to("/users/#{current_user.id}")
   end
   
    
private
    
    def set_user
        @user = User.find(params[:id])
    end
    
end
