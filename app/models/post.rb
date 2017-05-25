class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :likes, as: :likeable
  has_many :notifications, as: :notificationable
  belongs_to :content, polymorphic: true
end
