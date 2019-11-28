class ProgressTracker < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :exercice
  has_many :trials

  validates :user_id, uniqueness: { scope: :exercice_id,
                                    message: "Progress tracker already exists for given user and exercise" }

  def daily_trials
    Trial.where(progress_tracker: self,
                created_at: Time.zone.now.midnight..(Time.zone.now.midnight + 1.day)).count
  end

  def daily_successes
    Trial.where(progress_tracker: self,
                success: true,
                created_at: Time.zone.now.midnight..(Time.zone.now.midnight + 1.day)).count
  end

  def daily_percentage
    return ((daily_successes / daily_trials.to_f) * 100).to_i if daily_trials.positive?

    100
  end
end
