class Structure < ApplicationRecord
  has_many :element, through: :structure_element
end
