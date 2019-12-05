class AddHideIndexToExercices < ActiveRecord::Migration[5.2]
  def change
    add_column :exercices, :hide_index, :string, array: true
  end
end
