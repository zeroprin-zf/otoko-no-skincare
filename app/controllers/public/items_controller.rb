class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @items = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      flash[:notice] = "投稿に成功しました"
      redirect_to items_path  #ここは詳細に変更するかもしれない
    else
      flash.now[:notice] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

  private
  #itemの奴もいるのか
  def item_params
    params.require(:item).permit(:image,:review, :name, :value,:category_id)
  end
end
