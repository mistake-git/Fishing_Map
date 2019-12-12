class ApplicationController < ActionController::Base
  before_action :set_current_user
    
  def set_current_user
     current_user
  end
  
  def forbid_login_user
    if current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts")
    end
  end
    
end
