class VerbPracticesController < ApplicationController
  def new
    @start = true # TODO: Replace with existence of predecessor on @trial
    @exercice = Exercice.find(params[:exercice_id])
    @sentence = Sentence.create(user: current_user, exercice: @exercice)
    @trial = Trial.create(user: current_user,
                          exercice: @exercice,
                          sentence: @sentence)
    @trial = VerbPractice.new(trial: @trial).launch
    @sentence.increment!(:session_counter)
    render :sentence
  end

  def update
    @sentence = Sentence.find(params[:id])
    @exercice = @sentence.exercice
    @sentence.increment!(:session_counter)
    @previous_trial = @sentence.trials.last

    correction = ExerciceCorrector.new(trial: @previous_trial, params: params)
    @previous_trial.update(result: correction.review)
    @responses = correction.answers

    if @sentence.not_finished?
      @trial = Trial.create!(user: current_user,
                             exercice: @exercice,
                             sentence: @sentence,
                             predecessor: @previous_trial)
      @trial = VerbPractice.new(trial: @trial).continue
      respond_to do |format|
        format.js { render :update }
      end
    else
      @redirect = verb_result_path(@sentence)
      render js: "window.location='#{@redirect}'"
    end
  end

  def result
    BucketFiller.new(Trial.where(sentence: @sentence)).go
    @try_again_link = exercice_verb_practice_path(@exercice)
  end

  # private

  # def fetch_trial(type)
  #   @trial = Trial.find_by(sentence: @sentence,
  #                          result: :running)
  #   @trial.update(result: type)
  #   super
  # end
end
