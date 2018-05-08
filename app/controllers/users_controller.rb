# frozen_string_literal: true

# @@
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show comment collect draft friend]
  def show
    @posts = @user.posts.all
  end

  def comment
    @comments = @user.comments.all
  end

  def collect
    @collected_posts = @user.collected_posts.all
  end

  def draft
    @posts = @user.posts.where(status: 'draft')
  end

  def friend
    @waiting = @user.waiting
    @accept_or_not = @user.accept_or_not
    @friends = @user.all_friends
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
      flash[:alert] = "#{@user.name} was failed to update"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :intro, :avatar)
  end
end
