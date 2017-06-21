class AddIndexToPlaylists < ActiveRecord::Migration[5.0]
  def change
    add_index :playlists, :user_id
  end
end
