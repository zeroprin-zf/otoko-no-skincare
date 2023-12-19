class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @keyword = params[:keyword]
    #@items = Item.search_for(@keyword)
    @results = search_results(@keyword).page(params[:page]).per(3)
    @categories = Category.all
  end

  def category_search
    @category_id = params[:category_id]
    @items = Item.where(category_id: @category_id)
    @categories = Category.all.page(params[:page]).per(3)
    @category = Category.find(params[:category_id])
  end

  private

  def search_results(keyword)
    Item.where("name LIKE ?", "%#{keyword}%")
  end
end