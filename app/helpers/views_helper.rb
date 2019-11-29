module ViewsHelper
  def profile_picture(user)
    return user.photo.url if user.photo.url

    'https://res.cloudinary.com/duw2hqlo3/image/upload/v1574262704/pechrvswkps6hqjoovqr.jpg'
  end

  def already_tried(user, exercice)
    exercice.result == false && !ProgressTracker.where(exercice: exercice, user: user).empty?
  end

  def success(user, exercice)
    exercice.result == true && !ProgressTracker.where(exercice: exercice, user: user).empty?
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end
end
