class StructureElement < ApplicationRecord
  belongs_to :structure
  belongs_to :element
  validates :position, :element_id, :structure_id, presence: true
end
