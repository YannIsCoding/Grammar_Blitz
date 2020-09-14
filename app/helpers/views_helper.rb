module ViewsHelper
  def profile_picture(user)
    return user.photo.url if user.photo.url

    'https://res.cloudinary.com/duw2hqlo3/image/upload/v1576242617/no_photo_icon_yeh1fp.png'
  end

  def global_success_for(user, number_days)
    time_frame = (Time.zone.now.midnight - number_days.day)..Time.zone.now.midnight + 1.day
    Trial.where(user: user, result: :correct, created_at: time_frame).count
  end

  def global_precentage_for(user, number_days)
    time_frame = (Time.zone.now.midnight - number_days.day)..Time.zone.now.midnight + 1.day
    trials = Trial.where(user: user,
                         created_at: time_frame).count
    successes = Trial.where(user: user,
                            result: :success,
                            created_at: time_frame).count
    return ((successes / trials.to_f) * 100).to_i if trials.positive?

    100
  end

  def percentage_for_day(user, exercice, number_days)
    time_frame = (Time.zone.now.midnight - number_days.day)..Time.zone.now.midnight + 1.day
    trials = Trial.where(user: user,
                         exercice: exercice,
                         created_at: time_frame).count
    successes = Trial.where(user: user,
                            exercice: exercice,
                            result: :success,
                            created_at: time_frame).count
    return ((successes / trials.to_f) * 100).to_i if trials.positive?

    100
  end

  def percentage_for_batch(sentence)
    trials = sentence.trials.count
    successes = sentence.trials.where(result: :success).count
    ((successes / trials.to_f) * 100).to_i
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def active_user_class(user)
    current_user == user ? "active-user" : ""
  end


  def highlight_solution(sentence, positions)
    # splited_sentence = sentence.split(' ')
    # positions.each do |position|
    #   splited_sentence[position.to_i] = splited_sentence[position.to_i].upcase
    # end
    # splited_sentence.join(' ')
    sentence
  end

  def active_element?(word_indexes, position)
    word_indexes.include?(position)
  end
end
