class RenameSentenceToPracticeSession < ActiveRecord::Migration[5.2]
  def change
    rename_table :sentences, :practice_sessions
    rename_column :practice_sessions, :session_counter, :counter
  end
end
