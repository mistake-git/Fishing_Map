class HomeController < ApplicationController
before_action :forbid_login_user, only: [:top]

  def top
  end
  
  def rule
  end
  
  def policy
  end
  
  def health
    render json: {result: "success"},statu: :ok
  end
  
end
