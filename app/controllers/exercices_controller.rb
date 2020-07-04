require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @exercices = Exercice.all.order(:created_at)
  end

  def setup
    @exercice = Exercice.find(params[:id])
    @sentence = Sentence.where(user: current_user, exercice: @exercice).last || Sentence.create(user: current_user, exercice: @exercice)
  end
end
