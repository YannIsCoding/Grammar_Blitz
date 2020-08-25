class Sentence < ApplicationRecord
  belongs_to :user
  belongs_to :exercice
  has_many :trials

  before_save :default_word_indexes
  before_create :init_streak_and_counter

  private

  def default_word_indexes
    self.word_indexes ||= exercice.hide_index
  end

  def init_streak_and_counter
    self.streak = 0
    self.session_counter = 0
  end

end
