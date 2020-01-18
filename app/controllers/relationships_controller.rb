class RelationshipsController < ApplicationController
   before_action :authenticate_user
   
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    flash[:notice] = "フォローしました｡フォローすると釣果の通知を受け取る事ができます｡"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    flash[:notice] = "フォローを解除しました｡"
    redirect_back(fallback_location: root_path)
  end

end