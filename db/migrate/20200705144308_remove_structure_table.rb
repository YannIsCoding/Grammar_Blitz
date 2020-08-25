class RemoveStructureTable < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :exercices, column: :structure_id
    remove_foreign_key :edicts, column: :structure_id
    remove_foreign_key :structure_elements, column: :structure_id
    drop_table :structures

  end
end
