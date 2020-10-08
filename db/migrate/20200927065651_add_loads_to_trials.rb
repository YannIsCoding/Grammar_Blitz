class AddLoadsToTrials < ActiveRecord::Migration[5.2]
  def change
    add_column :trials, :value, :string
    add_column :trials, :english, :string
    add_reference :trials, :atomizable,  polymorphic: true
    add_reference :trials, :predecessor
  end
end
