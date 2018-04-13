class RenameContentInPost < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :contant, :content
    rename_column :comments, :contant, :content
    rename_column :posts, :replies_count, :comments_count
    remove_column :posts, :category_id
  end
end
