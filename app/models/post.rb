class Post < ApplicationRecord
  belongs_to :user
  delegate :name, :email, to: :user, prefix: true

  scope :new_first, (->{order created_at: :desc})
  scope :ost_feeds, -> (following_ids, user_id){where "user_id IN (?) OR
    user_id = ?", following_ids, user_id}

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, as: :notificationable
  belongs_to :content, polymorphic: true

  def original_post
    post = self
    post = post.content while post.content.is_post?
    post
  end

  def original_content
    self.original_post.content
  end
end
