class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @categories = Category.all
    @category = Category.new(category_params)
    #@category.user_id = current_user.id
    if @category.save
     redirect_to request.referer
    else
      render :index
    end
  end

  def new
  end

  def edit
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to request.referer
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
