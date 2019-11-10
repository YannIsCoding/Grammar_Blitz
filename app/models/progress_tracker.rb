class ProgressTracker < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :exercice
end
