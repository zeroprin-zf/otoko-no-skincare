class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
  end

  def edit
  end

  def confirm
    @user = User.find(params[:user_id])
  end

  def withdraw
    user = User.find(params[:user_id])#current_user？U
    user.update(is_active: false)
    reset_session
    redirect_to admin_path,notice: "退会処理を実行しました"
  end

end
