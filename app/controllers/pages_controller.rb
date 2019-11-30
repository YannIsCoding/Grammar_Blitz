class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def profile
    @user = current_user
    @ranking = User.group(:id).left_outer_joins(:trials).count(success = true).sort_by(&:last).reverse

    @exercices = @user.exercices.uniq
  end
end
