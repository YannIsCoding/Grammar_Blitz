class Structure < ApplicationRecord
  has_many :elements, through: :structure_elements, dependent: :destroy
  has_many :structure_elements
  has_many :exercices, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
end
