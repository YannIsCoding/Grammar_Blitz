class EdictsController < ApplicationController
  before_action :set_exercice, only: %i[index create destroy]

  def index
    @edicts = Edict.where(exercice: @exercice)
    @edict = Edict.new(exercice: @exercice)
  end

  def create
    @edict = Edict.new(edict_params)
    @edict.hide_index = params.require(:edict).permit(:hide_index)[:hide_index].scan(/\d/)

    if @edict.save
      redirect_to exercice_edicts_path(@exercice)

    else
      @edicts = Edict.where(exercice: @exercice)
      render :index
    end
  end

  def update
    @edict = Edict.find_by_id params[:id] || Edict.new
    if @edict.update(edict_params)
      respond_to do |format|
        format.js { render :update, status: :ok }
      end
    else
      render :index
    end
  end

  def destroy
    @edict = Edict.find params[:id]
    @edict.destroy
    redirect_to exercice_edicts_path(@exercice)
  end

  private

  def edict_params
    params.require(:edict).permit(:value, :english).merge(exercice: @exercice)
  end

  def set_exercice
    @exercice = Exercice.find(params[:exercice_id])
    @exercices = Exercice.edicted
  end
end
