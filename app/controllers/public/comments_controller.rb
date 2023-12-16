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
    if @comment.save
       flash[:notice] = "コメントに成功しました"
       redirect_to item_path(item)
    else
      flash.now[:notice] = "コメントに失敗しました"
      render :index
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
