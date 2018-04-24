# rubocop
class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

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

  def edit; end

  def update
    if @comment.update(post_params)
      redirect_to post_path(@comment.post)
      flash[:notice] = "#{@comment.post.title} was successfully updated"
    else
      render :edit
      flash[:alert] = "#{@comment.post.title} was failed to update"
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
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
