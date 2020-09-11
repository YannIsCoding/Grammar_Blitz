class CreateBuckets < ActiveRecord::Migration[5.2]
  def change
    create_table :buckets do |t|
      t.references :user, foreign_key: true
      t.integer :level
      t.references :verb, foreign_key: true

      t.timestamps
    end
  end
end
