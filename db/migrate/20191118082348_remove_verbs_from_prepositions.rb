class RemoveVerbsFromPrepositions < ActiveRecord::Migration[5.2]
  def change
    remove_column :prepositions, :verbs, :string
  end
end
