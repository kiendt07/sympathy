class User < ApplicationRecord
  recommends :tracks, :playlists, :users

  devise :omniauthable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable

  has_many :identities
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :real_likes, dependent: :destroy, class_name: "Like"
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
      self.email.nil? && identity.email
    self.update_attributes name: identity.name if
      self.name.nil? && identity.name
    self.update_attributes avatar: identity.image if
      self.avatar.nil? && identity.image
    if self.persisted?
      identity.update_attributes user_id: self.id
      return FormUser.find self.id
    else
      return self
    end
  end

  def facebook_link
    identity = identities.find_by provider: "facebook"
    "https://www.facebook.com/#{identity.uid}" if
      identity.present?
  end

  def follow other_user
    following << other_user
  end

  def following_ids
    self.active_relationships.where(follower_id: self.id).map(&:id)
  end

  def like? post
    self.real_likes.find_by(post_id: post.id) ? true : false
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def relationship_with user
    self.active_relationships.find_by followed_id: user.id
  end

  def recommended_or_top type
    method_name = "recommended_#{type.pluralize}"
    class_object = type.singularize.capitalize.constantize
    if self.send(method_name).any?
      self.send(method_name, 3)
    else
      class_object.top(count: 3)
    end
  end

  def feeds
    Post.ost_feeds following_ids, id
  end
end
