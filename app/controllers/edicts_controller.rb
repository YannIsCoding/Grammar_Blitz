class EdictsController < ApplicationController

  before_action :set_structure, only: [:index, :create]

  def index
    @edicts = Edict.where(structure: @structure)
    @edict = Edict.new
  end

  def create
    @edict = Edict.new(edict_params)
    if @edict.save
      redirect_to edicts_path
    else
      p @edict.errors
      @edicts = Edict.where(structure: @structure)
      render :index
    end
  end

  def update
    @edict = Edict.find_by_id params[:id] || Edict.new
    if @edict.update(edict_params)
      respond_to do

        format.js { render :update  , status: :ok }
        # render 'update.js.erb'
      end
    else
      render :index
    end
  end

private

  def edict_params
    params.require(:edict).permit(:value, :english, :structure_id)
  end

  def set_structure
    @structure = Structure.find_by_id(params[:structure])
    @structure ||= Structure.find_by_name('s_v_do_mit')
    @structures = Structure.where(edicted: true)
  end
end
