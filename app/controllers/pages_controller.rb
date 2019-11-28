class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def profile
    @user = current_user
    @users = User.all
    @progress_trackers = ProgressTracker.where(user_id: @user.id)
  end
end
