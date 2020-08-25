class Edict < ApplicationRecord
  belongs_to :exercice

  validates :value, :english, uniqueness: true
end
