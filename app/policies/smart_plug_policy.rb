class SmartPlugPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def entry?
    user == User.find(1)
  end

  def show?
    true
  end
end
