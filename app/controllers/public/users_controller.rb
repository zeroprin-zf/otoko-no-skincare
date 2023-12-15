class Public::UsersController < ApplicationController
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
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def confirm
  end

  private
   def set_user
     @user = User.find(params[:id])
   end

   def user_params
     params.require(:user).permit(:name, :introduction, :profile_image)
   end
end
