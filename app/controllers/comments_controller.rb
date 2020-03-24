class CommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  before_action :authenticate_user
  before_action :set_comment, only:[:edit, :update, :destroy]
  
  def new
    
  end
  
  def edit
    
  end
  
  def create
    @post = Post.find_by(id: [params[:post_id]])
    @comment = Comment.new(
      content: params[:content],
      user_id: current_user.id,
      post_id: params[:post_id]
    )
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = 'コメントを投稿しました'
      @status = true
    else
      flash[:alert] = 'コメントの投稿に失敗しました'
      @status = false
    end
  end
  
  
  def update
    if @comment = Comment.update(comment_params)
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = 'コメントを投稿しました'
      @status = true
    else
       flash[:alert] = 'コメントの投稿に失敗しました'
       @status =false
    end
  end
  
      
  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    @status = true
  end

  def ensure_correct_user
    if @comment.user_id != @current_user.id
      flash[:alert] = '権限がありません'
      redirect_to("/posts/#{params[:post_id]}")
    end
  end
  
  private
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
end