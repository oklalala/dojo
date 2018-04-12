class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :contant
      t.string :photo
      t.string :status
      t.integer :replies_count
      t.integer :viewed_count
      t.string :who_can_see

      t.timestamps
    end
  end
end
