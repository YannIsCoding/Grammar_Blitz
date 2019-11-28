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
    if @exercice.solution.length == 2
      update_progress_tracker if params[:response].downcase == @exercice.solution[0].downcase && params[:response_2].downcase == @exercice.solution[1].downcase
    elsif params[:response].downcase == @exercice.solution.first.downcase
      update_progress_tracker
    else
      Trial.create!(progress_tracker: @progress_tracker, success: false)
    end
    @exercice.prev_sentence = @exercice.sentence
    @exercice.save
    redirect_to exercice_path(params[:exercice_id])
  end

  private

  def update_progress_tracker
    @progress_tracker.counter = @progress_tracker.counter + 1
    @progress_tracker.save
    @exercice.result = true
    Trial.create!(progress_tracker: @progress_tracker, success: true)
  end
end
