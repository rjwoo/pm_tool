class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    # if 'current_user' is not nil then it will use it, otherwise, 'user' object will be set to a new 'User'
      user ||= User.new

      can :manage, Project do |project|
        project.user == user
      end

      can :manage, Favourite do |favourite|
        favourite.user == user
      end
      #
      # can :manage, Discussion do |discussion|
      #   discussion.user == user
      # end

      can :destroy, Comment do |comment|
        comment.user == user
      end

      if user.is_admin?
        can :manage, :all
      else
        can :read, :all
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
