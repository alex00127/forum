class Admin::CategoriesController < ApplicationController
  before_action :set_category, :only => [:destroy, :update, :edit]

  layout "admin"

  def update
    if @category.update(category_params)    
      flash[:notice] = "Category was successfully updated"
      redirect_to admin_topics_path
    end
  end

  def create
  	@category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to admin_topics_path
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "Category was successfully deleted"
    redirect_to admin_topics_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
