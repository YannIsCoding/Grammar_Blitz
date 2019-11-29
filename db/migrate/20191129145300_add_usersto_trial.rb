class AddUserstoTrial < ActiveRecord::Migration[5.2]
  def change
    add_reference :trials, :user, foreign_key: true
    add_reference :trials, :exercice, foreign_key: true
    remove_reference :trials, :progress_tracker, index: true, foreign_key: true
  end
end
