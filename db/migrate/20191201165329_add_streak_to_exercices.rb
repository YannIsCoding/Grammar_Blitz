class AddStreakToExercices < ActiveRecord::Migration[5.2]
  def change
    add_column :exercices, :streak, :integer
  end
end
