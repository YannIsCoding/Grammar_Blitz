class AddEdictedToExercices < ActiveRecord::Migration[5.2]
  def change
    add_column :exercices, :edicted, :boolean
  end
end
