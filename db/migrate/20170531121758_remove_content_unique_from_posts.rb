class RemoveContentUniqueFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_index :posts, [:content_id, :content_type]
    add_index :posts, [:content_id, :content_type]
  end
end
