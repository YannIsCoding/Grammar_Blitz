class AddStreakToSentences < ActiveRecord::Migration[5.2]
  def change
    add_column :sentences, :streak, :integer
  end
end
