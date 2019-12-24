class CommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @post = Post.find_by(id: [params[:id]])
    @comment = Comment.new(
      content: params[:content],
      user_id: current_user.id,
      post_id: params[:post_id]
    )
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      flash[:notice] = 'コメントを投稿しました'
      redirect_to("/posts/#{params[:post_id]}")
    else
       flash[:notice] = 'コメントの投稿に失敗しました'
      redirect_to("/posts/#{params[:post_id]}")
    end
  end
      
  def destroy
    @comment = Comment.find_by(id: params[:comment_id])
    @comment.destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to("/posts/#{params[:post_id]}")
  end

  def ensure_correct_user
    @comment = Comment.find_by(id: params[:comment_id])
    if @comment.user_id != @current_user.id
      flash[:danger] = '権限がありません'
      redirect_to("/posts/#{params[:post_id]}")
    end
  end
end