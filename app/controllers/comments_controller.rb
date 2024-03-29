class CommentsController < ApplicationController
  before_action :set_post, only:[ :new, :create, :edit, :update, :destroy]
  before_action :set_comment, only:[:edit, :update, :destroy, :ensure_correct_user]
  before_action :set_comments, only:[:create, :update,:destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  
  PER = 16
  
  def new
    @comment = Comment.new
  end
  
  def edit
    
  end
  
  def create
    @comment = Comment.new(
      comment_params.merge(user_id: current_user.id,post_id: @post.id)
    )
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:success] = "コメントを投稿しました"
      @status = true
    else
      @status = false
    end
  end
  
  
  def update
    if @comment = Comment.update(comment_params)
      flash[:success] = "コメントを編集しました"
      @status = true
    else
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
  
  def set_comments
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(PER)
  end
  
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
  
end