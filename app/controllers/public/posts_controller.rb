class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @posts = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path  #ここは詳細に変更するかもしれない
  end

  def edit
  end

  private
  #itemの奴もいるのか
  def post_params
    params.require(:post).permit(:review)
  end
end
