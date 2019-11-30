class Trial < ApplicationRecord
  belongs_to :user
  belongs_to :exercice
  validates :success, inclusion: { in: [true, false] }

  def self.successes_count
    where(success: true).count
  end
end
