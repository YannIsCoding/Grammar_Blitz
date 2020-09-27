class AddEdictToTrials < ActiveRecord::Migration[5.2]
  def change
    add_reference :trials, :edict, foreign_key: true
  end
end
