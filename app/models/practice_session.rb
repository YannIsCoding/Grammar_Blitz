class PracticeSession < ApplicationRecord
  SESSION_LENGTH = 10

  belongs_to :atomizable, polymorphic: true, optional: true
  belongs_to :exercice
  belongs_to :user

  has_many :trials

  before_create :init_streak_and_counter

  def finished?
    counter > SESSION_LENGTH
  end

  def not_finished?
    !finished?
  end

  private

  def init_streak_and_counter
    self.streak = 0
    self.counter = 1
  end
end
