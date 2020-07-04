class Edict < ApplicationRecord
  belongs_to :structure

  validates :value, :english, uniqueness: true
end
