class ChangeColumnNameInPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :comments_count
    rename_column :users, :comment_count, :comments_count
    rename_column :posts, :comment_count, :comments_count
  end
end
