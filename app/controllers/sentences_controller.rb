class SentencesController < ApplicationController
  protect_from_forgery unless: -> { request.format.js? }

  before_action :set_sentence, only: [:result, :save_setup]
  before_action :set_exercice, only: [:result, :save_setup]

  COMMIT_MESSAGE = 'BANG!'


  def new
    @start = true
    @exercice = Exercice.find(params[:exercice])
    # last_sentence = @sentence || Sentence.where(user: current_user, exercice: @exercice).last

    @sentence = Sentence.create!(user: current_user, exercice: @exercice)

    # Fetch the parameter from last time user practice
    # @sentence.update(word_indexes: last_sentence.word_indexes) if last_sentence
    sentence_feeder
    render :sentence
  end

  def update
    # if params[:exercice]
    #   @exercice = Exercice.find(params[:exercice])
    #   @sentence = Sentence.create!(user: current_user, exercice: @exercice)
    #   # @sentence.update(word_indexes: (@sentence.word_indexes << setup_params).flatten)
    # else
    # end
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice
    # return render :update if params[:response_0]&.empty?

    sentence_feeder
    # @start = true if params[:commit] == COMMIT_MESSAGE

    if @sentence.session_counter > SESSION_LENGTH - 1
      p @redirect = sentence_result_path
    end

    respond_to do |format|
      format.js { render :update }
    end
  end

  # def save_setup
  #   # this is updating the last sentence given by the exercice setup form
  #   @sentence.update(word_indexes: setup_params)

  #   new
  #   render :new
  # end

  private

  def exercice_correction
    # compare the answer given by to the original sentences using Regex
    @responses = response_params
    if RegexMachine.new(@responses).generate =~ @sentence.value
      @success = true
      create_trial(true)
    else
      @success = false
      create_trial(false)
    end
    @prev_sentence = @sentence.value
    @result = true
  end

  def setup_params
    ['subject', 'verb', '_article', 'noun', 'noun2'].map { |el| params[el] if params.key?(el) }.compact
  end

  def create_trial(success)
    Trial.create!(user: current_user, exercice: @exercice, success: success, sentence: @sentence)
    @sentence.streak = success ? @sentence.streak + 1 : 0
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
    if params[:commit] == COMMIT_MESSAGE
      exercice_correction
    else
      # initilize / re-initialize
      # @sentence.update(streak: 0, session_counter: 0)
      # @result = false
    end

    if @exercice.edicted?
      @edict = @exercice.edicts.sample
      @sentence.update_attributes(value: @edict.value, english: @edict.english)
    else
      @sentence.update_attributes SentenceBuilderService.new(@sentence.exercice).generate
    end

    @sentence.increment!(:session_counter)
  end

end
