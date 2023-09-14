# app/models/ability.rb
class Ability
    include CanCan::Ability
  
    def initialize(user)
        user ||= User.new  # Guest user
      
        if user.admin?
          can :manage, :all  # Admins can manage all resources
        else
          can :read, Recipe  # Regular users can read recipes
          # Define other rules as needed
        end
      end
  end
  