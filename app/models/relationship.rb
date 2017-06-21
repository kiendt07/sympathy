class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_save :recommendable_follow
  after_destroy :recommendable_unfollow

  private

  def recommendable_follow
    follower.like followed
  end

  def recommendable_unfollow
    follower.unlike followed
  end
end
