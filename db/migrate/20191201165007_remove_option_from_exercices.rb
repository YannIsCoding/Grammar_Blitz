class RemoveOptionFromExercices < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercices, :option, :string
  end
end
