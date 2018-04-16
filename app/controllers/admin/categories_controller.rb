module Admin
  # come on!
  class CategoriesController < ApplicationController
    before_action :set_catogory, only: [:update, :destroy]

    def index
      @categories = Category.page(params[:page]).per(10)
      if params[:id]
        set_catogory
      else
        @category = Category.new
      end
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:notice] = "#{@category.name} was successfully created"
        redirect_to admin_categories_path
      else
        flash[:notice] = "#{@category.name} created fail"
        @categories = Category.all
        render :index
      end
    end

    def update
      if @category.update(category_params)
        redirect_to admin_categories_path
        flash[:notice] = "#{@category.name} was successfully updated"
      else
        @categories = Category.all
        render :index
      end
    end

    def destroy
      @category.destroy
      flash[:alert] = "#{@category.name} was successfully deleted"
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def set_catogory
      @category = Category.find(params[:id])
    end
  end
end
