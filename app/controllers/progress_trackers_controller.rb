class ProgressTrackersController < ApplicationController
  def create
    @progress_tracker = ProgressTracker.create!(user_id: current_user.id, exercice_id: params[:exercice_id], counter: 0)
    exercice_correction
  end

  def update
    @progress_tracker = ProgressTracker.find(params[:id])
    exercice_correction
  end

  def exercice_correction
    @exercice = Exercice.find(params[:exercice_id])
    @exercice.result = false
    if params[:response].downcase == @exercice.solution.downcase
      update_progress_tracker
      @exercice.result = true
    end
    @exercice.prev_sentence = @exercice.sentence
    @exercice.save
    redirect_to exercice_path(params[:exercice_id])
  end

  private

  def update_progress_tracker
    @progress_tracker.counter = @progress_tracker.counter + 1
    @progress_tracker.save
  end
end
