class Exercice < ApplicationRecord
  belongs_to :structure
  has_many :trials
  has_many :users, through: :trials

  validates :name, :description, presence: true
  validates :name, :description, uniqueness: true
end
