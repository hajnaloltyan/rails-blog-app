class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.present?
      can :manage, Post, user_id: user.id
      can :manage, Comment, user_id: user.id
      can :create, Like
    else
      can :read, :all
    end
  end
end
