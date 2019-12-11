class Trial < ApplicationRecord
  belongs_to :user
  belongs_to :exercice
  belongs_to :sentence
  validates :success, inclusion: { in: [true, false] }
end
