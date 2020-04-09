class LikesController < ApplicationController
  before_action :authenticate_user
  before_action :authenticate_user!
  before_action :set_post,only: [:create, :destroy, :ensure_correct_user,:set_data]
  before_action :set_like,only: [:destroy, :ensure_correct_user]
  before_action :set_data,only: [:create, :destroy]
  

 
  
  def create
    @like = Like.new(user_id: current_user.id, post_id: @post.id)
    @like.save
     flash[:success] = "いいね!しました"
    @post.create_notification_like!(current_user)
  end
  
  def destroy
    @like.destroy
    flash[:success] = "いいね!を取り消しました"
  end
  
  # def ensure_correct_user
  #   if @like.user_id != current_user.id
  #     redirect_to("/posts/#{params[:post_id]}")
  #   end
  # end
  
  def set_data
    @likes_count = @post.likes.count
    @comments_count = Comment.where(post_id: @post.id).count
  end
    
  
    
  private
  def set_like
     @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
     pp "set_like: #{@like}"
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
  
end