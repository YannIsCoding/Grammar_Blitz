class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def profile
    @user = current_user
    @users = User.all
    @exercices = Exercice.all
  end
end
