class CreateTrials < ActiveRecord::Migration[5.2]
  def change
    create_table :trials do |t|
      t.boolean :success
      t.references :progress_tracker, foreign_key: true

      t.timestamps
    end
  end
end
