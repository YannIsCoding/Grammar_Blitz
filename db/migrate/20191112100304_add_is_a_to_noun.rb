class AddIsAToNoun < ActiveRecord::Migration[5.2]
  def change
    add_column :nouns, :is_a, :string
  end
end
