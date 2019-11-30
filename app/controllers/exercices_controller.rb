require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @exercices = Exercice.all.sort_by(&:created_at)
  end

  def show
    @exercice = Exercice.find(params[:id])
    @exercice.result = false
    exercice_correction if params[:response]
    @exercice.update_attributes SentenceBuilderService.new(@exercice).generate
    @exercice.save
  end

  private

  def exercice_correction
    @exercice.result = true
    if params[:response]&.downcase == @exercice.solution[0]&.downcase && params[:response_2]&.downcase == @exercice.solution[1]&.downcase
      successful_trial(true)
    elsif params[:response].downcase == @exercice.solution.first.downcase
      successful_trial(true)
    else
      successful_trial(false)
    end
    @exercice.prev_sentence = @exercice.sentence
    # @exercice.save
    # redirect_to exercice_path(params[:id])
  end

  def successful_trial(success)
    Trial.create!(user: current_user, exercice: @exercice, success: success)
  end
end
