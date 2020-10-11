class MassiveCleanup < ActiveRecord::Migration[5.2]
  def change
    # drop_table :progress_trackers
    drop_table :structure_elements

    remove_column :sentences, :value
    remove_column :sentences, :english
    remove_column :sentences, :word_indexes
    remove_column :sentences, :previous_value

    change_table :sentences do |t|
      t.remove_references :atomizable, :polymorphic => true
    end
  end
end
