class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
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
    @item.save #rollbackする
    redirect_to items_path  #ここは詳細に変更するかもしれない
  end

  def edit
  end

  private
  #itemの奴もいるのか
  def item_params
    params.require(:item).permit(:image,:review, :name, :value,:category_id)
  end
end
