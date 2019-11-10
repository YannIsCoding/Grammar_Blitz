class ProgressTrackersController < ApplicationController
  def create
    progress_tracker = ProgressTracker.create!(user_id: current_user.id, exercice_id: params[:exercice_id], counter: 0)
    session[:success] = false
    session[:prev_sentence] = session[:german]
    if params[:response].downcase == session[:solution].downcase
      progress_tracker.counter = progress_tracker.counter + 1
      progress_tracker.save
      session[:success] = true
    end
    redirect_to exercice_path(params[:exercice_id])
  end

  def update
    session[:success] = false
    session[:prev_sentence] = session[:german]
    if params[:response].downcase == session[:solution].downcase
      progress_tracker = ProgressTracker.find(params[:id])
      progress_tracker.counter = progress_tracker.counter + 1
      progress_tracker.save
      session[:success] = true
    end
    redirect_to exercice_path(params[:exercice_id])
  end
end
