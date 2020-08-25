class AddExercicesToEdict < ActiveRecord::Migration[5.2]
  def change
    add_reference :edicts, :exercice, index: true
  end
end
