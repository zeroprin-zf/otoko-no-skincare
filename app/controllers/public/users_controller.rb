class Public::UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
  end

  def edit
  end

  def confirm
  end
end
