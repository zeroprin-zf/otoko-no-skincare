class Public::BookmarksController < ApplicationController

  def index
    @user = User.find(params[:user_id])#user_idでユーザー個人の情報を取ってくる
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
    @bookmarks = Bookmark.where(user_id: @user.id).page(params[:page]).per(4)
  end

  def create
    @item = Item.find(params[:item_id])
    @bookmark = @item.bookmarks.new(user_id: current_user.id)
    if @bookmark.save
    else
      redirect_to request.referer
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @bookmark = @item.bookmarks.find_by(user_id: current_user.id)
    if @bookmark.present?
        @bookmark.destroy
    else
        redirect_to request.referer
    end
  end
end
