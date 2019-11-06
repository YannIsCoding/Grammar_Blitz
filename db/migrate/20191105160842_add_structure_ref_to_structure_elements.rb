class AddStructureRefToStructureElements < ActiveRecord::Migration[5.2]
  def change
    add_reference :structure_elements, :structure, foreign_key: true
  end
end
