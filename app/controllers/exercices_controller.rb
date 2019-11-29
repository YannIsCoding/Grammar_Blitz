require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @exercices = Exercice.all.sort_by(&:created_at)
  end

  def show
    exercice_correction if params[:response]
    @exercice = Exercice.find(params[:id])
    @exercice.update_attributes SentenceBuilderService.new(@exercice).generate
    @exercice.save

    # @progress_tracker = ProgressTracker.find_by(user: current_user, exercice: @exercice) || ProgressTracker.new
  end

  private

  def exercice_correction
    @exercice = Exercice.find(params[:id])
    @exercice.result = false
    if params[:response]&.downcase == @exercice.solution[0]&.downcase && params[:response_2]&.downcase == @exercice.solution[1]&.downcase
      successful_trial
    elsif params[:response].downcase == @exercice.solution.first.downcase
      successful_trial
    else
      Trial.create!(user: current_user, exercice: @exercice, success: false)
    end
    @exercice.prev_sentence = @exercice.sentence
    @exercice.save
    redirect_to exercice_path(params[:id])
  end

  def successful_trial
    @exercice.result = true
    Trial.create!(user: current_user, exercice: @exercice, success: true)
  end
end
