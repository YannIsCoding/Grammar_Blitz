class RemoveSolutionFromExercices < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercices, :solution, :string
  end
end
