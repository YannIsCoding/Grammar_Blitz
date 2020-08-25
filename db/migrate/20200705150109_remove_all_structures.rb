class RemoveAllStructures < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercices, :structure_id
    remove_column :edicts, :structure_id
    remove_column :structure_elements, :structure_id
  end
end
