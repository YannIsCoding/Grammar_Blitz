class CreateStructureElements < ActiveRecord::Migration[5.2]
  def change
    create_table :structure_elements do |t|
      t.integer :position

      t.timestamps
    end
  end
end
