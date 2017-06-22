class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  belongs_to :post

  has_many :notifications, as: :notificationable, dependent: :destroy

  after_save :recommendable_like
  after_destroy :recommendable_unlike

  attr_accessor :notification
  after_save :save_notification

  private

  def recommendable_like
    self.user.bookmark self.post.original_content
  end

  def recommendable_unlike
    self.user.unbookmark self.post.original_content
  end
end
