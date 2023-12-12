class Public::CommentsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @comment = Comment.new
  end

  def create
    item = Item.find(params[:item_id])
    comment = current_user.comments.new(comment_params)
    comment.item_id = item.id
    comment.save
    redirect_to item_path(item)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
