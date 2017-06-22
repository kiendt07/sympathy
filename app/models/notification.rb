class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: User.name
  belongs_to :notificationable, polymorphic: true
  belongs_to :user

  delegate :content, to: :notificationable, prefix: true

  scope :newest_first, ->{order created_at: :desc}

  def reference_to
    case self.notificationable.class_name
    when "Comment"
      notificationable.post
    when "Relationship"
      notificationable.follower
    when "Like"
      notificationable.post
    end
  end
end
