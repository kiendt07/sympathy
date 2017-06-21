class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: User.name
  belongs_to :notificationable, polymorphic: true
  belongs_to :user
end
