# require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @exercices = Exercice.automated.order(:created_at)
    @verb_exercices = Exercice.with_verb
    @edicted = Exercice.edicted
  end

  def new
    @exercice = Exercice.new
  end

  def create
    @exercice = Exercice.new(exercice_params)
    @exercice.edicted = true
    if @exercice.save
      redirect_to exercice_edicts_path(@exercice)
    else
      render :new
    end
  end

  private

  def exercice_params
    params.require(:exercice).permit(:structure,
                                     :name,
                                     :description)
  end
end
