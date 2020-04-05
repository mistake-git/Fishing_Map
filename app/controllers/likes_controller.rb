class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post,only: [:create, :destroy, :ensure_correct_user]
  before_action :set_like,only: [:destroy, :ensure_correct_user]

 
  
  def create
    @like = Like.new(user_id: current_user.id, post_id: @post.id)
    @like.save
    @post.create_notification_like!(current_user)
  end
  
  def destroy
    @like.destroy
  end
  
  def ensure_correct_user
    if @like.user_id != current_user.id
      redirect_to("/posts/#{params[:post_id]}")
    end
  end
    
  
    
  private
  def set_like
     @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
  
end