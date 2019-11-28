class AddIndexToProgressTracker < ActiveRecord::Migration[5.2]
  def change
    add_index :progress_trackers, [:user_id, :exercice_id], unique: true
  end
end
