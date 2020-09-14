class SentencesController < ApplicationController
  protect_from_forgery unless: -> { request.format.js? }

  before_action :set_sentence, only: %i[result save_setup]
  before_action :set_exercice, only: %i[result save_setup]

  COMMIT_MESSAGE = 'BANG!'

  def new
    @start = true
    @exercice = Exercice.find(params[:exercice])

    @sentence = Sentence.create!(user: current_user, exercice: @exercice)

    sentence_feeder
    render :sentence
  end

  def update
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice

    sentence_feeder

    if @sentence.session_counter > SESSION_LENGTH - 1
      @redirect = sentence_result_path
    end

    respond_to do |format|
      format.js { render :update }
    end
  end

  def result
    @try_again_link = new_sentence_path(exercice)
  end

  private

  def exercice_correction
    # compare the answer given by to the original sentences using Regex
    @responses = response_params
    if RegexMachine.new(@responses).generate =~ @sentence.value
      @success = true
      create_trial(:success)
    else
      @success = false
      create_trial(:fail)
    end
    @prev_sentence = @sentence.value
    @result = true
  end

  def setup_params
    ['subject', 'verb', '_article', 'noun', 'noun2'].map { |el| params[el] if params.key?(el) }.compact
  end

  def create_trial(type)
    @trial ||= Trial.create!(user: current_user,
                          exercice: @exercice,
                          result: type,
                          sentence: @sentence)
    @sentence.streak = @trial.success? ? @sentence.streak + 1 : 0
  end

  def response_params
    # Sanitize the user's answers
    @sentence.word_indexes.map do |index|
      if params["response_#{index}"]&.strip&.empty?
        'nothing'
      else
        # filter anything that isnt allowed characters
        params["response_#{index}"]&.gsub(/[^0-9A-Za-zäÄöÖüÜß]/, '')
      end
    end
  end

  def set_sentence
    @sentence = Sentence.find(params[:id])
  end

  def set_exercice
    @exercice = @sentence.exercice
  end

  def sentence_feeder
    exercice_correction if params[:commit] == COMMIT_MESSAGE

    if @exercice.edicted?
      @edict = @exercice.edicts.sample
      @sentence.update_attributes(value: @edict.value, english: @edict.english)
    else
      @sentence.update_attributes SentenceBuilderService.new(@sentence.exercice).generate
    end

    @sentence.increment!(:session_counter)
  end
end
