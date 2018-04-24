# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_post, only: %i[show edit update destroy]
  def index
    @posts = Post.page(params[:page]).per(10)
    @categories = Category.all
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    set_post_status

    if @post.save
      post_redirect(@post)
    else
      render :new
      flash[:alert] = "#{@post.title} was failed to create"
    end
  end

  def update
    set_post_status
    if @post.update(post_params)
      post_redirect(@post)
    else
      render :edit
      flash[:alert] = "#{@post.title} was failed to update"
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def feeds; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_sort
    @sort = Sort.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content, :photo, :status,
                                 :comments_count, :viewed_count, :who_can_see,
                                 category_ids: [])
  end

  def post_redirect(post)
    if post.publish?
      redirect_to post_path(post)
    else
      redirect_to draft_user_path(post.user_id)
    end
    flash[:notice] = "#{@post.title} was successfully updated"
  end

  def set_post_status
    @post.status = 'draft' if drafting?
    @post.status = 'publish' if publishing?
    @post.status = nil if unpublishing?
  end

  def publishing?
    params[:commit] == 'Publish'
  end

  def unpublishing?
    params[:commit] == 'Unpublish'
  end

  def drafting?
    params[:commit] == 'Draft'
  end
end
