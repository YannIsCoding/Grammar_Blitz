class AddSuccessesCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :successes_count, :integer, default: 0
  end
end
