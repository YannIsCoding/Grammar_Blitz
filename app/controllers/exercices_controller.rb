require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @exercices = Exercice.all.sort_by(&:created_at)
  end

  def show
    @exercice = Exercice.find(params[:id])
    @exercice.update_attributes SentenceBuilderService.new(@exercice).generate
    @exercice.save

    @progress_tracker = ProgressTracker.find_by(user: current_user, exercice: @exercice) || ProgressTracker.new
  end
end
