class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can :manage, Post
      can :manage, Comment
    end
    can [:create, :destroy], Like, user_id: user.id
  end
end
