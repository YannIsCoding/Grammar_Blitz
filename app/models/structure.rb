class Structure < ApplicationRecord
  has_many :elements, through: :structure_elements, dependent: :destroy
  has_many :structure_elements
  has_many :exercices, dependent: :destroy
  has_many :edicts

  validates :name, presence: true
  validates :name, uniqueness: true

  def edicted
    self.edicted || false
  end
end
