class Track < ApplicationRecord
  belongs_to :user
  belongs_to :playlist_track
end
