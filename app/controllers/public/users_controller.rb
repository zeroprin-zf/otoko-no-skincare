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
  end

  def confirm
  end

  private
   def set_user
     @user = User.find(params[:id])
   end
end
