class AddLastReplyInPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :last_reply_at, :date, default: :created_at
  end
end
