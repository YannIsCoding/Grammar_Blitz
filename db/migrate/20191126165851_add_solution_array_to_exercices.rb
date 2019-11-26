class AddSolutionArrayToExercices < ActiveRecord::Migration[5.2]
  def change
    add_column :exercices, :solution, :string, array: true
  end
end
