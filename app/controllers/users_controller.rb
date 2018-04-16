# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show comment collect draft friend]
  def show
    # @post = @user.posted
  end

  def comment; end

  def collect; end

  def draft; end

  def friend; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :intro, :avatar)
  end
end
