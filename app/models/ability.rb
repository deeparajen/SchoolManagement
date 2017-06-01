class Ability
  include CanCan::Ability
  

  def initialize(user)
   
    if user.role? :admin
      can :manage, :all
    elsif user.role?(:Staff)
        can :read, :all
        can :assign_class, Teacher
        can :update_class_teacher, Teacher
        can :update_grade,Teacher
        can :create_sms, SendSms
        # can :update, Article do |article|
          # article.try(:user) == user
        # end
    else
        can :read, :all
    end
   
  end

end
