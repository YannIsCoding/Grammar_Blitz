require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_exercice, only: [:show, :setup]
  before_action :set_sentence, only: [:show, :setup]
  def index
    @exercices = Exercice.all.order(:created_at)
  end

  def show
    params[:response_0] ? exercice_correction : @sentence.streak = 0 && @result = false
    @sentence.update_attributes SentenceBuilderService.new(@exercice).generate
    reset_params_response
  end

  def setup
    @sentence.update(word_indexes: @sentence.exercice.hide_index)
    @sentence.update(word_indexes: (@sentence.word_indexes << setup_params).flatten)
    redirect_to exercice_path(@exercice)
  end

  private

  def exercice_correction
    if RegexMachine.new(response_params).generate =~ @sentence.value
      create_trial(true)
    else
      create_trial(false)
      @responses = response_params
    end
    @prev_sentence = @sentence.value
    @result = true
  end

  def create_trial(success)
    Trial.create!(user: current_user, exercice: @exercice, success: success)
    @sentence.streak = success ? @sentence.streak + 1 : 0
  end

  def response_params
    @sentence.word_indexes.map.with_index do |_el, index|
      params["response_#{index}"]&.strip&.empty? ? 'nothing' : params["response_#{index}"]&.gsub(/[^0-9A-Za-zäÄöÖüÜß]/, '')
    end
  end

  def set_exercice
    @exercice = Exercice.find(params[:id])
  end

  def set_sentence
    @sentence = Sentence.find_or_create_by(user: current_user, exercice: @exercice)
  end

  def setup_params
    ['subject', 'verb', '_article', 'noun', 'noun2'].map { |el| params[el] if params.key?(el) }.compact
  end

  def reset_params_response
    params.each do |param|
      param.delete if param.key.include('response')
    end
  end
end
