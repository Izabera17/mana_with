# frozen_string_literal: true
class Users::SessionsController < Devise::SessionsController
    before_action :reject_inactive_user, only: [:create]
    
   def guest_sign_in
    user = User.find_or_create_by(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー" 
    end
    sign_in user #
    redirect_to home_path, notice: "ゲストユーザーとしてログインしました"
  end
 
  def reject_inactive_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_valid
        redirect_to new_user_session_path
      end
    end
  end
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
