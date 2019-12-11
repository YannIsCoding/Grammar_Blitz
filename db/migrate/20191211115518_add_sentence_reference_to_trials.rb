class AddSentenceReferenceToTrials < ActiveRecord::Migration[5.2]
  def change
    add_reference :trials, :sentence, foreign_key: true
  end
end
