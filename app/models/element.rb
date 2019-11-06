class Element < ApplicationRecord
  has_many :structures, through: :structure_element
end
