# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?


   #GET /resource/sign_up
   def new
      @user = User.new
   end

   def create
      @user = User.new(
      name: params[:user][:name],
      email: params[:user][:email],
      address: params[:user][:address],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
     )
      if @user.save
      flash[:notice] = 'アカウントを作成しました'
      sign_in(@user)
      redirect_to('/fishing.map')
      else
      render('users/registrations/new')
      end
   end



   def edit
    @user = current_user
   end
   
   def update
    @user = current_user
    if @user.update(
      name: params[:user][:name],
      email: params[:user][:email],
      introduce: params[:user][:introduce],
      address: params[:user][:address]
    )
      flash[:notice] = 'ユーザー情報を編集しました'
      redirect_to("/users/#{current_user.id}")
    else
      render('users/registrations/edit')
    end
   end
   
   def img_update
       @user = current_user
       if params[:user] && params[:user][:image]
            @user.image.purge
            @user.image.attach(params[:user][:image])
       end
       flash[:notice] = 'プロフィール画像を変更しました'
       redirect_to("/users/#{current_user.id}")
   end
   
   def bg_img_update
       @user = current_user
       if params[:user] && params[:user][:bg_image]
            @user.bg_image.purge
            @user.bg_image.attach(params[:user][:bg_image])
       end
       flash[:notice] = '背景画像を変更しました'
       redirect_to("/users/#{current_user.id}")
   end
   
   
   def img_delete
       @user = current_user
       if @user.image.attached?
            @user.image.purge
       end
       flash[:notice] = 'プロフィール画像を削除しました'
       redirect_to("/users/#{current_user.id}")
   end
   
   def bg_img_delete
       @user = current_user
       if @user.bg_image.attached?
            @user.bg_image.purge
       end
       flash[:notice] = '背景画像を削除しました'
       redirect_to("/users/#{current_user.id}")
   end
   
   
 
   

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name],keys:[:address])
  end
end
