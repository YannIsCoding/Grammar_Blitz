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
    ['Du bist der hammer!', 'Du bist MEGA geil!', 'bärenstark!'].sample
  end

  def hide_answer(sentence, positions)
    splited_sentence = sentence.split(' ')
    positions.each do |position|
      splited_sentence[position.to_i] = '_____'#splited_sentence[position.to_i].split(//).map! { '_' }.join
    end
    splited_sentence.join(' ')
  end

  def highlight_solution(sentence, positions)
    splited_sentence = sentence.split(' ')
    positions.each do |position|
      splited_sentence[position.to_i] = splited_sentence[position.to_i].upcase
    end
    splited_sentence.join(' ')
  end

  def print_response(responses)
    message = 'You answered:'
    responses.each do |response|
      message << " #{response} -"
    end
    message[-2..-1] = ''
    message
  end
end
