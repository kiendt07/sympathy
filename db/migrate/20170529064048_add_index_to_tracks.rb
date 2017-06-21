class AddIndexToTracks < ActiveRecord::Migration[5.0]
  def change
    add_index :tracks, :user_id
  end
end
