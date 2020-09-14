class AddDefaultToBucketLevel < ActiveRecord::Migration[5.2]
  def change
    change_column :buckets, :level, :integer, default: 0
  end
end
