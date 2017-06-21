class AddIndexToPosts < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, [:content_id, :content_type], unique: true
  end
end
