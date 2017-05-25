class Track < ApplicationRecord
  belongs_to :user
  belongs_to :playlist_track, optional: true
  has_many :posts, as: :content

  validates :url, :format => URI::regexp(%w(http https))

  def is_embed?
    self.url.include?("mp3.zing.vn")
  end

  def is_file?
    !is_embed?
  end

  def get_code_from_embed_url
    if is_embed?
      self.url.split("/")[-1].split(".")[0]
    else
      nil
    end
  end
end
