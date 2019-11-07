class AddStructureRefToExercices < ActiveRecord::Migration[5.2]
  def change
    add_reference :exercices, :structure, foreign_key: true
  end
end
