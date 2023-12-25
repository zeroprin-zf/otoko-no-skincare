class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.all
    #@item = Item.find(params[:item_id])
    @favorites = Favorite.all.where(user_id: current_user.id).page(params[:page]).per(3)
  end

  def create
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.new(item_id: @item.id)
    favorite.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
  end
end
