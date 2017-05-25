class User < ApplicationRecord
  devise :omniauthable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable

  has_many :identities
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  def match_with identity
    self.update_attributes email: identity.email if
      self.email? && identity.email
    self.update_attributes name: identity.name if
      self.name? && identity.name
    self.update_attributes avatar: identity.image if
      self.avatar? && identity.image
    if self.persisted?
      identity.update_attributes user_id: self.id
      return FormUser.find self.id
    else
      return self
    end
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end
end
