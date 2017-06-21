class RenamePlaylistTrack < ActiveRecord::Migration[5.0]
  def change
    rename_table :playlist_tracks, :playlists_tracks
  end
end
