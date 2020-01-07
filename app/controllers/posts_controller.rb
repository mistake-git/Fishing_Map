class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[edit update destroy]
  PER = 8

  # GET /posts
  # GET /posts.json
  
  def fishing_map
    @posts = Post.all.order(created_at: :desc).limit(100)
    @user = current_user
    @fish_data = [
            ['タイ', 100],
            ['サメ', 70], 
            ['サバ', 15],
            ['アジ', 80],
            ['カサゴ', 90],
            ['メバル', 100],
            ['イカ', 70], 
            ['バス', 15],
            ['アナゴ', 80],
            ['アイナメ', 90]
            ]
    @is_fmap = true
  end
  
  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(PER)
    @title ="すべての釣果"
  end
  
  def search_fishing_map
    @posts = Post.search(params[:search]).order(created_at: :desc).page(params[:page]).per(1)
    @user = current_user
    @title ="検索結果"
    @is_search = true
    render('posts/fishing_map')
  end
  
  def search
    @posts = Post.search(params[:search]).order(created_at: :desc).page(params[:page]).per(PER)
    @title ="検索結果"
    render('posts/index')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @level ="★"
    if current_user.id == @user.id
            @title = "あなた"
        else
            @title = "#{@user.name}さん"
    end
    @likes_count = Like.where(post_id: @post.id).count
    @comments = Comment.where(post_id: @post.id).page(params[:page]).per(PER)
    @comments_count = Comment.where(post_id: @post.id).count
    
    #その投稿のnameの数を月ごとに集計したい
    @month_data = [
        ['タイ', 100],
            ['サメ', 70], 
            ['サバ', 15],
            ['アジ', 80],
            ['カサゴ', 90],
            ['メバル', 100],
            ['イカ', 70], 
            ['バス', 15],
            ['アナゴ', 80],
            ['アイナメ', 90]
            ]
    
    #その投稿のnameの数を餌ごとに集計したい 例[[ゴカイ,10],[アカムシ,7],[カニ,5]]
    @feed_data = Post.where(name: @post.name).where("feed IS NOT NULL").order('count(:feed) desc').limit(3)
    
    #サイズの分布データを集計したい
    @size_data = Post.where(name: @post.name).sum(:size)
    
    #どの時間帯に釣れているのか集計したい
    @time_data = Post.where(name: @post.name).sum(:time)
            
  end

  # GET /posts/new
  def new
    @user = current_user
    @post = Post.new
    @form_title = '釣果を登録'
  end

  # GET /posts/1/edit
  def edit
      @form_title ='釣果を編集'
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @post = Post.new(
        post_params.merge(user_id: current_user.id)
        )
    respond_to do |format|
      if @post.save
        @user.followers.each do |follower|
            follower_id = follower.id
            @user.create_notification_post!(follower_id,current_user)
        end
        format.html { redirect_to @post, notice: '投稿を作成しました' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '投稿を編集しました' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image,:name, :feed,:weather,:description,:number,:date,:address, :latitude, :longitude,:user_id,:size,:time)
    end
    
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      flash[:danger] = '権限がありません'
      redirect_to('/posts')
    end
  end
end
