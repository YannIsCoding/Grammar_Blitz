class PracticeSessions::ResultsController < ApplicationController
  def show
    @practice_session = PracticeSession.find(params[:practice_session_id])
    @exercice = @practice_session.exercice
    @try_again_link = new_exercice_practice_session_path(@exercice)
  end
end