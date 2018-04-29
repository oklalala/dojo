# frozen_string_literal: true

class AddCommentCountInUserAndPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :comment_count, :integer, default: 0
    add_column :users, :comment_count, :integer, default: 0
  end
end
