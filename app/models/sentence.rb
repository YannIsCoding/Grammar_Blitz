class Sentence < ApplicationRecord
  SESSION_LENGTH = 3

  belongs_to :exercice
  belongs_to :user
  belongs_to :atomizable, polymorphic: true, optional: true
  has_many :trials

  before_create :init_streak_and_counter

  def finished?
    session_counter > SESSION_LENGTH
  end

  def not_finished?
    !finished?
  end

  private

  def init_streak_and_counter
    self.streak = 0
    self.session_counter = 0
  end
end
