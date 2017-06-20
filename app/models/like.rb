class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  belongs_to :post

  has_many :notifications, as: :notificationable

  after_save :recommendable_like
  after_destroy :recommendable_unlike

  private

  def recommendable_like
    self.user.bookmark self.post.original_content
  end

  def recommendable_unlike
    self.user.unbookmark self.post.original_content
  end
end
