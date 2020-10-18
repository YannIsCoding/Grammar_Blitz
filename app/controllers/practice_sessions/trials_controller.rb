module PracticeSessions
  class TrialsController < ApplicationController
    def create
      @practice_session = PracticeSession.find(params[:practice_session_id])

      exercice_correction

      @practice_session.increment!(:counter)

      if @practice_session.finished?
        redirect_to practice_session_result_path(@practice_session)
      else

        @trial = Trial.create!(user: current_user,
                               practice_session: @practice_session,
                               predecessor: @previous_trial)
        sentence_feeder unless @practice_session.finished?


        respond_to do |format|
          format.js { render :new }
        end
      end
        authorize [:practice_sessions, @trial]
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

    def exercice_correction
      @previous_trial = @practice_session.trials.last
      correction = ExerciceCorrector.new(trial: @previous_trial, params: params)
      @responses = correction.answers
      @previous_trial.update(result: correction.review)
      @practice_session.streak = @previous_trial.correct? ? @practice_session.streak + 1 : 0
    end
  end
end
