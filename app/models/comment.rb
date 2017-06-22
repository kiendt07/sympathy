class Comment < ApplicationRecord
  has_many :likes, as: :likeable

  scope :new_first, (->{order created_at: :desc})
  belongs_to :user
  delegate :name, to: :user, prefix: true
  belongs_to :post
  validates :content, presence: true

  attr_accessor :notification
  after_save :save_notification
end
