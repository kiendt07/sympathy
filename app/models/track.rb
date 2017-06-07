class Track < ApplicationRecord
  belongs_to :user
  belongs_to :playlist_track, optional: true
  has_many :posts, as: :content

  attr_accessor :is_private
  after_save :save_new_post

  validates :url, format: URI.regexp(%w(http https))

  def is_embed?
    self.url.include? "mp3.zing.vn"
  end

  def get_code_from_embed_url
    self.url.split("/")[-1].split(".")[0] if is_embed?
  end

  private

  def save_new_post
    self.posts.create user: self.user, is_private: self.is_private
  end
end
