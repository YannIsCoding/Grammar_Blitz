class Trial < ApplicationRecord
  belongs_to :progress_tracker

  validates :success, inclusion: { in: [true, false]}
end
