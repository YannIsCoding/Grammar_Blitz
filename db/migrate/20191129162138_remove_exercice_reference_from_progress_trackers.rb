class RemoveExerciceReferenceFromProgressTrackers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :progress_trackers, :user, index: true, foreign_key: true
    remove_reference :progress_trackers, :exercice, index: true, foreign_key: true
  end
end
