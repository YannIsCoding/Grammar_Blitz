class StructureElement < ApplicationRecord
  belongs_to :structure
  belongs_to :element
  validates :position, presence: true
end
