class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :withdraw]

  def index
    @users = User.all
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
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
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

  def withdraw
    user = current_user
    user.update(is_active: false)
    Item.where(user_id: current_user.id).destroy_all#itemとそれに関連してる情報は削除される
    reset_session
    redirect_to root_path,notice: "退会処理を実行しました"
  end

  def favorited
    @user = User.find(params[:id])
    @favorited = Item.favorited(@user).page(params[:page]).per(4)
  end

  private
   def set_user
     @user = User.find(params[:id])
   end

   def user_params
     params.require(:user).permit(:name, :introduction, :profile_image)
   end

   def ensure_guest_user
     @user = User.find(params[:id])
     if @user.email == "guest@example.com"
       redirect_to user_path(current_user) , notice: "ゲストユーザーのプロフィール編集画面には遷移できません。"
     end
   end
end
