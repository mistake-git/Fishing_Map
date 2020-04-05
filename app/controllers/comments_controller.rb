class CommentsController < ApplicationController
  before_action :set_post, only:[ :new, :create, :edit, :update, :destroy]
  before_action :set_comment, only:[:edit, :update, :destroy, :ensure_correct_user]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  
  PER = 16
  
  def new
    @comment = Comment.new
  end
  
  def edit
    
  end
  
  def create
    @comments = Comment.where(post_id: @post.id).page(params[:page]).per(5)
    @comment = Comment.new(
      content: params[:content],
      user_id: current_user.id,
      post_id: params[:post_id]
    )
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = "コメントを投稿しました"
      @status = true
    else
      flash[:alert] = "コメントの投稿に失敗しました"
      @status = false
    end
  end
  
  
  def update
    if @comment = Comment.update(comment_params)
      flash[:success] = "コメントを投稿しました"
      @status = true
    else
       flash[:alert] = "コメントの投稿に失敗しました"
       @status = false
    end
  end
  
      
  def destroy
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    @status = true
  end

  def ensure_correct_user
    if @comment.user_id != current_user.id
      flash[:alert] = "権限がありません"
      redirect_to("/posts/#{params[:post_id]}")
    end
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
  
end