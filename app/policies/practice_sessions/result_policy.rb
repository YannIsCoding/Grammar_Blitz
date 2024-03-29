module PracticeSessions
  class ResultPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end

    def show?
      !!user
    end
  end
end
