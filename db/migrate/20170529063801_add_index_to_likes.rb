class AddIndexToLikes < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, :user_id
    add_index :likes, :post_id
    add_index :likes, [:likeable_id, :likeable_type], unique: true
  end
end
