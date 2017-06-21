class AddIndexToPlaylistTracks < ActiveRecord::Migration[5.0]
  def change
    add_index :playlist_tracks, :track_id
    add_index :playlist_tracks, :playlist_id
  end
end
