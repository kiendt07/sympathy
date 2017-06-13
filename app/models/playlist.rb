class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlistings, dependent: :destroy
  has_many :tracks, through: :playlistings

  attr_accessor :initial_track
  after_save :add_initial_track

  private

  def add_initial_track
    self.tracks << self.initial_track
  end
end
