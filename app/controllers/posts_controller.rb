class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end
  
  def search
    @posts= Post.search(params[:search])
    redirect_to('/posts')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
     @post = Post.find_by(id: params[:id])
     @user = @post.user
     @level ="★"
     @likes_count = Like.where(post_id:@post.id).count
     #その投稿のnameの数を月ごとに集計したい
     @data1 =[
            ['1月', 100],
            ['2月', 70], 
            ['3月', 15],
            ['4月', 80],
            ['5月', 90],
            ['6月', 80],
            ['7月', 40],
            ['8月', 40],
            ['9月', 80],
            ['10月', 200],
            ['11月', 20],
            ['12月', 60]
            ]
    #その投稿のnameの数を餌ごとに集計したい
    @data2 =[
            ['ゴカイ', 100],
            ['イソメ', 70], 
            ['アカムシ', 15],
            ['オキアミ', 80],
            ['カニ', 90],
            ['貝', 80],
            ['配合エサ', 40],
            ['ミミズ', 40],
            ['練りエサ', 80],
            ['アカムシ', 200],
            ['ルアー', 20]
            ]
            
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(
        post_params.merge(user_id: current_user.id)
        )

    respond_to do |format|
      if @post.save
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
      params.require(:post).permit(:image,:name, :feed,:weather,:description,:number,:date,:address, :latitude, :longitude,:user_id)
    end
end
