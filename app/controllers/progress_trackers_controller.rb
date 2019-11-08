class ProgressTrackersController < ApplicationController
  def create
    ProgressTracker.create!(user_id: current_user.id, exercice_id: params[:exercice_id], counter: 1)
    redirect_to exercice_path(params[:exercice_id])
  end

  def update
    @success = false
    if params[:response].downcase == params[:solution]
      progress_tracker = ProgressTracker.find(params[:id])
      progress_tracker.counter = progress_tracker.counter + 1
      progress_tracker.save
      @success = true
    end
    redirect_to exercice_path(params[:exercice_id], success: @success, solution: params[:solution])
  end
end
