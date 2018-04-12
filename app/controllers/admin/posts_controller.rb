# frozen_string_literal: true

module Admin
  # say someting
  class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin
    def index; end

    private

    def authenticate_admin
      unless current_user.admin?
        flash[:alert] = 'Not allow!'
        redirect_to root_path
      end
    end
  end
end
