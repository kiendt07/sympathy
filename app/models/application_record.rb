class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def class_name
    self.class.name.demodulize
  end

  def is_track?
    self.class.name.demodulize == "Track"
  end

  def is_playlist?
    self.class.name.demodulize == "Playlist"
  end

  def is_post?
    self.class.name.demodulize == "Post"
  end
end
