class RemoveResultSentenceEnglishFromExercices < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercices, :result, :boolean
    remove_column :exercices, :sentence, :string
    remove_column :exercices, :english, :string
  end
end
