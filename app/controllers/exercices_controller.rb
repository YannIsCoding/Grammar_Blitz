require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @exercices = Exercice.all.order(:created_at)
  end

  def show
    @exercice = Exercice.find(params[:id])
    @exercice.result = false
    params[:response_0] ? exercice_correction : @exercice.streak = 0
    @exercice.update_attributes SentenceBuilderService.new(@exercice).generate
  end

  private

  def exercice_correction
    @exercice.result = true
    if RegexMachine.new(response_params).generate =~ @exercice.sentence
      create_trial(true)
    else
      create_trial(false)
      @responses = response_params
    end
    @prev_sentence = @exercice.sentence
  end

  def create_trial(success)
    Trial.create!(user: current_user, exercice: @exercice, success: success)
    @exercice.streak = success ? @exercice.streak + 1 : 0
  end

  def text_cleaner(answer)
    answer&.downcase&.strip
  end

  def response_params
    @exercice.hide_index.map.with_index do |_el, index|
      params["response_#{index}".to_sym]
    end
  end
end
