class Edict < ApplicationRecord
  belongs_to :exercice

  validates :value, :english, uniqueness: true

  # after_initialize :hide_index_default

  # private

  # def hide_index_default
  #   self.hide_index ||= exercice.hide_index
  # end
end
