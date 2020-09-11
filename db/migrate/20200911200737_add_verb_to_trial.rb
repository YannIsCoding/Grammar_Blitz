class AddVerbToTrial < ActiveRecord::Migration[5.2]
  def change
    add_reference :trials, :verb, foreign_key: true
  end
end
