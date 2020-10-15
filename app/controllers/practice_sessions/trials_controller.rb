module PracticeSessions
  class TrialsController < ApplicationController
    def create
      # TODO: Debug, somewhere the hide_index is not being past or is empty.
      @practice_session = PracticeSession.find(params[:practice_session_id])
      @previous_trial = @practice_session.trials.last

      correction = ExerciceCorrector.new(trial: @previous_trial, params: params)
      @responses = correction.answers
      @previous_trial.update(result: correction.review)
      @practice_session.streak = @previous_trial.correct? ? @practice_session.streak + 1 : 0
      @trial = Trial.create!(user: current_user,
                             practice_session: @practice_session,
                             predecessor: @previous_trial)
      authorize [:practice_sessions, @trial]
      sentence_feeder unless @practice_session.finished?
      @practice_session.increment!(:counter)

      @redirect = practice_session_result_path(@practice_session) if @practice_session.finished?

      respond_to do |format|
        format.js { render :new }
      end
    end

    private

    def sentence_feeder
      if @trial.exercice.edicted?
        @edict = @trial.exercice.edicts.sample
        @trial.update_attributes(value: @edict.value,
                                 english: @edict.english,
                                 edict: @edict)
      else
        @trial.update_attributes SentenceBuilderService.new(@exercice).generate
        @hide_index = @exercice.hide_index
      end
    end
  end
end
