class AddElementRefToStructureElements < ActiveRecord::Migration[5.2]
  def change
    add_reference :structure_elements, :element, foreign_key: true
  end
end
