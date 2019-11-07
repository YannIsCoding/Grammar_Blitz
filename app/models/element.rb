class Element < ApplicationRecord
  has_many :structures, through: :structure_elements, dependent: :destroy
  has_many :structure_elements

  validates :value, presence: true
  validates :value, uniqueness: true
end
