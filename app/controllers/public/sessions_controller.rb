# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  def guest_sign_in
   user = User.guest
   sign_in user
   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_in_path_for(resource)
    items_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def user_state
    user = User.find_by(email: params[:user][:email])
    # もしuserの中にemailが一致するデータが無ければこの処理を終了する
    return if user.nil?
    # emailの一致するcustomerに対してパスワードが一致しない場合この処理を終了する
    return unless user.valid_password?(params[:user][:password])
    return if user.is_active
    flash[:error] = "退会済みです。再度ご登録をしてご利用ください"
    redirect_to new_user_session_path
  end
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