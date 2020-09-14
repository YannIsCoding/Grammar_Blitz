class AddHideIndexToEdicts < ActiveRecord::Migration[5.2]
  def change
    add_column :edicts, :hide_index, :string, array: true
  end
end
