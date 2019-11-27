class ProgressTracker < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :exercice
  has_many :trials

  def daily_trials
    time_range = (Time.now.midnight - 1.day)..Time.now.midnight
    Trial.where(progress_tracker: self, 'created_at' => time_range).count
  end

  def daily_successes
    time_range = (Time.now.midnight - 1.day)..Time.now.midnight
    Trial.where(progress_tracker: self, success: true, 'created_at' => time_range).count
  end

  def daily_percentage
    ((daily_successes / daily_trials.to_f) * 100).to_i
  end

end
