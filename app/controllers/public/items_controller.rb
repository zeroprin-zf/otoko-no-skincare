class Public::ItemsController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:latest]
      @items = Item.latest.page(params[:page]).per(3)#ビューから指示を受けるための名前を定義
    elsif params[:old]
      @items = Item.old.page(params[:page]).per(3)
    elsif params[:star_count]
      @items = Item.star_count.page(params[:page]).per(3)
    else
      @items = Item.all.page(params[:page]).per(3)#ページネーションはすべての定義に必要
    end
    @categories = Category.all

    to = Time.current.at_end_of_day#未完成
    from = (to - 6.day).at_beginning_of_day
    @item = Item.includes(:favorited_users).
     sort_by {|x|
       x.favorited_users.includes(:favorites).where(created_at: from...to).size
     }.reverse
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
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
    unless @item.user == current_user #エラー出るかも
      redirect_to  item_path(@item.id)
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "投稿の編集に成功しました"
      redirect_to item_path(@item.id)
    else
      flash.now[:notice] = "投稿の編集に失敗しました"
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

  private
  #itemの奴もいるのか
  def item_params
    params.require(:item).permit(:image,:review, :name, :value,:category_id, :star)
  end
end
