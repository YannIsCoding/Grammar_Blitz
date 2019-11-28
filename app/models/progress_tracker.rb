class ProgressTracker < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :exercice
  has_many :trials

  validates :user_id, uniqueness: { scope: :exercice_id,
                                    message: "Progress tracker already exists for given user and exercise" }

  def percentage_for_day(number_days)
    time_frame = Time.zone.now.midnight..(Time.zone.now.midnight + number_days.day)
    trials = Trial.where(progress_tracker: self,
                         created_at: time_frame).count
    successes = Trial.where(progress_tracker: self,
                            success: true,
                            created_at: time_frame).count
    return ((successes / trials.to_f) * 100).to_i if trials.positive?

    100
  end
end
