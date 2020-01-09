class ApplicationController < ActionController::Base
  before_action :set_current_user,:notifications
    
  def set_current_user
     current_user
  end
  
  def authenticate_user
    if current_user.nil?
      flash[:notice] = 'ログインが必要です'
      redirect_to('/users/sign_in')
    end
  end
  
  def forbid_login_user
    if current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts")
    end
  end
  
  def after_sign_in_path_for(resource)
    posts_path
  end
  
  def notifications
    if current_user
        @notifications = current_user.passive_notifications.all
        @notifications.where(checked: false).each do |notification|
        notification.update_attributes(checked: true)
        end
    end
  end    
    
  def after_sign_in_path_for(resource)
        fmap_path_url
  end
    
end
