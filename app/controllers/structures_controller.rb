class StructuresController < ApplicationController
  def new
    @structure = Structure.new
  end

  def create
    @structure = Structure.new(structure_params)
    if @structure.update(edicted: true)
      redirect_to edicts_path
    else
      render :new
    end
  end

  def structure_params
    params.require(:structure).permit(:name)
  end
end
