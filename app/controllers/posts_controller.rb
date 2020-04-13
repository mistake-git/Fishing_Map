class PostsController < ApplicationController
  before_action :set_twitter_client,only: [:create]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :ensure_correct_user]
  before_action :set_current_user
  before_action :authenticate_user!,only:[:new, :edit, :create, :update,:destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  PER = 16

  # GET /posts
  # GET /posts.json
  
  def fishing_map
    @posts = Post.all.order(created_at: :desc).limit(100).page(params[:page]).per(100)
    @user = current_user
  end
  
  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(PER)
    @title ="すべての釣果"
    @when_not_text = "まだ釣果の投稿がありません"
  end
  
  def search_fishing_map
    
    @posts = Post.search(params[:name]).order(created_at: :desc).page(params[:page]).per(1)
    @posts = Post.search(params[:feed]).order(created_at: :desc).page(params[:page]).per(1)
    @posts = Post.search(params[:date]).order(created_at: :desc).page(params[:page]).per(1)
    @posts = Post.search(params[:season]).order(created_at: :desc).page(params[:page]).per(1)
    @posts = Post.search(params[:adress]).order(created_at: :desc).page(params[:page]).per(1)
    @posts = Post.search(params[:time]).order(created_at: :desc).page(params[:page]).per(1)
    
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
    @comment = Comment.new
    @user = @post.user
    @fish = Fish.find_by(name: @post.name)
    if @fish 
        @level = "★"*@fish.level
    else
        @level = nil
    end
    
    if current_user && current_user.id == @user.id
       @title = "あなた"
    else
       @title = "#{@user.name}さん"
    end
    @comments = Comment.where(post_id: @post.id).order(created_at: :desc).page(params[:page]).per(PER)
    @likes_count = @post.likes.count
    @comments_count = Comment.where(post_id: @post.id).count
    same_fish_posts = Post.where(name: @post.name)
    @month_data = (1..12).to_a.map do |month|
        posts = same_fish_posts.filter do |post|
            post.date.month == month
        end
        posts_number = posts.map do |post|
            post.number
        end
        posts_number.sum
        ["#{month}月",posts_number.sum]
    end

    @feed_data = same_fish_posts.where.not(feed: "").group(:feed).sum(:number)
    
    
    @size_data = (1..10).to_a.map do |size|
        posts =  same_fish_posts.where(size: (size*10-10)..(size*10)-1)
        posts_number = posts.map do |post|
           post.number
        end
        label = "#{(size-1)*10}~#{(size*10)-1}cm"
        posts_number.sum
        [label,posts_number.sum]
    end

    @time_data = (0..23).to_a.map do |time|
        posts = same_fish_posts.filter do |post|
            post.time.hour == time
        end
        posts_number = posts.map do |post|
              post.number
        end
        label = "#{time}時"
        posts_number.sum
        [label,posts_number.sum]
    end
    
  end

  # GET /posts/new
  def new
    @user = current_user
    @post = Post.new
    @form_title = '釣果を登録'
    @is_new = "true"
  end

  # GET /posts/1/edit
  def edit
    @user = current_user
    @form_title ='釣果を編集'
    @is_new = "false"
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
        
        #Twitterにも共有
        if @post.share == "true"
          image = File.new("app/assets/images/top-img.jpg", "r")
          @twitter.update_with_media("
          #{@post.address}で#{@post.name}を釣ったよ!
          #{ENV['HOST']}/posts/#{@post.id}
          ",image)
        end
        
        #通知がフォロワーに行く
        @user.followers.each do |follower|
            visited_id = follower.id
            post_id = @post.id
            @user.create_notification_post!(visited_id,current_user,post_id)
        end
        
        format.html { redirect_to @post, notice: '釣果を投稿しました' }
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
        format.html { redirect_to @post, notice: '釣果を編集しました' }
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
      format.html { redirect_to posts_url, notice: '釣果を削除しました' }
      format.json { head :no_content }
    end
  end
  

  def ensure_correct_user
    if @post.user_id != current_user.id
      flash[:alert] = '権限がありません'
      redirect_to('/posts')
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :feed,:weather,:description,:number,:date,:address, :latitude, :longitude,:user_id,:size,:time, :image,:share)
    end
    
    def ensure_correct_user
      @post = Post.find_by(id: params[:id])
      if @post.user_id != current_user.id
        flash[:alert] = '権限がありません'
        redirect_to('/posts')
      end
    end
    
    def set_twitter_client
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        =  ENV['TWITTER_API_KEY']
        config.consumer_secret     =  ENV['TWITTER_API_SECRET']
        config.access_token        =  ENV['ACCESS_TOKEN']
        config.access_token_secret =  ENV['ACCESS_SECRET'] 
      end
    end
end
