class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new
    if user.isadmin
      can :manage, :all
    else
      can :create,  Booking
      can :destroy, Booking
    end
 end
end
