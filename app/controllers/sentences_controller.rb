class SentencesController < ApplicationController
  before_action :set_sentence, only: [:update, :result]
  before_action :set_exercice, only: [:update, :result]

  def update
    @sentence.update(word_indexes: (@sentence.word_indexes << setup_params).flatten) if @sentence.session_counter.zero?
    params[:response_0] ? exercice_correction : @sentence.streak = 0 && @result = false
    @sentence.update_attributes SentenceBuilderService.new(@sentence.exercice).generate
    @sentence.increment!(:session_counter)
    redirect_to sentence_result_path if @sentence.session_counter > 10
  end

  def result
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

  def setup_params
    ['subject', 'verb', '_article', 'noun', 'noun2'].map { |el| params[el] if params.key?(el) }.compact
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

  def set_sentence
    @sentence = Sentence.find(params[:id])
  end

  def set_exercice
    @exercice = @sentence.exercice
  end
end
