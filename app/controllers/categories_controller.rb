# frozen_string_literal: true

# Category
class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @search = @category.posts.ransack(params[:q])
    @posts = @search.result.page(params[:page]).per(10)
  end
end
