class Trial < ApplicationRecord
  belongs_to :progress_tracker
  belongs_to :user, through: :progress_tracker, counter_cache: true

  validates :success, inclusion: { in: [true, false] }
end
