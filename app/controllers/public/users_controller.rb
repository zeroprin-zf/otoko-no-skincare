class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
  end

  def favorites
    favorites = Favorite.where(user_id: @user).pluck(:item_id)
    @favorite_item = Item.find(favorites)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールの編集に成功しました"
      redirect_to user_path(@user.id)
    else
      flash.now[:notice] = "プロフィールの編集に失敗しました"
      render :edit
    end
  end

  def confirm
  end

  def favorited
    @favorited = Item.favorited(current_user)
  end

  private
   def set_user
     @user = User.find(params[:id])
   end

   def user_params
     params.require(:user).permit(:name, :introduction, :profile_image)
   end
end
