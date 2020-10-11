class ExercicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    !!user
  end

  def show?
    user.admin?
  end

  def create?
    admin_or_contributor?
  end

  def destroy?
    user.admin?
  end
end
