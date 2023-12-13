class Public::SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    #@items = Item.search_for(@keyword)
    @items = search_results(@keyword)
  end

  private

  def search_results(keyword)
    Item.where("name LIKE ?", "%#{keyword}%")
  end
end