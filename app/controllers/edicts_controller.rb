class EdictsController < ApplicationController
  before_action :set_exercice, only: [:index, :create]

  def index
    @edicts = Edict.where(exercice: @exercice)
    @edict = Edict.new
  end

  def create
    @edict = Edict.new(edict_params)
    if @edict.save
      redirect_to edicts_path
    else
      @edicts = Edict.where(exercice: @exercice)
      render :index
    end
  end

  def update
    @edict = Edict.find_by_id params[:id] || Edict.new
    if @edict.update(edict_params)
      respond_to do
        format.js { render :update , status: :ok }
      end
    else
      render :index
    end
  end

  def destroy
    @edict = Edict.find params[:id]
    @edict.destroy
    redirect_to edicts_path
  end

  private

  def edict_params
    params.require(:edict).permit(:value, :english, :exercice_id)
  end

  def set_exercice
    @exercice = Exercice.find_by_id(params[:exercice]) || Exercice.find_by(structure: 's_v_do_mit')
    @exercices = Exercice.edicted
  end
end
