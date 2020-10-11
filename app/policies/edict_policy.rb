class EdictPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    admin_or_contributor?
  end

  def create?
    admin_or_contributor?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
