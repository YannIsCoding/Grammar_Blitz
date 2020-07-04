class Sentence < ApplicationRecord
  belongs_to :user
  belongs_to :exercice
  has_many :trials

  before_save :default_word_indexes

  # validates :word_indexes, presence: true

  private

  def default_word_indexes
    self.word_indexes ||= exercice.hide_index
  end
end
