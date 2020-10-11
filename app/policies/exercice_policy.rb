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
    admin_or_contributor?
  end

  def create?
    admin_or_contributor?
  end

  def update?
    create?
  end

  def destroy?
    user.admin?
  end
end
