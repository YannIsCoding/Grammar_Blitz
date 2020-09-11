class Trial < ApplicationRecord
  belongs_to :user
  belongs_to :exercice
  belongs_to :sentence
  belongs_to :verb, optional: true

  enum result: %i[success fail temp]
end
