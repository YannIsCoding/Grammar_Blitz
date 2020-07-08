require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def new
    @exercice = Exercice.new
  end

  def create
    @exercice = Exercice.new(exercice_params)
    @exercice.edicted = true
    if @exercice.save
      redirect_to edicts_path
    else
      render :new
    end
  end

  def index
    @exercices = Exercice.all.order(:created_at)
  end

  def setup
    @exercice = Exercice.find(params[:id])
    @sentence = Sentence.where(user: current_user, exercice: @exercice).last || Sentence.create(user: current_user, exercice: @exercice)
  end

  private

  def exercice_params
    params.require(:exercice).permit(:structure, :name, :description)
  end
end
