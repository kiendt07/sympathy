class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def class_name
    self.class.name.demodulize
  end

  def is_track?
    self.class.name.demodulize == "Track"
  end

  def is_playlist?
    self.class.name.demodulize == "Playlist"
  end

  def is_post?
    self.class.name.demodulize == "Post"
  end

  def save_notification
    case self.class_name
    when "Relationship"
      notification = self.followed.notifications.create notified_by: follower,
        notice_type: "followed", notificationable: self
    when "Comment"
      notification = self.post.user.notifications.create notified_by: self.user,
        notice_type: "commented", notificationable: self
    when "Like"
      notification = self.post.user.notifications.create notified_by: self.user,
        notice_type: "liked", notificationable: self
    end
    self.notification = notification
  end
end
