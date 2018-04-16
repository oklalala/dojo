# frozen_string_literal: true

class CreateFollowships < ActiveRecord::Migration[5.2]
  def change
    create_table :followships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :accept
      t.timestamps
    end
  end
end
