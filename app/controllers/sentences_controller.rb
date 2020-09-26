class SentencesController < ApplicationController
  protect_from_forgery unless: -> { request.format.js? }

  before_action :set_sentence, only: %i[result]
  before_action :set_exercice, only: %i[result]

  COMMIT_MESSAGE = 'BANG!'

  def new
    @start = true
    @exercice = Exercice.find(params[:exercice_id])
    @sentence = Sentence.create!(user: current_user, exercice: @exercice)

    sentence_feeder
    render :sentence
  end

  def update
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice

    # unless first time exercice correction
    exercice_correction
    sentence_feeder unless @sentence.session_finish?
    @sentence.increment!(:session_counter)

    if @sentence.session_finish?
      @redirect = sentence_result_path
    end

    respond_to do |format|
      format.js { render :update }
    end
  end

  def result
    # set_sentence
    # set_exercice
    @try_again_link = new_exercice_sentence_path(@exercice)
  end

  private

  def exercice_correction
    # compare the answer given by to the original sentences using Regex
    # @responses = response_params
    # result = RegexMachine.new(@responses).generate =~ @sentence.value
    correction = ExerciceCorrector.new(sentence: @sentence, params: params)
    @responses = correction.answers
    result = correction.review
    create_trial(result)
    # @prev_sentence = @sentence.value
  end

  def create_trial(result)
    @trial ||= Trial.create!(user: current_user,
                             exercice: @exercice,
                             result: result,
                             sentence: @sentence)
    @sentence.streak = @trial.correct? ? @sentence.streak + 1 : 0
  end

  # def response_params
  #   # Sanitize the user's answers
  #   @sentence.word_indexes.map do |index|
  #     if params["response_#{index}"]&.strip&.empty?
  #       'nothing'
  #     else
  #       # filter anything that isnt allowed characters
  #       params["response_#{index}"]&.gsub(/[^0-9A-Za-zäÄöÖüÜß]/, '')
  #     end
  #   end
  # end

  def set_sentence
    @sentence = Sentence.find(params[:id])
  end

  def set_exercice
    @exercice = @sentence.exercice
  end

  def sentence_feeder
    if @exercice.edicted?
      @edict = @exercice.edicts.sample
      @sentence.update_attributes(value: @edict.value,
                                  english: @edict.english,
                                  word_indexes: @edict.hide_index)
    else
      @sentence.update_attributes SentenceBuilderService.new(@sentence.exercice).generate
    end

  end
end
