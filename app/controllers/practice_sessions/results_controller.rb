module PracticeSessions
  class ResultsController < ApplicationController
    def show
      @practice_session = PracticeSession.find(params[:practice_session_id])
      @exercice = @practice_session.exercice
      @previous_trial = @practice_session.trials.last


      @try_again_link = new_exercice_practice_session_path(@exercice)
      current_user.update(successes_count: current_user.trials.correct_count)

      authorize @practice_session, policy_class: PracticeSessions::ResultPolicy
    end
  end
end
