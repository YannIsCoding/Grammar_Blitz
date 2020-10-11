module PracticeSessions
  class TrialPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end

    def create?
      !!user
    end
  end
end
