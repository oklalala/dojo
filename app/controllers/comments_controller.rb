# rubocop
class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "comment was successfully created"
    else
      flash.now[:alert] = "Did you miss something?"
      @users = User.order(followers_count: :desc).limit(10)
      @comments = comment.order(created_at: :desc)
    end
    redirect_to comments_path
  end

  private

  def comment_params
    # puts "enter the strong params"
    params.require(:comment).permit(:content)
  end
end
