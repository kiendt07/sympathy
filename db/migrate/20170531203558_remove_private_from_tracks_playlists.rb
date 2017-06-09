class RemovePrivateFromTracksPlaylists < ActiveRecord::Migration[5.0]
  def change
    remove_column :tracks, :is_private
    remove_column :playlists, :is_private
  end
end
