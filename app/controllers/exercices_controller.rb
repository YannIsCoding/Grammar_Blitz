require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @exercices = Exercice.all.order(:created_at)
  end

  def show
    @exercice = Exercice.find(params[:id])
    @exercice.result = false
    params[:response] ? exercice_correction : @exercice.streak = 0
    @exercice.update_attributes SentenceBuilderService.new(@exercice).generate
  end

  private

  def exercice_correction
    @exercice.result = true
    if text_cleaner(params[:response]) == text_cleaner(@exercice.solution[0]) &&
       text_cleaner(params[:response_2]) == text_cleaner(@exercice.solution[1]) ||
       text_cleaner(params[:response]) == text_cleaner(@exercice.solution.first) && params[:response_2].nil?
      create_trial(true)
    else
      create_trial(false)
      @answer_one = params[:response]
      @answer_two = params[:response_2] if params[:response_2]
    end
    @exercice.prev_sentence = @exercice.sentence
  end

  def create_trial(success)
    Trial.create!(user: current_user, exercice: @exercice, success: success)
    @exercice.streak = success ? @exercice.streak + 1 : 0
  end

  def text_cleaner(answer)
    answer&.downcase&.strip
  end
end
