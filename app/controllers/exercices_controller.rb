require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @exercices = Exercice.all
  end

  def show
    @exercice = Exercice.find(params[:id])
    @sentence = SentenceBuilderService.new(@exercice).generate
    @progress_tracker = ProgressTracker.find_by(user_id: current_user.id, exercice_id: @exercice) || ProgressTracker.new
  end

end
