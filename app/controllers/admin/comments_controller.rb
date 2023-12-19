class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @item = Item.find(params[:item_id])
    #@comment = Comment.new
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_item_comments_path
    #comment = Comment.find(params[:id])
    #comment.destroy
    #redirect_to admin_item_comments_path
  end
end
