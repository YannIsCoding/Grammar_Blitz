class AddPreviousValueToSentences < ActiveRecord::Migration[5.2]
  def change
    add_column :sentences, :previous_value, :string
  end
end
