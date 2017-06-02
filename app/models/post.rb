class Post < ApplicationRecord
  belongs_to :user
  delegate :name, to: :user, prefix: true

  scope :new_first, ->{order created_at: :desc}
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, as: :notificationable
end
