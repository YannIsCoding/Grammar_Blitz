module ViewsHelper
  def profile_picture(user)
    return user.photo.url if user.photo.url

    'https://res.cloudinary.com/duw2hqlo3/image/upload/v1574262704/pechrvswkps6hqjoovqr.jpg'
  end

  def already_tried(user, exercice)
    Trial.where(exercice: exercice, user: user).length.positive?
  end

  def success(user, exercice)
    Trial.where(exercice: exercice, user: user).last&.success
  end

  def percentage_for_day(user, exercice, number_days)
    time_frame = (Time.zone.now.midnight - number_days.day)..Time.zone.now.midnight + 1.day
    trials = Trial.where(user: user,
                         exercice: exercice,
                         created_at: time_frame).count
    successes = Trial.where(user: user,
                            exercice: exercice,
                            success: true,
                            created_at: time_frame).count
    return ((successes / trials.to_f) * 100).to_i if trials.positive?

    100
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def active_user_class(user)
    current_user == user ? "active-user" : ""
  end

  def show_streak?(streak)
    (streak % 5).zero? && !streak.zero?
  end

  def streak_congratulation
    ['Du bist der hammer!', 'Du bist GIGA geil!'].sample
  end
end
