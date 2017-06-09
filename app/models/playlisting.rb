class Playlisting < ApplicationRecord
  self.table_name = "playlists_tracks"
  belongs_to :playlist
  belongs_to :track

  delegate :name, to: :track, prefix: true
  delegate :name, to: :playlist, prefix: true

  validates :track, uniqueness: {scope: :playlist}
end
