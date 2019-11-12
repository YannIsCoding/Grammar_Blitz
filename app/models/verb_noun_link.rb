class VerbNounLink < ApplicationRecord
  belongs_to :noun
  belongs_to :verb
  validates :noun_id, :verb_id, presence: true
end
