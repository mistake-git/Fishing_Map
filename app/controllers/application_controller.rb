class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  include AjaxHelper 
  
  def set_current_user
      current_user
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
  
  def authenticate_user
    if current_user==nil
      flash[:notice]="ログインが必要です"
      respond_to do |format|
        format.js { render ajax_redirect_to"/users/sign_in" }
      end
    end
  end
  
  def server_error(e)
    
    ExceptionNotifier.notify_exception(e, :env => request.env, :data => {:message => "error"})
    respond_to do |format|
      format.html { render template: 'front/errors/500', layout: 'front/layouts/error', status: 500 }
      format.all { render nothing: true, status: 500 }
    end
  
  end
    
  def after_sign_in_path_for(resource)
        fmap_path_url
  end
    
end
