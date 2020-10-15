class AddPublishedToExercices < ActiveRecord::Migration[5.2]
  def up
    add_column :exercices, :published, :boolean, default: false
    Exercice.update_all(published: true)
  end

  def down
    remove_column :exercices, :published, :boolean, default: false
  end
end
