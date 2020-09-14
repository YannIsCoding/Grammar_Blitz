class AddDefaultToEdictExercice < ActiveRecord::Migration[5.2]
  def change
    change_column :exercices, :edicted, :boolean, default: false
    Exercice.where(edicted: nil).update_all(edicted: false)
  end
end
