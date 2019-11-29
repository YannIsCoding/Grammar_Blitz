class Trial < ApplicationRecord
  belongs_to :user
  belongs_to :exercice
  validates :success, inclusion: { in: [true, false] }
end
