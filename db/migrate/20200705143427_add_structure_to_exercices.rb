class AddStructureToExercices < ActiveRecord::Migration[5.2]
  def change
    add_column :exercices, :structure_temp, :string
  end
end
