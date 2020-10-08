class ModifyTrials < ActiveRecord::Migration[5.2]
  def change
    remove_reference :trials, :sentence, index: true
    add_reference :trials, :practice_session, index: true
    remove_reference :trials, :exercice, index: true
    remove_reference :trials, :verb, index: true
  end
end
