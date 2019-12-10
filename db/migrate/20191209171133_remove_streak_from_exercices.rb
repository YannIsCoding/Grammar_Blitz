class RemoveStreakFromExercices < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercices, :streak, :integer
  end
end
