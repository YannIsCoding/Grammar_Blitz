# require_relative '../services/sentence_builder_service'
class ExercicesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @exercices = policy_scope(Exercice).automated.order(:created_at)
    @verb_exercices = policy_scope(Exercice).with_verb
    @edicted = policy_scope(Exercice).edicted
  end

  def show
    @exercice = Exercice.find(params[:id])
    authorize @exercice
  end

  def new
    @exercice = Exercice.new
    authorize @exercice
  end

  def create
    @exercice = Exercice.new(exercice_params)
    authorize @exercice
    @exercice.edicted = true
    if @exercice.save
      redirect_to exercice_edicts_path(@exercice)
    else
      render :new
    end
  end

  def edit
    @exercice = Exercice.find(params[:id])
    authorize @exercice

    render :new
  end

  def update
    @exercice = Exercice.find(params[:id])
    authorize @exercice
    if @exercice.update(exercice_params)
      redirect_to exercice_edicts_path(@exercice)
    else
      render :new
    end
  end

  def destroy
    @exercice = Exercice.find(params[:id])
    authorize @exercice
    @exercice.destroy

    redirect_to exercice_edicts_path(Exercice.first)
  end

  private

  def exercice_params
    params.require(:exercice).permit(:structure,
                                     :name,
                                     :description)
  end
end
