class UserController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    if @user.save
      redirect_to profile_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :photo)
  end
end
