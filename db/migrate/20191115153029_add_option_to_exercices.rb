class AddOptionToExercices < ActiveRecord::Migration[5.2]
  def change
      add_column :exercices, :option, :string, array: true
  end
end
