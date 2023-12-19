class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @item = Item.find(params[:item_id])
    @comment = Comment.new
  end

  def create
    item = Item.find(params[:item_id])
    @comment = current_user.comments.new(comment_params)
    @comment.item_id = item.id
    @comment.save
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
