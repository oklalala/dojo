# rubocop
class CommentsController < ApplicationController
  # before_action :set_comment, only: %i[update destroy]

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'comment was successfully created'
    else
      flash.now[:alert] = 'Did you miss something?'
      @users = User.order(followers_count: :desc).limit(10)
      @comments = comment.order(created_at: :desc)
    end
    redirect_to post_path(@post)
  end

  def edit
    @user = User.find(params[:id])
    @comment = @user.comments.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    @comment = @user.comments.find(params[:id])
    @comment.update_attributes(comment_params)
  end

  def destroy
    @user = User.find(params[:id])
    @comment = @user.comments.find(params[:user_id])
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    # puts "enter the strong params"
    params.require(:comment).permit(:content)
  end
end
