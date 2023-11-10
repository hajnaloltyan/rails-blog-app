class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'user'
      can :manage, Post, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :create, Like, user_id: user.id
    else
      cannot :create, Post
      cannot :create, Comment
      cannot :create, Like
      can :read, :all
    end
  end
end
