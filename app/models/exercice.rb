class Exercice < ApplicationRecord
  belongs_to :structure

  validates :name, :description, presence: true
  validates :name, :description, uniqueness: true
end
