class ApplicationController < ActionController::Base
  before_action :set_current_user
    
  def set_current_user
     current_user
  end
  
  def authenticate_user
    if current_user.nil?
      flash[:alert] = 'ログインが必要です'
      redirect_to('/users/sign_in')
    end
  end
  
  def forbid_login_user
    if current_user
      flash[:alert] = "すでにログインしています"
      redirect_to("/fishing.map")
    end
  end
  
  def admin_user
    unless current_user.admin?
      flash[:alert] = '管理者権限がありません'
      redirect_to("/fishing.map")
    end
  end
    
  def after_sign_in_path_for(resource)
        fmap_path_url
  end
    
end
