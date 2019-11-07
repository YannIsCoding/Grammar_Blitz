class CreateProgressTrackers < ActiveRecord::Migration[5.2]
  def change
    create_table :progress_trackers do |t|
      t.string :counter

      t.timestamps
    end
  end
end
