class ChangeStructureTempName < ActiveRecord::Migration[5.2]
  def change
    rename_column :exercices, :structure_temp, :structure
  end
end
