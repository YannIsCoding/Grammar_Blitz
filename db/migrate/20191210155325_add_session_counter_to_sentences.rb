class AddSessionCounterToSentences < ActiveRecord::Migration[5.2]
  def change
    add_column :sentences, :session_counter, :integer
  end
end
