class AddSentenceToExercices < ActiveRecord::Migration[5.2]
  def change
    add_column :exercices, :sentence, :string
    add_column :exercices, :prev_sentence, :string
    add_column :exercices, :english, :string
    add_column :exercices, :solution, :string
    add_column :exercices, :obfus, :string
    add_column :exercices, :result, :boolean
  end
end
