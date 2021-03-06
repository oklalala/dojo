# frozen_string_literal: true

# hahaha
class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_post, only: %i[show edit update destroy collect uncollect]
  impressionist action: %i[show index]
  def index
    @search = Post.authority(current_user).ransack(params[:q])
    @posts = @search.result.includes(:comments).page(params[:page]).per(20)
    # @search.build_condition
    @categories = Category.all
  end

  def show
    @comments = @post.comments.page(params[:page]).per(20)
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.last_reply_at = Time.now
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
    @post.last_reply_at = Time.now
    if @post.update(post_params)
      post_redirect(@post)
    else
      render :edit
      flash[:alert] = "#{@post.title} was failed to update"
    end
  end

  def destroy
    @post.destroy
    flash[:alert] = "#{@post.title} destroyed"
    redirect_to root_path
  end

  def feeds
    @posts = Post.authority(current_user).order(comments_count: :desc).limit(10)
    @users = User.order(comments_count: :desc).limit(10)
  end

  def collect
    Collect.create!(post: @post, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def uncollect
    collects = Collect.where(post: @post, user: current_user)
    collects.destroy_all
    redirect_back(fallback_location: root_path)
  end

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
                                 :last_reply_at, category_ids: [])
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
    @post.status = 'draft' if params[:commit] == 'Draft'
    @post.status = 'publish' if params[:commit] == 'Publish'
    @post.status = nil if params[:commit] == 'Unpublish'
  end
end
