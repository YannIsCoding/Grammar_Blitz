class Sentence < ApplicationRecord
  belongs_to :user
  belongs_to :exercice
  has_many :trials

  before_create :default_word_indexes

  private

  def default_word_indexes
    self.word_indexes = exercice.hide_index
  end
end
