class PracticeSessionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.js? }

  def new
    @start = true
    @exercice = Exercice.find(params[:exercice_id])
    @practice_session = PracticeSession.create!(user: current_user, exercice: @exercice)
    @trial = Trial.create(user: current_user,
                          practice_session: @practice_session)
    sentence_feeder
    render 'practice_sessions/trials/new'
  end

  private

  def sentence_feeder
    if @exercice.edicted?
      @edict = @exercice.edicts.sample
      @trial.update_attributes(value: @edict.value,
                               english: @edict.english,
                               edict: @edict)
    else
      @trial.update_attributes SentenceBuilderService.new(@exercice).generate
      @hide_index = @exercice.hide_index
    end
  end
end
