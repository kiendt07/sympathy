class AddUrlToTracks < ActiveRecord::Migration[5.0]
  def change
    add_column :tracks, :url, :string
  end
end
