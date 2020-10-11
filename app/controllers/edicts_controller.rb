class EdictsController < ApplicationController
  before_action :set_exercice, only: %i[index create update destroy]
  before_action :set_edict, only: %i[update destroy]

  def index
    @edicts = Edict.where(exercice: @exercice)
    @edict = Edict.new(exercice: @exercice)
  end

  def create
    @edict = Edict.new(edict_params.merge(exercice: @exercice))
    @edict.hide_index = edict_params[:hide_index].scan(/\d/)

    if @edict.save
      redirect_to exercice_edicts_path(@exercice)
    else
      @edicts = Edict.where(exercice: @exercice)
      render :index
    end
  end

  def update
    array = edict_params[:hide_index].scan(/\d/)
    @edict.hide_index = array

    if @edict.update(edict_params)
      @edict.hide_index = edict_params[:hide_index].scan(/\d/)
      @edict.save
      respond_to do |format|
        format.js { render :update, status: :ok }
      end
    else
      @edicts = Edict.where(exercice: @exercice)
      render :index
    end
  end

  def destroy
    @edict.destroy
    redirect_to exercice_edicts_path(@exercice)
  end

  private

  def edict_params
    params.require(:edict).permit(:value, :english, :hide_index)
  end

  def set_edict
    @edict = Edict.find params[:id]
  end

  def set_exercice
    @exercice = Exercice.find(params[:exercice_id])
    @exercices = Exercice.edicted
  end
end
