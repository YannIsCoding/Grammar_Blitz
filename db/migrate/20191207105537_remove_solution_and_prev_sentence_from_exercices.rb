class RemoveSolutionAndPrevSentenceFromExercices < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercices, :solution, :string
    remove_column :exercices, :prev_sentence, :string
  end
end
